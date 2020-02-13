# frozen_string_literal: true

class FinishedTasksCleanerJob < ApplicationJob
  queue_as :default

  def perform
    Task.where(
      'finished = ? AND updated_at <= ?', true, 7.days.ago.beginning_of_day
    ).destroy_all
  end
end
