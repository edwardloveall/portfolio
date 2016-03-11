require 'rails_helper'

RSpec.describe S3Client do
  describe '.objects' do
    context 'with no path' do
      it 'returns directories and files at the root level' do
        expected = [
          S3File.new(key: 'file.rb'),
          S3Directory.new(prefix: 'tests/')
        ]
        s3_structure = { contents: ['file.rb'], common_prefixes: ['tests/'] }
        stub_s3(s3_structure)

        objects = S3Client.objects

        expect(objects).to match_array(expected)
      end
    end

    context 'with a path' do
      context 'that has a trailing slash' do
        it 'returns directories and files from that path' do
          expected = [
            S3File.new(key: 'code/file.rb'),
            S3Directory.new(prefix: 'code/tests/')
          ]
          s3_structure = {
            contents: ['code/', 'code/file.rb'],
            common_prefixes: ['code/tests/'] }
          stub_s3(s3_structure, prefix: 'code/')

          objects = S3Client.objects(path: 'code/')

          expect(objects).to match_array(expected)
        end
      end

      context 'path that does not have a trailing slash' do
        it 'returns directories and files from that path' do
          expected = [
            S3File.new(key: 'code/file.rb'),
            S3Directory.new(prefix: 'code/tests/')
          ]
          s3_structure = {
            contents: ['code/', 'code/file.rb'],
            common_prefixes: ['code/tests/'] }
          stub_s3(s3_structure, prefix: 'code/')

          objects = S3Client.objects(path: 'code')

          expect(objects).to match_array(expected)
        end
      end
    end
  end
end
