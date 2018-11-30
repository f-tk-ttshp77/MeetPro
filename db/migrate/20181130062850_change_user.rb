class ChangeUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :image_name, :string, default: "default.jpg"
  end
end
