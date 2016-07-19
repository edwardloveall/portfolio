require 'rails_helper'

RSpec.describe Admin::SongsController do
  describe '#index' do
    it 'assigns all songs to @songs' do
      songs = double(:songs)
      allow(Song).to receive(:all).and_return(songs)

      get :index

      expect(assigns[:songs]).to eq(songs)
    end
  end

  describe '#new' do
    it 'assigns a new @song' do
      get :new

      expect(assigns[:song]).to be_a_new(Song)
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'creates a song' do
        song_count = Song.count

        post :create, song: attributes_for(:song)

        expect(Song.count).to eq(song_count + 1)
      end

      it 'redirects to the song index' do
        post :create, song: attributes_for(:song)

        expect(response).to redirect_to(admin_songs_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a song' do
        song_count = Song.count

        post :create, song: { title: nil }

        expect(Song.count).to eq(song_count)
      end

      it 'renders the new form' do
        post :create, song: { title: nil }

        expect(response).to render_template(:new)
      end

      it 'shows the error flash' do
        post :create, song: { title: nil }
        error_flash = I18n.t('flashes.song.create.error')

        expect(flash[:error]).to eq(error_flash)
      end
    end
  end

  describe '#edit' do
    it 'assigns the song to @song' do
      song = create(:song)

      get :edit, id: song

      expect(assigns[:song]).to eq(song)
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      it 'changes the song' do
        song = create(:song, title: 'A title')
        params = attributes_for(:song)

        put :update, id: song, song: params
        song.reload

        expect(song.title).to eq(params[:title])
        expect(song.description).to eq(params[:description])
      end

      it 'redirects to the song index' do
        song = create(:song, title: 'A title')
        params = attributes_for(:song)

        put :update, id: song, song: params

        expect(response).to redirect_to(admin_songs_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not edit the song' do
        song = create(:song)
        params = { title: nil }

        put :update, id: song, song: params

        expect(song.title).not_to be_nil
      end

      it 'renders the edit form' do
        song = create(:song)
        params = { title: nil }

        put :update, id: song, song: params

        expect(response).to render_template(:edit)
      end

      it 'shows the flash' do
        song = create(:song)
        params = { title: nil }
        error_flash = I18n.t('flashes.song.update.error')

        put :update, id: song, song: params

        expect(flash[:error]).to eq(error_flash)
      end
    end
  end

  describe '#delete' do
    context 'when a song can be deleted' do
      it 'deletes the song' do
        song = create(:song)
        song_count = Song.count

        delete :destroy, id: song

        expect(Song.count).to eq(song_count - 1)
      end

      it 'redirects to the song index' do
        song = create(:song)

        delete :destroy, id: song

        expect(response).to redirect_to(admin_songs_path)
      end
    end

    context 'when a song can not be deleted' do
      it 'does not delete the song' do
        song_count = Song.count
        song = create(:song)

        delete :destroy, id: song

        expect(Song.count).to eq(song_count)
      end

      it 'shows the flash on the song index' do
        song = create(:song)
        allow(song).to receive(:destroy).and_return(false)
        allow(Song).to receive(:find).and_return(song)
        error_flash = I18n.t('flashes.song.delete.error')

        delete :destroy, id: song

        expect(flash[:error]).to eq(error_flash)
      end
    end
  end
end