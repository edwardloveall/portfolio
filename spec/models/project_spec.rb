require 'rails_helper'

RSpec.describe Project do
  describe 'validations' do
    it { should validate_attachment_content_type(:logo).allowing('image/png') }
    it { should validate_attachment_presence(:logo) }
    it { should validate_presence_of :description }
    it { should validate_presence_of :role }
    it { should validate_presence_of :slug }
    it { should validate_uniqueness_of :slug }
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
    it { should validate_presence_of :website }
  end

  it { should have_attached_file :logo }

  describe '::LOGO_SIZE' do
    it 'returns the size the logo image should be' do
      expect(Project::LOGO_SIZE).to eq(174)
    end
  end

  describe '.featured' do
    it 'returns only the featured projects' do
      create(:project)
      featured = create_list(:project, 2, :featured)

      expect(Project.featured).to match_array(featured)
    end
  end

  describe '.by_position' do
    it 'returns projects by position' do
      c = create(:project, position: 3)
      a = create(:project, position: 1)
      b = create(:project, position: 2)

      expect(Project.by_position).to eq([a, b, c])
    end
  end

  describe '.regular' do
    it 'returns only the regular projects' do
      create(:project, :featured)
      regular = create_list(:project, 2)

      expect(Project.regular).to match_array(regular)
    end
  end

  describe '.in_display_order' do
    it 'returns projects by date created' do
      older = create(:project, created_at: 2.days.ago)
      newer = create(:project, created_at: 1.day.ago)

      expect(Project.in_display_order).to eq([newer, older])
    end
  end

  describe '.to_param' do
    it 'uses the slug' do
      slug = 'pull-feed'
      project = build(:project, slug: slug)

      expect(project.to_param).to eq(slug)
    end
  end
end
