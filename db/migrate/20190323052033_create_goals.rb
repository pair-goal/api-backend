class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :title
      t.integer :category_num
      t.timestamp :start_date
      t.timestamp :end_date
      t.boolean :is_doing, default: true
      t.decimal :average_score, default: 0
      t.integer :zero_score, default: 0
      t.integer :one_score, default: 0
      t.integer :two_score, default: 0
      t.integer :three_score, default: 0
      t.integer :four_score, default: 0
      t.integer :five_score, default: 0
      t.string :image_path
      t.string :partner_name
      t.string :conversation_id

      t.timestamps
    end

    add_reference :goals, :user_id
    add_reference :goals, :partner_id
    add_reference :goals, :last_diary_id

    rename_column :goals, :user_id_id, :user_id
    rename_column :goals, :partner_id_id, :partner_id
    rename_column :goals, :last_diary_id_id, :last_diary_id
  end
end
