class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.text :comment
      t.integer :score

      t.timestamps
    end

    add_reference :diaries, :goal
  end
end
