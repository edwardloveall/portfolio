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
      logo_path = polymorphic_url(project.logo.variant(resize: "174x174"))
      logo_path_2x = polymorphic_url(project.logo.variant(resize: "348x348"))
      img_html = helper.project_logo(project)
      img = Nokogiri::XML(img_html).children.first

      expect(img[:src]).to eq(logo_path)
      expect(img[:srcset]).to eq("#{logo_path_2x} 2x")
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

  describe '#pretty_date' do
    it 'returns a date string from a timestamp' do
      time = Time.new(2016, 6, 10, 1, 2, 3)

      result = helper.pretty_date(time)

      expect(result).to eq('June 10th, 2016')
    end
  end

  describe '#timestamp' do
    it 'returns a date string from a timestamp' do
      time = Time.new(2016, 6, 10, 13, 2, 3)

      result = helper.timestamp(time)

      expect(result).to eq('2016-06-10 13:02')
    end
  end

  describe '#pretty_datetime' do
    it 'returns a formated timestamp' do
      time = Time.new(2016, 6, 10, 13, 2, 3)

      result = helper.pretty_datetime(time)

      expect(result).to eq('June 10th, 2016 - 1:02 pm')
    end
  end
end
