class CreateSummeries < ActiveRecord::Migration[7.0]
  def change
    create_table :summeries do |t|
      t.string :title
      t.string :about
      t.string :skills
      t.integer :user_id

      t.timestamps
    end
  end
end
