require 'rails_helper'

RSpec.describe SongsController do
  describe '#index' do
    it 'assigns all songs to @songs' do
      songs = double(:songs)
      allow(Song).to receive(:all).and_return(songs)

      get :index

      expect(assigns[:songs]).to eq(songs)
    end

    it 'renders the index page' do
      allow(Song).to receive(:all)

      get :index

      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    it 'assigns the song to @song' do
      song = double(:song)
      allow(Song).to receive(:find).and_return(song)

      get :show, id: 1

      expect(assigns[:song]).to eq(song)
    end

    it 'renders the show template' do
      allow(Song).to receive(:find)

      get :show, id: 1

      expect(response).to render_template(:show)
    end
  end
end
