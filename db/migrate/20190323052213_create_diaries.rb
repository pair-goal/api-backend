class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      t.text :comment
      t.integer :score
      t.string :date

      t.timestamps
    end

    add_reference :diaries, :goal
    add_reference :diaries, :pre
    add_reference :diaries, :next
  end
end
