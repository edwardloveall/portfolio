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

    permalink = page.find('.permalink')
    permalink.click

    expect(page).to have_current_path(path)
    expect(page).to have_text(micropost.body)
  end

  scenario 'and sees pagination links' do
    create_list(:micropost, 31)

    visit microposts_path

    expect(page).to have_link('Older', microposts_path(page: 2))

    click_on 'Older'

    expect(page).to have_link('Newer', microposts_path(page: 1))
  end
end
