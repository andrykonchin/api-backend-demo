class CreateDeviceSessions < ActiveRecord::Migration
  def change
    create_table :device_sessions do |t|
      t.string      :authentication_token, null: false
      t.integer     :user_id,              null: false
      t.timestamps
    end

    add_foreign_key :device_sessions, :users
  end
end
