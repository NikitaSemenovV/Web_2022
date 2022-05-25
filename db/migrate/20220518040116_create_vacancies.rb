class CreateVacancies < ActiveRecord::Migration[7.0]
  def change
    create_table :vacancies do |t|
      t.string :title
      t.string :description
      t.string :about_us
      t.integer :user_id

      t.timestamps
    end
  end
end
