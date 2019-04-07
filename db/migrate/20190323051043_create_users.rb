class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :password_digest
      t.string :image_path
      t.text :description

      t.timestamps
    end
  end
end
