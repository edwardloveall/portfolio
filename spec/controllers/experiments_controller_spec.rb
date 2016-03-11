require 'rails_helper'

RSpec.describe ExperimentsController do
  describe '#index' do
    it 'assigns objects to @objects' do
      objects = [S3File.new(key: 'file.rb'), S3Directory.new(prefix: 'tests/')]
      allow(S3Client).to receive(:objects).and_return(objects)

      get :index

      expect(assigns[:objects]).to eq(objects)
    end
  end

  describe '#show' do
    it 'renders the index view' do
      allow(S3Client).to receive(:objects)

      get :show, path: 'code/'

      expect(response).to render_template(:index)
    end

    context 'with a single folder path' do
      it 'assigns objects to @objects' do
        objects = [S3File.new(key: 'code/file.rb'),
                   S3Directory.new(prefix: 'code/tests/')]
        allow(S3Client).to receive(:objects).and_return(objects)

        get :show, path: 'code/'

        expect(assigns[:objects]).to eq(objects)
      end
    end

    context 'with a nested path' do
      it 'assigns objects to @objects' do
        objects = [S3File.new(key: 'code/ruby/file.rb'),
                   S3Directory.new(prefix: 'code/ruby/tests/')]
        allow(S3Client).to receive(:objects).and_return(objects)

        get :show, path: 'code/ruby/'

        expect(assigns[:objects]).to eq(objects)
      end
    end
  end
end
