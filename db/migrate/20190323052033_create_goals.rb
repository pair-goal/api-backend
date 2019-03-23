class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.integer :index
      t.references :user_nickname, foreign_key: true
      t.string :title
      t.integer :category_num
      t.timestamp :start_date
      t.timestamp :end_date
      t.boolean :is_doing
      t.decimal :average_score
      t.string :image_path
      t.references :partner_nickname, foreign_key: true

      t.timestamps
    end
  end
end
