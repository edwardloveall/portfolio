class S3Directory
  include Comparable
  attr_accessor :prefix, :title

  def initialize(prefix:)
    @prefix = prefix
    @title = @prefix.split(S3::DELIMITER).last
  end

  def <=>(other)
    other.prefix <=> prefix
  end

  def to_partial_path
    'experiments/directory'
  end
end
