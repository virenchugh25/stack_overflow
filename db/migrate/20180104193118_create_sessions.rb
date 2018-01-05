class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.string :auth_token, null: false, index: { unique: true }
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
