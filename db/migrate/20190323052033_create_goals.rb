class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.references :user_nickname_id
      t.string :title
      t.integer :category_num
      t.timestamp :start_date
      t.timestamp :end_date
      t.boolean :is_doing
      t.decimal :average_score
      t.string :image_path
      t.references :partner_nickname_id

      t.timestamps
    end

    add_reference :goals, :user_nickname
    add_reference :goals, :partner_nickname
  end
end
