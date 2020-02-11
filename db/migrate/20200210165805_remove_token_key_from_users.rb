class RemoveTokenKeyFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :token_key, :string
  end
end
