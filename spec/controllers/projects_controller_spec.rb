require 'rails_helper'

RSpec.describe ProjectsController do
  describe '#show' do
    it 'assigns the right project to @project' do
      project = create(:project)

      get :show, id: project.id

      expect(assigns[:project]).to eq(project)
    end
  end
end
