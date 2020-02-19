# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendReminderJob, type: :job do
  describe '#perform' do
    let(:task) { create :task, user: user }
    let(:user) { create :user }

    it 'sends email correctly' do
      expect { SendReminderJob.perform_now(task) }.to have_enqueued_job.on_queue('mailers')
    end
  end
end
