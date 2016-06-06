require 'rails_helper'

RSpec.feature 'User visits homepage' do
  scenario 'user sees featured projects' do
    project = create(:project, :featured, title: 'Magic')
    visit '/'

    within('section.featured') do
      expect(page).to have_link(project.title, href: project_path(project))
    end
  end

  scenario 'user sees regular projects' do
    project = create(:project, title: 'Magic')
    visit '/'

    within('section.regular') do
      expect(page).to have_link(project.title, href: project_path(project))
    end
  end

  scenario 'user sees contact information' do
    email_href = 'mailto:edward@edwardloveall.com'
    visit '/'

    within('section.contact') do
      expect(page).to have_link('Blog', href: 'http://blog.edwardloveall.com')
      expect(page).to have_link('Twitter', href: 'https://twitter.com/edwardloveall')
      expect(page).to have_link('Email', href: email_href)
    end
  end
end
