# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'task_reminder' do
    let(:mail) { UserMailer.task_reminder(task) }
    let(:task) { create :task, user: user }
    let(:user) { create :user }

    it 'renders the headers' do
      expect(mail.subject).to eq('!!!TASK REMINDER!!!')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(user.name)
    end
  end
end
