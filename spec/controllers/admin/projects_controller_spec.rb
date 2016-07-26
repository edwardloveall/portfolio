require 'rails_helper'

RSpec.describe Admin::ProjectsController do
  describe '#index' do
    it 'assigns all projects to @projects' do
      sign_in(create(:user))
      projects = double(:projects)
      allow(Project).to receive(:by_position).and_return(projects)

      get :index

      expect(assigns[:projects]).to eq(projects)
    end
  end

  describe '#new' do
    it 'assigns a new @project' do
      sign_in(create(:user))
      get :new

      expect(assigns[:project]).to be_a_new(Project)
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      it 'creates a project' do
        sign_in(create(:user))
        project_count = Project.count
        params = attributes_for(:project).except(:published_at)
        params[:published] = true

        post :create, project: params

        expect(Project.count).to eq(project_count + 1)
      end

      it 'redirects to the project index' do
        sign_in(create(:user))
        params = attributes_for(:project).except(:published_at)
        params[:published] = true

        post :create, project: params

        expect(response).to redirect_to(admin_projects_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a project' do
        sign_in(create(:user))
        project_count = Project.count

        post :create, project: { title: nil }

        expect(Project.count).to eq(project_count)
      end

      it 'renders the new form' do
        sign_in(create(:user))
        post :create, project: { title: nil }

        expect(response).to render_template(:new)
      end

      it 'shows the error flash' do
        sign_in(create(:user))
        post :create, project: { title: nil }
        error_flash = I18n.t('flashes.project.create.error')

        expect(flash[:error]).to eq(error_flash)
      end
    end
  end

  describe '#edit' do
    it 'assigns the project to @project' do
      sign_in(create(:user))
      project = create(:project)

      get :edit, id: project.slug

      expect(assigns[:project]).to eq(project)
    end
  end

  describe '#update' do
    context 'with valid parameters' do
      it 'changes the project' do
        sign_in(create(:user))
        project = create(:project, title: 'A title')
        params = attributes_for(:project).except(:published_at)
        params[:published] = true

        put :update, id: project.slug, project: params
        project.reload

        expect(project.title).to eq(params[:title])
        expect(project.slug).to eq(params[:slug])
        expect(project.description).to eq(params[:description])
      end

      it 'redirects to the project index' do
        sign_in(create(:user))
        project = create(:project, title: 'A title')
        params = attributes_for(:project).except(:published_at)
        params[:published] = true

        put :update, id: project.slug, project: params

        expect(response).to redirect_to(admin_projects_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not edit the project' do
        sign_in(create(:user))
        project = create(:project)
        params = { slug: nil }

        put :update, id: project.slug, project: params

        expect(project.slug).not_to be_nil
      end

      it 'renders the edit form' do
        sign_in(create(:user))
        project = create(:project)
        params = { slug: nil }

        put :update, id: project.slug, project: params

        expect(response).to render_template(:edit)
      end

      it 'shows the error flash' do
        sign_in(create(:user))
        project = create(:project)
        params = { slug: nil }
        error_flash = I18n.t('flashes.project.update.error')

        put :update, id: project.slug, project: params

        expect(flash[:error]).to eq(error_flash)
      end
    end
  end

  describe '#sort' do
    it 'changes the position of projects' do
      sign_in(create(:user))
      a = create(:project, position: 1)
      b = create(:project, position: 2)

      post :sort, project: [b.id, a.id]
      a.reload; b.reload

      expect(a.position).to eq(2)
      expect(b.position).to eq(1)
    end
  end

  describe '#delete' do
    context 'when a project can be deleted' do
      it 'deletes the project' do
        sign_in(create(:user))
        project = create(:project)
        project_count = Project.count

        delete :destroy, id: project.slug

        expect(Project.count).to eq(project_count - 1)
      end

      it 'redirects to the project index' do
        sign_in(create(:user))
        project = create(:project)

        delete :destroy, id: project.slug

        expect(response).to redirect_to(admin_projects_path)
      end
    end

    context 'when a project can not be deleted' do
      it 'does not delete the project' do
        sign_in(create(:user))
        project_count = Project.count
        project = create(:project)

        delete :destroy, id: project.slug

        expect(Project.count).to eq(project_count)
      end

      it 'shows the error flash' do
        sign_in(create(:user))
        project = create(:project)
        allow(project).to receive(:destroy).and_return(false)
        allow(Project).to receive(:find_by).
                          with(hash_including(slug: project.slug)).
                          and_return(project)
        error_flash = I18n.t('flashes.project.delete.error')

        delete :destroy, id: project.slug

        expect(flash[:error]).to eq(error_flash)
      end
    end
  end
end
