require "rails_helper"

RSpec.feature "Admin external post management" do
  feature "admin creates an external post" do
    scenario "appears on the admin page" do
      sign_in(create(:user))
      attributes = attributes_for(:external_post, title: "My Title")

      visit admin_root_path
      click_on "External Posts"
      click_on "Add post"
      fill_form_and_submit(:external_post, :new, attributes)

      expect(page).to have_selector("ul.posts li a", text: "My Title")
    end

    scenario "appears on the blog posts page" do
      sign_in(create(:user))
      attributes = attributes_for(:external_post, title: "My Title")

      visit admin_root_path
      click_on "External Posts"
      click_on "Add post"
      fill_form_and_submit(:external_post, :new, attributes)

      visit root_url(subdomain: :blog)

      expect(page).to have_selector("li.post-teaser h2", text: "My Title")
    end
  end

  scenario "admin updates an external post" do
    sign_in(create(:user))
    post = create(:external_post, title: "Old Title")
    attributes = attributes_for(:external_post, title: "My Title")

    visit admin_root_path
    click_on "External Posts"
    click_on(post.title)
    fill_form_and_submit(:external_post, :edit, attributes)

    expect(page).to have_selector("ul.posts li a", text: "My Title")
  end

  scenario "admin deletes an external post" do
    sign_in(create(:user))
    external_post = create(:external_post, title: "My Title")
    post = create(:post, postable: external_post)

    visit admin_root_path
    click_on "External Posts"
    within("#external_post_#{external_post.id}") do
      click_on I18n.t("helpers.submit.external_post.delete")
    end

    expect(page).not_to have_selector("ul.posts li a", text: "My Title")
  end
end
