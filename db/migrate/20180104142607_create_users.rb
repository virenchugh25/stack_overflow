class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :enc_password
      t.string :salt, index: {unique: true}
      t.string :email, null: false, index: {unique: true}
      t.string :name
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
