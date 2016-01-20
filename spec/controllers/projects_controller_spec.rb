require 'rails_helper'

RSpec.describe ProjectsController do
  describe '#index' do
    it 'assigns featured projects to @featured' do
      featured = double(:featured)
      allow(Project).to receive(:featured).and_return(featured)

      get :index

      expect(assigns[:featured]).to eq(featured)
    end

    it 'assigns non-featured projects to @regular' do
      regular = double(:regular)
      allow(Project).to receive(:regular).and_return(regular)

      get :index

      expect(assigns[:regular]).to eq(regular)
    end
  end

  describe '#show' do
    it 'assigns the right project to @project' do
      slug = 'project-1'
      project = double(:project, slug: slug)
      allow(Project).to receive(:find_by).
                        with(hash_including(slug: slug)).
                        and_return(project)

      get :show, id: slug

      expect(assigns[:project]).to eq(project)
    end
  end
end
