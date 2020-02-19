# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnqueueReminderJob, type: :job do
  describe '#perform' do
    subject(:perform) { described_class.perform_now }

    let!(:task1) { create :task, user: user, due_date: Date.tomorrow }
    let!(:task2) { create :task, :with_time, user: user, due_date: Date.tomorrow }
    let!(:task3) { create :task, user: user, due_date: Date.tomorrow + 1.day }
    let(:user) { create :user }

    it 'sets job with due_time to correct time' do
      due_time = DateTime.parse("#{task2.due_date} #{task2.due_time.strftime('%R')}") - 1.hour

      expect { perform }.to have_enqueued_job.with(task2).on_queue('mailers').at(due_time)
    end

    it 'sets job with just due_date to correct date' do
      expect { perform }.to have_enqueued_job.with(task1).on_queue('mailers')
    end

    it 'does not work for tasks with invalid due_date' do
      expect { perform }.not_to have_enqueued_job.with(task3)
    end
  end
end
