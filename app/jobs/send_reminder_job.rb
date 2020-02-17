# frozen_string_literal: true

class SendReminderJob < ApplicationJob
  queue_as :mailer

  def perform(task)
    UserMailer.task_reminder(task).deliver_later
  end
end
