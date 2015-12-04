require 'rails_helper'

RSpec.describe Showcase do
  describe 'associations' do
    it { should have_many :projects }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
  end
end
