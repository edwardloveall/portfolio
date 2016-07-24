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
      expect(img[:alt]).to eq("#{project.title} Project Logo")
    end
  end

  describe '#convert_markdown' do
    it 'calls MarkdownRenderer' do
      allow(MarkdownRenderer).to receive(:to_html).and_return('')

      helper.convert_markdown('')

      expect(MarkdownRenderer).to have_received(:to_html)
    end
  end

  describe '#link_to_s3_file' do
    it 'returns a link based on the aws url and file key and file title' do
      file = S3File.new(key: 'path/to/file.rb')
      html = '<a href="http://el-experiments.s3.amazonaws.com/path/to/file.rb">file.rb</a>'

      link = helper.link_to_s3_file(file)

      expect(link).to eq(html)
    end
  end

  describe '#pretty_url' do
    it 'removes the scheme from the URL' do
      url = 'http://example.com/page.html'

      result = helper.pretty_url(url)

      expect(result).to eq('example.com/page.html')
    end

    it 'removes secure schemes from the URL' do
      url = 'https://example.com/page.html'

      result = helper.pretty_url(url)

      expect(result).to eq('example.com/page.html')
    end

    it 'removes www from the URL' do
      url = 'http://www.example.com/page.html'

      result = helper.pretty_url(url)

      expect(result).to eq('example.com/page.html')
    end

    it 'does not remove other subdomains from the URL' do
      url = 'http://blog.example.com/page.html'

      result = helper.pretty_url(url)

      expect(result).to eq('blog.example.com/page.html')
    end
  end
end
