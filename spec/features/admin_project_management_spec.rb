require 'rails_helper'

RSpec.feature 'Admin project management' do
  scenario 'admin creates a project' do
    sign_in(create(:user))
    attributes = attributes_for(:project)
    attributes.delete(:logo)
    logo = Rails.root.join('spec', 'fixtures', 'pull_feed_2x.png')

    visit new_admin_project_path

    attach_file('Logo', logo)
    fill_form_and_submit(:project, :new, attributes)

    expect(page).to have_content(attributes[:title])
  end

  scenario 'admin updates a project' do
    sign_in(create(:user))
    project = create(:project)
    attributes = attributes_for(:project)
    attributes.delete(:logo)
    logo = Rails.root.join('spec', 'fixtures', 'pull_feed_2x.png')

    visit admin_projects_path
    click_on(project.title)

    attach_file('Logo', logo)
    fill_form_and_submit(:project, :edit, attributes)

    expect(page).to have_content(attributes[:title])
  end

  scenario 'admin deletes a project' do
    sign_in(create(:user))
    project = create(:project)

    visit admin_projects_path
    within("#project_#{project.id}") do
      click_on I18n.t('helpers.submit.project.delete')
    end

    expect(page).not_to have_content(project.title)
  end
end
