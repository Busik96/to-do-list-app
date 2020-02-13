# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  address     :string
#  description :string
#  due_date    :date
#  due_time    :time
#  finished    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#

class Task < ApplicationRecord
  belongs_to :user

  validates :description, presence: true

  scope :pending, -> { where(finished: false).order(created_at: :asc) }
  scope :finished, -> { where(finished: true).order(updated_at: :desc) }
end
