require 'rails_helper'

RSpec.feature 'User visits posts' do
  scenario 'and sees pagination links' do
    create_list(:post, 11)

    visit root_url(subdomain: 'blog')

    expect(page).to have_link('Older', posts_url(subdomain: 'blog', page: 2))
  end

  scenario 'and sees pagination links' do
    create_list(:post, 11)

    visit root_url(subdomain: 'blog', page: 2)

    expect(page).to have_link('Newer', posts_url(subdomain: 'blog', page: 1))
  end

  scenario 'and visits a specific post' do
    post = create(:post)

    visit root_url(subdomain: 'blog')
    click_on(post.title)

    expect(current_url).to eq(post_url(subdomain: 'blog', slug: post.slug))
    within('article h2') do
      expect(page).to have_content(post.title)
    end
  end

  scenario 'can visit main site from footer' do
    visit root_url(subdomain: 'blog')

    within('footer') do
      expect(page).to have_link('Edward Loveall',
                                href: 'https://edwardloveall.com')
    end
  end
end
