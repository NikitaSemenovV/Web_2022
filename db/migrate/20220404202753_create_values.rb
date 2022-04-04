class CreateValues < ActiveRecord::Migration[7.0]
  def change
    create_table :values do |t|
      t.integer :value
      t.integer :user_id
      t.integer :image_id

      t.timestamps
    end
  end
end
