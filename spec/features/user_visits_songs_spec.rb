require 'rails_helper'

RSpec.feature 'User visits songs' do
  scenario 'sees list of songs' do
    song = create(:song)

    visit '/'
    click_on('Music')

    expect(page).to have_link(song.title, href: song_path(song))
  end

  scenario 'user sees the song page' do
    song = create(:song)

    visit song_path(song)

    expect(page).to have_content(song.title)
    expect(page).to have_content(song.description)
  end
end
