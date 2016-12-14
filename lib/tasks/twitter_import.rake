namespace :twitter do
  desc 'Import tweets to microblog'
  task import_tweets: 'db:migrate' do
    require 'csv'
    path = Pathname.new(ARGV.last).expand_path
    parser = TwitterParser.new(path: path)
    tweet_data = parser.tweets

    Micropost.create(tweet_data)
  end

  class TwitterParser
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def tweets
      storage = []
      options = { headers: true, header_converters: :symbol }
      data = CSV.read(path, options)
      data.each do |tweet|
        next if retweet?(tweet)
        next if mention?(tweet)
        attributes = {
          body: body(tweet),
          created_at: created_at(tweet),
          updated_at: updated_at(tweet)
        }
        storage << attributes
      end
      storage
    end

    def retweet?(tweet)
      tweet[:retweeted_status_id].present?
    end

    def mention?(tweet)
      tweet[:text].start_with?('@')
    end

    def body(tweet)
      text = tweet[:text]
      text = convert_links(text, tweet[:expanded_urls])
      text = sanitize_hashtags(text)
    end

    def convert_links(text, urls_text)
      return text if urls_text.blank?
      urls = urls_text.split(',').uniq
      text.gsub(/(https?:\/\/t.co\/\w+)/).each_with_index do |_, i|
        "[#{urls[i]}](#{urls[i]})"
      end
    end

    def sanitize_hashtags(text)
      text.gsub(/#/, '&#35;')
    end

    def created_at(tweet)
      Time.parse(tweet[:timestamp])
    end

    def updated_at(tweet)
      created_at(tweet)
    end
  end
end
