require 'rails_helper'

RSpec.describe Project do
  describe 'associations' do
    it { should belong_to :showcase }
  end

  describe 'validations' do
    it { should validate_presence_of :description }
    it { should validate_presence_of :role }
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
    it { should validate_presence_of :website }
  end
end
