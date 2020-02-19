# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FinishedTasksCleanerJob, type: :job do
  subject(:perform) { described_class.perform_now }

  let!(:task1) { create :task, :finished, user: user, updated_at: Date.today - 8.days }
  let!(:task2) { create :task, :finished, user: user }
  let!(:task3) { create :task, user: user, updated_at: Date.today - 8.days }
  let(:user) { create :user }

  it 'removes only finished tasks with updated_at > 7 days ago' do
    expect { perform }.to change(Task, :count).by(-1)
  end
end
