require 'rails_helper'

RSpec.feature 'Admin song management' do
  scenario 'admin creates a song' do
    sign_in(create(:user))
    attributes = attributes_for(:song)
    attributes.delete(:audio)
    audio = Rails.root.join('spec', 'fixtures', 'song.mp3')

    visit new_admin_song_path

    attach_file('Audio', audio)
    fill_form_and_submit(:song, :new, attributes)

    expect(page).to have_content(attributes[:title])
  end

  scenario 'admin updates a song' do
    sign_in(create(:user))
    song = create(:song)
    attributes = attributes_for(:song)
    attributes.delete(:audio)
    audio = Rails.root.join('spec', 'fixtures', 'song.mp3')

    visit admin_songs_path
    click_on(song.title)

    attach_file('Audio', audio)
    fill_form_and_submit(:song, :edit, attributes)

    expect(page).to have_content(attributes[:title])
  end

  scenario 'admin deletes a song' do
    sign_in(create(:user))
    song = create(:song)

    visit admin_songs_path
    within("#song_#{song.id}") do
      click_on I18n.t('helpers.submit.song.delete')
    end

    expect(page).not_to have_content(song.title)
  end
end
