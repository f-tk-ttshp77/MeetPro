class CreateMsgtypes < ActiveRecord::Migration[5.2]
  def change
    create_table :msgtypes do |t|
      t.string :content

      t.timestamps
    end
  end
end
