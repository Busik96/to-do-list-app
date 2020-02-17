# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'task_reminder' do
    let(:mail) { UserMailer.task_reminder }

    it 'renders the headers' do
      expect(mail.subject).to eq('Task reminder')
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
