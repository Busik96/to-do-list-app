# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create :user }
  let!(:task1) { create :task, :finished, user: user }
  let!(:task2) { create :task, user: user }

  describe 'GET tasks#index' do
    it_behaves_like 'only-for-signed-in', :index

    context 'with signed in user' do
      before do
        sign_in user
        get :index
      end

      it 'renders index view' do
        expect(response).to render_template('index')
      end

      it 'assigns all current user tasks to @tasks' do
        expect(assigns(:tasks).to_a).to eq([task1, task2])
      end
      it 'assigns all current user pending tasks to @tasks_pending' do
        expect(assigns(:tasks_pending)).to contain_exactly(task2)
      end
      it 'assigns all current user finished tasks to @tasks_finished' do
        expect(assigns(:tasks_finished)).to contain_exactly(task1)
      end
      it 'assigns new task to @task' do
        expect(assigns(:task)).to be_a(Task)
        expect(assigns(:task)).not_to be_persisted
      end
    end
  end

  describe 'POST tasks#create' do
    context 'with sign in user' do
      before do
        sign_in user
      end

      subject(:call) { post :create, params: params }
      let(:params) do
        {
          task: {
            description: description,
            due_date: Faker::Date.forward(days: 22),
            address: Faker::Address.city
          }
        }
      end

      context 'with valid attributes' do
        let(:description) { Faker::Lorem.paragraph }

        it 'creates a new task' do
          expect { call }.to change(Task, :count).by(1)
        end

        it 'redirects to tasks path' do
          call
          expect(response).to redirect_to(tasks_path)
        end
      end

      context 'with invalid attributes' do
        let(:description) { nil }

        it 'does not save the new user company' do
          expect { call }.to_not change(Task, :count)
        end

        it 're-renders the new method' do
          call
          expect(response).to render_template(:index)
        end
      end
    end
  end

  describe 'GET tasks#edit' do
    it_behaves_like 'only-for-signed-in', :edit, id: 2

    describe 'with signed in user' do
      context 'when task finished' do
        before do
          sign_in user
          get :edit, params: { id: task1.id }
        end

        it 'render 403' do
          expect(response.status).to eq(403)
        end
      end

      context 'when task not finished' do
        before do
          sign_in user
          get :edit, params: { id: task2.id }
        end

        it 'renders edit view' do
          expect(response).to render_template('edit')
        end

        it 'assigns current task id to @task' do
          expect(assigns(:task)).to eq(task2)
        end
      end
    end
  end

  describe 'PATCH tasks#update' do
    subject(:call) { patch :update, params: params }

    context 'when task finished' do
      before do
        sign_in user
      end

      let(:params) do
        {
          id: task1.id,
          task: {
            description: 'Test description',
            due_time: '14:00'
          }
        }
      end

      it 'render 403' do
        call
        expect(response.status).to eq(403)
      end
    end

    context 'when task not finished' do
      before do
        sign_in user
      end

      let(:params) do
        {
          id: task2.id,
          task: {
            description: description,
            due_time: '14:00'
          }
        }
      end

      context 'with valid params' do
        let(:description) { 'Test description' }

        it 'redirect to index view' do
          call
          expect(response).to redirect_to(tasks_path)
        end

        it 'assigns current task to @task' do
          call
          expect(assigns(:task)).to eq(task2)
        end
      end

      context 'with invalid params' do
        let(:description) { nil }

        it 're-renders edit view' do
          call
          expect(response).to render_template('edit')
        end

        it 'assigns current task id to @task' do
          call
          expect(assigns(:task)).to eq(task2)
        end
      end
    end
  end

  describe 'DELETE tasks#destroy' do
    before do
      sign_in user
    end

    context 'when task finished' do
      subject(:call) { delete :destroy, params: { id: task1.id } }

      it 'not remove task' do
        expect { call }.to change(Task, :count).by(0)
      end

      it 'render 403' do
        call
        expect(response.status).to eq(403)
      end
    end

    context 'when task not finished' do
      subject(:call) { delete :destroy, params: { id: task2.id } }

      it 'remove task' do
        expect { call }.to change(Task, :count).by(-1)
      end

      it 'redirect to tasks index' do
        call
        expect(response).to redirect_to(tasks_path)
      end
    end
  end

  describe 'PATCH tasks#finish' do
    before do
      sign_in user
    end

    subject(:call) { patch :finish, params: params }
    let(:params) do
      {
        id: task1.id,
        task: {
          finished: false
        }
      }
    end

    it 'change finished to false' do
      expect { call }.to change { task1.reload.finished }.to(false)
    end

    it 'redirect to tasks index' do
      call
      expect(response).to redirect_to(tasks_path)
    end
  end
end
