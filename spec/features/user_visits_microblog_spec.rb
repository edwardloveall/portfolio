require 'rails_helper'

RSpec.feature 'User visits microblog' do
  feature 'user visits microblog index' do
    scenario 'sees microposts' do
      create(:micropost, body: 'A')
      create(:micropost, body: 'B')

      visit microposts_path

      expect(page).to have_text('A')
      expect(page).to have_text('B')
    end
  end

  scenario 'user visits an individual micropost' do
    micropost = create(:micropost)
    path = "/microblog/posts/#{micropost.ms_epoch}"

    visit microposts_path

    click_on micropost.body

    expect(page).to have_current_path(path)
    expect(page).to have_text(micropost.body)
  end
end
