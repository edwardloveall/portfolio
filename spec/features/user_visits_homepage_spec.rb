require 'rails_helper'

RSpec.feature 'User visits homepage' do
  scenario 'user sees featured projects' do
    project = create(:project, :featured, title: 'Magic')

    visit '/'

    within('section.featured-projects') do
      expect(page).to have_link(project.title, href: project_path(project))
    end
  end

  scenario 'user sees regular projects' do
    project = create(:project, title: 'Magic')

    visit '/'

    within('section.other-projects') do
      expect(page).to have_link(project.title, href: project_path(project))
    end
  end

  scenario 'user does not see non-published projects' do
    project = create(:project, published_at: nil)

    visit '/'

    within('section.other-projects') do
      expect(page).not_to have_link(project.title, href: project_path(project))
    end
  end

  scenario 'user sees contact information' do
    email_href = 'mailto:edward@edwardloveall.com'

    visit '/'

    within('section.contact') do
      expect(page).to have_link('Blog', href: root_url(subdomain: 'blog'))
      expect(page).to have_link('Fediverse', href: 'https://indieweb.social/@edward')
      expect(page).to have_link('Email', href: email_href)
    end
  end

  scenario 'user sees Hotline Webring links' do
    next_href = 'https://hotlinewebring.club/edward/next'
    prev_href = 'https://hotlinewebring.club/edward/previous'

    visit '/'

    within('section.hotline-webring') do
      expect(page).to have_link('Next', href: next_href)
      expect(page).to have_link('Previous', href: prev_href)
    end
  end
end
