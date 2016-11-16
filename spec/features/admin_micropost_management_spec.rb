require 'rails_helper'

RSpec.feature 'Admin micropost management' do
  feature 'Admin creates a micropost' do
    scenario 'appears on the admin page' do
      sign_in(create(:user))
      attributes = attributes_for(:micropost)

      visit admin_root_path
      click_on 'Microblog'
      fill_form_and_submit(:micropost, :new, attributes)

      expect(page).to have_content(attributes[:body])
    end

    scenario 'appears on the main microblog page' do
      sign_in(create(:user))
      attributes = attributes_for(:micropost)

      visit admin_root_path
      click_on 'Microblog'
      fill_form_and_submit(:micropost, :new, attributes)

      visit microblog_root_path

      expect(page).to have_content(attributes[:body])
    end
  end

  scenario 'admin updates a micropost' do
    sign_in(create(:user))
    micropost = create(:micropost)
    attributes = attributes_for(:micropost, body: 'New Hot Take')

    visit admin_root_path
    click_on 'Microblog'
    within("#micropost_#{micropost.id}") do
      click_on I18n.t('helpers.submit.micropost.update')
    end
    fill_form_and_submit(:micropost, :edit, attributes)

    expect(page).to have_content(attributes[:title])
  end

  scenario 'admin deletes a micropost' do
    sign_in(create(:user))
    micropost = create(:micropost)

    visit admin_root_path
    click_on 'Microblog'
    within("#micropost_#{micropost.id}") do
      click_on I18n.t('helpers.submit.micropost.delete')
    end

    expect(page).not_to have_content(micropost.body)
  end
end
