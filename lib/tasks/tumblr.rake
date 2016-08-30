namespace :tumblr do
  desc 'Import all posts from tumblr into database (indempotent)'
  task import_posts: 'db:migrate' do
    api_key = ENV.fetch('TUMBLR_API_KEY')
    fetcher = TumblrFetcher.new(api_key: api_key)
    post_data = fetcher.posts

    creator = PostCreator.new(json: post_data)
    creator.perform
  end

  class TumblrFetcher
    TUMBLR_POSTS_URL = 'https://api.tumblr.com/v2/blog'

    attr_reader :api_key, :blog_id, :post_type

    def initialize(api_key:)
      @api_key = api_key
      @blog_id = 'edwardloveall'
      @post_type = 'text'
    end

    def posts
      url = URI("#{TUMBLR_POSTS_URL}/#{blog_id}/posts/#{post_type}?api_key=#{api_key}&filter=raw")
      response = Net::HTTP.get(url)
      JSON.parse(response)
    end
  end

  class PostCreator
    attr_reader :json

    def initialize(json:)
      @json = json
    end

    def perform
      post_attributes.each do |attributes|
        post = Post.create(attributes)
        if post.errors.present?
          puts post.errors.full_messages
        else
          puts "Imported #{post.title}"
        end
      end
    end

    def post_attributes
      post_array = json['response']['posts']
      attributes = post_array.map do |post|
        body = body_sanitizer(post['body'])
        created_at = Time.at(post['timestamp'])
        {
          created_at: created_at,
          updated_at: created_at,
          title: post['title'],
          body: body,
          slug: post['slug'],
          tumblr_guid: post['id']
        }
      end
    end

    def body_sanitizer(body)
      body.gsub('&lt;', '<')
          .gsub('&gt;', '>')
          .gsub(/<pre class="highlight \b(.+)\b"><code>/) { "```#{$1}\n" }
          .gsub(/<\/code><\/pre>/, '```')
    end
  end
end
