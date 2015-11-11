class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id, null: false
      t.string :authentication_token, null: false

      t.timestamps
    end

    add_foreign_key :sessions, :users
  end
end
