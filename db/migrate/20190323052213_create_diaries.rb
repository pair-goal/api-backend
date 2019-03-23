class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.references :goal_index, foreign_key: true
      t.text :comment

      t.timestamps
    end
  end
end
