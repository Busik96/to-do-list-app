# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.task_reminder.subject
  #
  def task_reminder(task)
    @task = task
    @user = task.user

    mail to: @user.email, subject: '!!!TASK REMINDER!!!'
  end
end
