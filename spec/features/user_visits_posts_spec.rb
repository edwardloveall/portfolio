require "rails_helper"

feature "User visits posts" do
  scenario "and sees next page pagination links" do
    create_list(:post, 11)

    visit root_url(subdomain: "blog")

    expect(page).to have_link("Older", href: root_path(page: 2))
  end

  scenario "and sees previous page pagination links" do
    create_list(:post, 11)

    visit root_url(subdomain: "blog", page: 2)

    expect(page).to have_link("Newer", href: root_path)
  end

  scenario "can visit main site from footer" do
    visit root_url(subdomain: "blog")

    within("footer") do
      expect(page).to have_link(
        "Edward Loveall",
        href: "https://edwardloveall.com",
      )
    end
  end
end

feature "User visits a specific post" do
  scenario "and sees a post rendered with markdown" do
    internal_post = create(
      :internal_post,
      title: "Title",
      body: "_hello_",
      slug: "title"
    )
    post = create(:post, postable: internal_post)

    visit root_url(subdomain: "blog")
    click_on("Title")

    expect(current_url).to eq(
      internal_post_url(subdomain: "blog", slug: "title")
    )
    expect(page).to have_selector("article h2", text: "Title")
    expect(page).to have_selector("article em", text: "hello")
  end
end
