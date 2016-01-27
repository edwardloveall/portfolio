require 'rails_helper'

module Admin
  RSpec.describe ProjectsController do
    describe '#index' do
      it 'assigns all projects to @projects' do
        projects = double(:projects)
        allow(Project).to receive(:in_display_order).and_return(projects)

        get :index

        expect(assigns[:projects]).to eq(projects)
      end
    end

    describe '#new' do
      it 'assigns a new @project' do
        get :new

        expect(assigns[:project]).to be_a_new(Project)
      end
    end

    describe '#create' do
      context 'with valid attributes' do
        it 'creates a project' do
          project_count = Project.count
          params = attributes_for(:project)

          post :create, project: params

          expect(Project.count).to eq(project_count + 1)
        end

        it 'redirects to the project index' do
          params = attributes_for(:project)

          post :create, project: params

          expect(response).to redirect_to(admin_projects_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not create a project' do
          project_count = Project.count

          post :create, project: { title: nil }

          expect(Project.count).to eq(project_count)
        end

        it 'renders the new form' do
          post :create, project: { title: nil }

          expect(response).to render_template(:new)
        end
      end
    end

    describe '#edit' do
      it 'assigns the project to @project' do
        project = create(:project)

        get :edit, id: project.slug

        expect(assigns[:project]).to eq(project)
      end
    end

    describe '#update' do
      context 'with valid parameters' do
        it 'changes the project' do
          project = create(:project, title: 'A title')
          params = attributes_for(:project)

          put :update, id: project.slug, project: params
          project.reload

          expect(project.title).to eq(params[:title])
          expect(project.slug).to eq(params[:slug])
          expect(project.description).to eq(params[:description])
        end

        it 'redirects to the project index' do
          project = create(:project, title: 'A title')
          params = attributes_for(:project)

          put :update, id: project.slug, project: params

          expect(response).to redirect_to(admin_projects_path)
        end
      end

      context 'with invalid parameters' do
        it 'does not edit the project' do
          project = create(:project)
          params = { slug: nil }

          put :update, id: project.slug, project: params

          expect(project.slug).not_to be_nil
        end

        it 'renders the edit form' do
          project = create(:project)
          params = { slug: nil }

          put :update, id: project.slug, project: params

          expect(response).to render_template(:edit)
        end
      end
    end

    describe '#delete' do
      context 'when a project can be deleted' do
        it 'deletes the project' do
          project = create(:project)
          project_count = Project.count

          delete :destroy, id: project.slug

          expect(Project.count).to eq(project_count - 1)
        end

        it 'redirects to the project index' do
          project = create(:project)

          delete :destroy, id: project.slug

          expect(response).to redirect_to(admin_projects_path)
        end
      end
    end
  end
end
