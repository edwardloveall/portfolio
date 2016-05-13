require 'rails_helper'

RSpec.describe Song do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should have_attached_file(:audio) }
    it do
      should validate_attachment_content_type(:audio).allowing('audio/mpeg')
    end
  end
end
