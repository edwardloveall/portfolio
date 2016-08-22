require 'rails_helper'

RSpec.feature 'User visits posts' do
  scenario 'and sees pagination links' do
    create_list(:post, 11)

    visit posts_url(subdomain: 'blog')

    expect(page).to have_link('Older', posts_url(subdomain: 'blog', page: 2))
  end

  scenario 'and sees pagination links' do
    create_list(:post, 11)

    visit posts_url(subdomain: 'blog', page: 2)

    expect(page).to have_link('Newer', posts_url(subdomain: 'blog', page: 1))
  end
end
