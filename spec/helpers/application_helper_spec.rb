require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#year' do
    it 'returns the current year' do
      Timecop.freeze(Time.local(1999))

      expect(helper.year).to eq(1999)

      Timecop.return
    end
  end
end
