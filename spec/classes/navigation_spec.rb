require 'rails_helper'

RSpec.describe Navigation do
  describe '.links' do
    it 'returns all the links' do
      nav_html = <<-HTML.strip_heredoc
      <nav class="main">
        <a href="/about">About</a>
        <a class="active" href="/projects">Projects</a>
        <a href="/music">Music</a>
      </nav>
      HTML
      nav_html = strip_html_whitespace(nav_html)

      result = Navigation.links

      expect(result).to eq(nav_html)
    end

    context 'when passed a path' do
      it 'returns all the links with current class' do
        nav_html = <<-HTML.strip_heredoc
        <nav class="main">
          <a class="active" href="/about">About</a>
          <a href="/projects">Projects</a>
          <a href="/music">Music</a>
        </nav>
        HTML
        nav_html = strip_html_whitespace(nav_html)

        result = Navigation.links('/about')

        expect(result).to eq(nav_html)
      end
    end

    context 'when passed an unparseable path' do
      it 'returns the links with projects active' do
        nav_html = <<-HTML.strip_heredoc
        <nav class="main">
          <a href="/about">About</a>
          <a class="active" href="/projects">Projects</a>
          <a href="/music">Music</a>
        </nav>
        HTML
        nav_html = strip_html_whitespace(nav_html)

        result = Navigation.links('asdf')

        expect(result).to eq(nav_html)
      end
    end
  end

  def strip_html_whitespace(string)
    string.tr("\n", ' ').
           gsub(/>\s*</, '><').
           strip
  end
end
