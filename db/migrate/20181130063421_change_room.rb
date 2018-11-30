class ChangeRoom < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :name, :string
    add_column :rooms, :room_state, :string, default: '0'
    add_column :rooms, :password, :string
    add_column :rooms, :password_digest, :string
    add_column :rooms, :roomidname, :string
  end
end
