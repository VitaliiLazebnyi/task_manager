require 'spec_helper'

describe ProjectsController do
  login_user
  let(:project) { create(:project, user: @user) }

  describe 'GET #index' do
    let(:projects) { create_list(:project, 2, user: @user) }

    before { get :index }

    it 'populates an array of all projects' do
      expect(assigns(:projects)).to match_array(projects)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Project to @project' do
      expect(assigns(:project)).to be_a_new(Project)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end


  describe 'GET #edit' do
    before { get :edit, params: { id: project } }

    it 'assings the requested project to @project' do
      expect(assigns(:project)).to eq project
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new project in the database' do
        expect { post :create, params: { project: attributes_for(:project) } }.to change(Project, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { project: attributes_for(:project) }
        expect(response).to redirect_to projects_url
      end
    end

    context 'with invalid attributes' do
      it 'does not save the project' do
        expect { post :create, params: { project: attributes_for(:invalid_project) }}.
            to_not change(Project, :count)
      end

      it 're-renders new view' do
        post :create, params: { project: attributes_for(:invalid_project) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assings the requested project to @project' do
        patch :update, params: { id: project, project: attributes_for(:project) }
        expect(assigns(:project)).to eq project
      end

      it 'changes project attributes' do
        patch :update, params: { id: project, project: { title: 'new title' } }
        project.reload
        expect(project.title).to eq 'new title'
      end

      it 'redirects to the updated project' do
        patch :update, params: { id: project, project: attributes_for(:project) }
        expect(response).to redirect_to projects_url
      end
    end

    context 'invalid attributes' do
      it 'does not change project attributes' do
        old_title = project.title

        patch :update, params: { id: project, project: { title: nil }}

        project.reload
        expect(project.title).to eq old_title
      end

      it 're-renders edit view' do
        patch :update, params: { id: project, project: { title: nil }}
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { project }

    it 'deletes project' do
      expect { delete :destroy, params: { id: project }}.
          to change(Project, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: project }
      expect(response).to redirect_to projects_path
    end
  end
end

