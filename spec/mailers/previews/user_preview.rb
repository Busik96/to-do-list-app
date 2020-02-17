# frozen_string_literal: true

class UserPreview < ActionMailer::Preview
  def task_reminder
    UserMailer.task_reminder
  end
end
