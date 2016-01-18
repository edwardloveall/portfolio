require 'rails_helper'

RSpec.describe 'Routes /about' do
  it 'routes to pages/about' do
    expect(get: '/about').
      to route_to(controller: 'high_voltage/pages',
                  action: 'show',
                  id: 'about')
  end
end
