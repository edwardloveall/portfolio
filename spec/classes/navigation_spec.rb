require 'rails_helper'

RSpec.describe Navigation do
  describe '.perform' do
    context 'when a path is passed' do
      it 'returns navigation html' do
        nav_html = <<-HTML.strip_heredoc
        <nav class="main">
          <a href="/about">About</a>
          <a href="/music">Music</a>
        </nav>
        HTML
        nav_html = strip_html_whitespace(nav_html)

        nav = Navigation.perform('/projects')

        expect(nav.strip).to eq(nav_html)
      end
    end

    context 'when deep project link is passed' do
      it 'returns project navigation html' do
        nav_html = <<-HTML.strip_heredoc
        <nav class="main">
          <a href="/about">About</a>
          <a href="/music">Music</a>
        </nav>
        HTML
        nav_html = strip_html_whitespace(nav_html)

        nav = Navigation.perform('/projects/abc')

        expect(nav.strip).to eq(nav_html)
      end
    end

    context 'when root path is passed' do
      it 'returns default navigation html' do
        nav_html = <<-HTML.strip_heredoc
        <nav class="main">
          <a href="/about">About</a>
          <a href="/music">Music</a>
        </nav>
        HTML
        nav_html = strip_html_whitespace(nav_html)

        nav = Navigation.perform('/')

        expect(nav.strip).to eq(nav_html)
      end
    end

    context 'a non-project path' do
      it 'returns navigation for the about page' do
        nav_html = <<-HTML.strip_heredoc
        <nav class="main">
          <a href="/projects">Projects</a>
          <a href="/music">Music</a>
        </nav>
        HTML
        nav_html = strip_html_whitespace(nav_html)

        nav = Navigation.perform('/about')

        expect(nav.strip).to eq(nav_html)
      end
    end
  end

  def strip_html_whitespace(string)
    string.tr("\n", ' ').
           gsub(/>\s*</, '><').
           strip
  end
end
