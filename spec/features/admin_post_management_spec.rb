require 'rails_helper'

RSpec.feature 'Admin post management' do
  feature 'admin creates a post' do
    scenario 'appears on the admin page' do
      sign_in(create(:user))
      attributes = attributes_for(:post)

      visit admin_root_path
      click_on 'Posts'
      click_on 'Add post'
      fill_form_and_submit(:post, :new, attributes)

      expect(page).to have_content(attributes[:title])
    end

    scenario 'appears on the blog posts page' do
      sign_in(create(:user))
      attributes = attributes_for(:post)

      visit admin_root_path
      click_on 'Posts'
      click_on 'Add post'
      fill_form_and_submit(:post, :new, attributes)

      visit posts_url(subdomain: :blog)

      expect(page).to have_content(attributes[:title])
    end
  end

  scenario 'admin updates a post' do
    sign_in(create(:user))
    post = create(:post)
    attributes = attributes_for(:post)

    visit admin_root_path
    click_on 'Posts'
    click_on(post.title)
    fill_form_and_submit(:post, :edit, attributes)

    expect(page).to have_content(attributes[:title])
  end

  scenario 'admin deletes a post' do
    sign_in(create(:user))
    post = create(:post)

    visit admin_root_path
    click_on 'Posts'
    within("#post_#{post.id}") do
      click_on I18n.t('helpers.submit.post.delete')
    end

    expect(page).not_to have_content(post.title)
  end
end
