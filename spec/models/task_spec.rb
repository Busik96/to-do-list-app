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

require 'rails_helper'

RSpec.describe Task, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
