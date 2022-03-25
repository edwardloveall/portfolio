require 'rails_helper'

RSpec.feature 'User visits posts' do
  scenario 'and sees pagination links' do
    create_list(:post, 11)

    visit root_url(subdomain: 'blog')

    expect(page).to have_link('Older', href: root_path(page: 2))
  end

  scenario 'and sees pagination links' do
    create_list(:post, 11)

    visit root_url(subdomain: 'blog', page: 2)

    expect(page).to have_link('Newer', href: root_path)
  end

  scenario "and visits a specific post" do
    internal_post = create(:internal_post, title: "Title")
    post = create(:post, postable: internal_post)

    visit root_url(subdomain: "blog")
    click_on("Title")

    expect(current_url).to eq(
      internal_post_url(subdomain: "blog", slug: internal_post.slug)
    )
    expect(page).to have_selector("article h2", text: "Title")
  end

  scenario 'can visit main site from footer' do
    visit root_url(subdomain: 'blog')

    within('footer') do
      expect(page).to have_link('Edward Loveall',
                                href: 'https://edwardloveall.com')
    end
  end
end
