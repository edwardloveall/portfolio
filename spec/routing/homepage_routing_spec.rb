require 'rails_helper'

RSpec.describe 'Routes homepage' do
  it 'routes to projects#index' do
    expect(get: '/').to route_to(controller: 'projects', action: 'index')
  end
end
