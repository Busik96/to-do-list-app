class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :description
      t.string :address
      t.time :due_time
      t.date :due_date
      t.boolean :finished, default: false
      t.references :user

      t.timestamps
    end
  end
end
