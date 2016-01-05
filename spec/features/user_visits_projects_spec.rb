require 'rails_helper'

RSpec.feature 'User visits projects a single project from the index' do
  context 'a featured project' do
    scenario 'user sees the project page' do
      project = create(:project, :featured)

      visit '/'
      click_on project.title

      expect(current_path).to eq(project_path(project))
      expect(page).to have_content(project.title)
    end
  end

  context 'a normal project' do
    scenario 'user lands on project page' do
      project = create(:project)

      visit '/'
      click_on project.title

      expect(current_path).to eq(project_path(project))
    end
  end
end
