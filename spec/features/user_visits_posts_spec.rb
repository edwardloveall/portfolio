require "rails_helper"

feature "User visits posts" do
  scenario "sees styled posts", :js do
    title_red = "rgba(233, 85, 85, 1)"
    time_font_size = "20px"
    body_font_style = "normal"
    post = create(:post, postable: create(:internal_post, title: "Title"))

    visit root_url(subdomain: "blog")

    title = page.find("li.post-teaser h2 a", text: "Title")
    timestamp = page.find("li.post-teaser aside time")
    body_paragraph = page.find("li.post-teaser p", match: :first)
    expect(title).to match_style("color" => title_red)
    expect(timestamp).to match_style("font-size" => time_font_size)
    expect(body_paragraph).to match_style("font-style" => body_font_style)
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
  scenario "sees a styled post", :js do
    title_red = "rgba(233, 85, 85, 1)"
    time_font_size = "20px"
    body_font_style = "normal"
    post = create(:post, postable: create(:internal_post, title: "Title"))

    visit root_url(subdomain: "blog")
    click_on("Title")

    title = page.find("article h2 a", text: "Title")
    timestamp = page.find("article aside time")
    body_paragraph = page.find("article p", match: :first)
    expect(title).to match_style("color" => title_red)
    expect(timestamp).to match_style("font-size" => time_font_size)
    expect(body_paragraph).to match_style("font-style" => body_font_style)
  end

  scenario "sees a post rendered with markdown" do
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
