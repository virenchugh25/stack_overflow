class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :email, null: false, index: {unique: true}
      t.string :name
      t.timestamp :deleted_at, index: true

      t.timestamps
    end
  end
end
