class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: false do |t|
      t.string :nickname, primary_key: true
      t.string :password_digest
      t.string :image_path
      t.text :description

      t.timestamps
    end
  end
end
