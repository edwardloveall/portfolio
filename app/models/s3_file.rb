class S3File
  include Comparable
  attr_accessor :key, :title

  def initialize(key:)
    @key = key
    @title = key.split(S3::DELIMITER).last
  end

  def <=>(other)
    other.key <=> key
  end

  def to_partial_path
    'experiments/file'
  end
end
