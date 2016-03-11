class S3Client
  def self.objects(path: nil)
    new.objects(path: path)
  end

  def objects(path: nil)
    @prefix = sanitize_prefix(path)
    @objects = client.list_objects(params)
    files + directories
  end

  private

  attr_accessor :prefix

  def client
    @client ||= Aws::S3::Client.new
  end

  def sanitize_prefix(path)
    return if path.nil?
    if path.ends_with?('/')
      path
    else
      "#{path}/"
    end
  end

  def params
    {
      bucket: S3::BUCKET_NAME,
      delimiter: S3::DELIMITER
    }.merge(prefix)
  end

  def prefix
    if @prefix.present?
      { prefix: @prefix }
    else
      {}
    end
  end

  def directories
    prefixes = @objects.common_prefixes.map(&:prefix)
    prefixes.map do |prefix|
      S3Directory.new(prefix: prefix)
    end
  end

  def files
    keys = @objects.contents.each.map(&:key)
    if @prefix.present?
      keys.shift
    end
    keys.map do |key|
      S3File.new(key: key)
    end
  end
end
