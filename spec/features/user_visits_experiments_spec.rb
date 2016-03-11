require 'rails_helper'

RSpec.feature 'user visits experiments' do
  scenario 'sees list of files and folders' do
    root_structure = {
      contents: ['file.rb'],
      common_prefixes: ['code/']
    }
    code_structure = {
      contents: ['code/', 'code/file.rb'],
      common_prefixes: ['code/tests/']
    }
    stub_s3(root_structure)

    visit '/experiments/'

    within('main') do
      expect(page).to have_link('file.rb', href: "#{S3::AWS_BASE_URL}/file.rb")
      expect(page).to have_link('code', href: '/experiments/code/')
    end

    stub_s3(code_structure, prefix: 'code/')

    click_link 'code'

    within('main') do
      expect(page).to have_link('file.rb', href: "#{S3::AWS_BASE_URL}/code/file.rb")
      expect(page).to have_link('tests', href: '/experiments/code/tests/')
    end
  end
end
