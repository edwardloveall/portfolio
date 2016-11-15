require 'rails_helper'

RSpec.feature 'User visits microblog' do
  feature 'user visits microblog index' do
    scenario 'sees microposts' do
      create(:micropost, body: 'A')
      create(:micropost, body: 'B')

      visit microblog_root_path

      expect(page).to have_text('A')
      expect(page).to have_text('B')
    end
  end

  scenario 'user visits an individual micropost' do
    micropost = create(:micropost)

    visit microblog_root_path

    click_on micropost.body

    expect(page).to have_current_path(microblog_path(micropost.timestamp))
    expect(page).to have_text(micropost.body)
  end
end
