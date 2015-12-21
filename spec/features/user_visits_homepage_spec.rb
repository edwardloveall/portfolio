require 'rails_helper'

RSpec.feature 'User visits homepage' do
  scenario 'user sees featured projects' do
    project = create(:project, :featured, title: 'Magic')
    visit '/'

    within('section.featured') do
      expect(page).to have_link(project.title, href: project.website)
    end
  end

  scenario 'user sees regular projects' do
    project = create(:project, title: 'Magic')
    visit '/'

    within('section.regular') do
      expect(page).to have_link(project.title, href: project.website)
    end
  end

  scenario 'user sees contact information' do
    visit '/'

    within('section.contact') do
      expect(page).to have_link('Blog', 'http://blog.edwardloveall.com')
      expect(page).to have_link('Twitter', href: 'https://twitter.com/edwardloveall')
      expect(page).to have_link('Email', href: 'mailto:edward@edwardloveall.com')
    end
  end
end
