class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :enc_password, null: false
      t.string :salt, null: false, index: true
      t.string :email, null: false, index: true, unique: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
