require 'app/models/s3_directory'
require 'config/initializers/s3' if !defined?(S3)

RSpec.describe S3Directory do
  describe '#initialize' do
    it 'sets the attrs' do
      file = S3Directory.new(prefix: 'ruby/app/')

      expect(file.prefix).to eq('ruby/app/')
      expect(file.title).to eq('app')
    end
  end

  describe 'comparable' do
    it 'is equal if the prefixes are the same' do
      dir1 = S3Directory.new(prefix: 'code/app')
      dir2 = S3Directory.new(prefix: 'code/app')
      dir3 = S3Directory.new(prefix: 'code/tests')

      expect(dir1).to eq(dir2)
      expect(dir1).not_to eq(dir3)
    end
  end
end
