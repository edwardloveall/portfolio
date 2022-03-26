require "rails_helper"

RSpec.feature "Admin internal post management" do
  feature "admin creates an internal post" do
    scenario "js test", :js do
      visit root_path
    end

    scenario "appears on the admin page" do
      sign_in(create(:user))
      attributes = attributes_for(:internal_post, title: "My Title")

      visit admin_root_path
      click_on "Internal Posts"
      click_on "Add post"
      fill_form_and_submit(:internal_post, :new, attributes)

      expect(page).to have_selector("ul.posts li a", text: "My Title")
    end

    scenario "appears on the blog posts page" do
      sign_in(create(:user))
      attributes = attributes_for(:internal_post, title: "My Title")

      visit admin_root_path
      click_on "Internal Posts"
      click_on "Add post"
      fill_form_and_submit(:internal_post, :new, attributes)

      visit root_url(subdomain: :blog)

      expect(page).to have_selector("article.post h2", text: "My Title")
    end
  end

  scenario "admin updates an internal post" do
    sign_in(create(:user))
    post = create(:internal_post, title: "Old Title")
    attributes = attributes_for(:internal_post, title: "My Title")

    visit admin_root_path
    click_on "Internal Posts"
    click_on(post.title)
    fill_form_and_submit(:internal_post, :edit, attributes)

    expect(page).to have_selector("ul.posts li a", text: "My Title")
  end

  scenario "admin deletes an internal post" do
    sign_in(create(:user))
    post = create(:post)
    internal_post = post.postable

    visit admin_root_path
    click_on "Internal Posts"
    within("#internal_post_#{internal_post.id}") do
      click_on I18n.t("helpers.submit.internal_post.delete")
    end

    expect(page).not_to have_selector("ul.posts li a", text: "My Title")
  end
end
