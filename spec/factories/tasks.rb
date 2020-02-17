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
FactoryBot.define do
  factory :task do
    description { Faker::Lorem.paragraph }
    address { Faker::Address.city }
    due_date { Date.tomorrow }
    due_time { '14:00' }

    trait :finished do
      finished { true }
    end
  end
end
