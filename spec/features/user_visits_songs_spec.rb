require 'rails_helper'

RSpec.feature 'User visits songs' do
  scenario 'sees list of songs' do
    song = create(:song)

    visit '/'
    click_on('Music')

    expect(page).to have_link(song.title, href: song_path(song))
  end

  scenario 'navigates to a particular song' do
    song = create(:song)

    visit songs_path
    click_on song.title

    expect(current_path).to eq(song_path(song))
  end

  scenario 'user sees the song page' do
    title = 'Music!'
    description = 'A Song!'
    song = create(:song, title: title, description: description)

    visit song_path(song)

    expect(page).to have_css('.song-title', text: title)
    expect(page).to have_css('.description', text: description)
  end
end
