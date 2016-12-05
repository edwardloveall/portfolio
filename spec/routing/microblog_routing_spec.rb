require 'rails_helper'

RSpec.describe 'Routes microblog' do
  it 'routes to microposts#index' do
    expect(get: '/microblog').to route_to(controller: 'microposts',
                                          action: 'index')
  end
end
