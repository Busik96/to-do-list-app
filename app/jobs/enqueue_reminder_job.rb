# frozen_string_literal: true

class EnqueueReminderJob < ApplicationJob
  queue_as :default
  TIME_DELAY = 1.hour

  def perform
    tasks = Task.where(due_date: Date.tomorrow)

    tasks.each do |task|
      if task.due_time.present?
        due_time = DateTime.parse("#{task.due_date} #{task.due_time.strftime('%R')}") - TIME_DELAY
        SendReminderJob.set(wait_until: due_time).perform_later(task)
      else
        SendReminderJob.perform_later(task)
      end
    end
  end
end
