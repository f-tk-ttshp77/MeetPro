class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.references :msgtype, foreign_key: true, default: 1

      t.timestamps
    end
  end
end
