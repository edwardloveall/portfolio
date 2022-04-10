require "rails_helper"

describe Post do
  it { should belong_to(:postable) }
  it { should delegate_method(:created_at).to(:postable) }
  it { should delegate_method(:updated_at).to(:postable) }
  it { should delegate_method(:guid).to(:postable) }

  describe ".newest_first" do
    it "returns postable objects from newest to oldest" do
      ep1 = create(:external_post, posted_on: 4.day.ago)
      ip3 = create(:internal_post, created_at: 3.days.ago)
      ip1 = create(:internal_post, created_at: 1.day.ago)
      ip2 = create(:internal_post, created_at: 2.days.ago)
      post4 = create(:post, postable: ep1)
      post3 = create(:post, postable: ip3)
      post1 = create(:post, postable: ip1)
      post2 = create(:post, postable: ip2)

      posts = Post.newest_first

      expect(posts).to eq([post1, post2, post3, post4])
    end

    it "avoids n+1 queries for associated postable objects" do
      sql_count = 3 # load posts + preload all external + preload all internal
      create_list(:post, 2, :internal)
      create_list(:post, 2, :external)
      counter = SqlCounter.new

      ActiveSupport::Notifications.subscribed(counter, "sql.active_record") do
        posts = Post.newest_first
        posts.each(&:postable)
      end

      expect(counter.count).to eq(sql_count)
    end
  end

  class SqlCounter
    def initialize
      @events = []
    end

    def call(*args)
      event = ActiveSupport::Notifications::Event.new(*args)
      return if event.payload[:name] == "SCHEMA"
      @events << event
    end

    def count
      @events.count
    end
  end
end
