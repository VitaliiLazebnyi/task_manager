require 'spec_helper'

describe TasksController do
  login_user
  let(:project) { create(:project, user:    @user) }
  let(:task)    { create(:task,    project: project, priority: 4, done: false) }

  describe 'GET #new' do
    before { get :new, params: { project_id: project.id } }

    it 'assigns a Project to @project' do
      expect(assigns(:project)).to be_a(Project)
    end

    it 'assigns a new Task to @task' do
      expect(assigns(:task)).to be_a_new(Task)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { project_id: project.id, id: task.id } }

    it 'assigns a Project to @project' do
      expect(assigns(:project)).to be_a(Project)
    end

    it 'assigns a new Task to @task' do
      expect(assigns(:task)).to be_a(Task)
    end

    it 'renders new view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    it 'saves the new task in the database' do
      expect { post :create, params: { task: attributes_for(:task, project_id: project.id), project_id: project.id} }.to change(Task, :count).by(1)
    end

    it 'redirects to Project show view' do
      post :create, params: { task: attributes_for(:task, project_id: project.id), project_id: project.id }
      expect(response).to redirect_to project_path(task.project)
    end
  end

  describe 'PATCH #update' do
    it 'it changes Task in database' do
      patch :update, params: { id: task, project_id: project, task: attributes_for(:task, title: 'new title') }
      task.reload
      expect(task.title).to eq 'new title'
    end

    it 'redirects to Project show view' do
      patch :update, params: { id: task, project_id: project, task: attributes_for(:task) }
      expect(response).to redirect_to project_path(task.project)
    end

    it 'assigns Task variable @task' do
      patch :update, params: { id: task, project_id: project, task: attributes_for(:task, title: 'new title') }
      expect(assigns(:task)).to be_a(Task)
    end

    it 'assigns Project to variable @project' do
      patch :update, params: { id: task, project_id: project, task: attributes_for(:task, title: 'new title') }
      expect(assigns(:project)).to be_a(Project)
    end
  end

  describe 'POST #destroy' do
    before { task }

    it 'removes task from database' do
      expect { delete :destroy, params: { id: task.id, project_id: task.project.id } }.to change(Task, :count).by(-1)
    end

    it 'redirects to Project show view' do
      delete :destroy, params: { id: task.id, project_id: task.project.id }
      expect(response).to redirect_to project_path(task.project)
    end
  end

  describe 'PATCH #update_priority' do
    it 'changes Priority value in database' do
      patch :update_priority, params: { id: task, project_id: project, priority: 2 }
      task.reload
      expect(task.priority).to eq 2
    end

    it 'renders Project view' do
      patch :update_priority, params: { id: task, project_id: project, priority: 2 }
      expect(response).to redirect_to project_path(task.project)
    end
  end

  describe 'PATCH #switch_done' do
    it 'changes Done value in database' do
      patch :switch_done, params: { id: task, project_id: project }
      task.reload
      expect(task.done).to eq true
    end

    it 'renders Project view' do
      patch :switch_done, params: { id: task, project_id: project }
      expect(response).to redirect_to project_path(task.project)
    end
  end
end
