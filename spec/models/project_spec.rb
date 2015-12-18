require 'rails_helper'

RSpec.describe Project do
  describe 'validations' do
    it { should validate_presence_of :description }
    it { should validate_presence_of :role }
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
    it { should validate_presence_of :website }
  end

  describe '.featured' do
    it 'returns only the featured projects' do
      create(:project)
      featured = create_list(:project, 2, :featured)

      expect(Project.featured).to match_array(featured)
    end
  end

  describe '.regular' do
    it 'returns only the regular projects' do
      create(:project, :featured)
      regular = create_list(:project, 2)

      expect(Project.regular).to match_array(regular)
    end
  end
end
