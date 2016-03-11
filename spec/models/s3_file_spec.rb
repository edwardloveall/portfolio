require 'app/models/s3_file'
require 'config/initializers/s3' if !defined?(S3)

RSpec.describe S3File do
  describe '#initialize' do
    it 'sets the attrs' do
      file = S3File.new(key: '/ruby/code.rb')

      expect(file.key).to eq('/ruby/code.rb')
      expect(file.title).to eq('code.rb')
    end
  end

  describe 'comparable' do
    it 'is equal if the keys are the same' do
      file1 = S3File.new(key: 'code/file.rb')
      file2 = S3File.new(key: 'code/file.rb')
      file3 = S3File.new(key: 'code/test.rb')

      expect(file1).to eq(file2)
      expect(file1).not_to eq(file3)
    end
  end
end
