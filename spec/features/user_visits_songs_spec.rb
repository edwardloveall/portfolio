require 'rails_helper'

RSpec.feature 'User visits songs' do
  scenario 'user sees the song page' do
    song = create(:song)

    visit music_path(song)

    expect(page).to have_content(song.title)
    expect(page).to have_content(song.description)
  end
end
