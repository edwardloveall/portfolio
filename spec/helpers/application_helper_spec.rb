require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#year' do
    it 'returns the current year' do
      Timecop.freeze(Time.local(1999))

      expect(helper.year).to eq(1999)

      Timecop.return
    end
  end

  describe '#project_logo' do
    it 'returns an image tag with specific attributes' do
      project = create(:project)
      img_html = helper.project_logo(project)
      img = Nokogiri::XML(img_html).children.first

      expect(img[:src]).to eq(project.logo.url(:standard))
      expect(img[:srcset]).to eq("#{project.logo.url} 2x")
      expect(img[:width]).to eq('174')
      expect(img[:height]).to eq('174')
      expect(img[:alt]).to eq("#{project.title} Project Logo")
    end
  end
end
