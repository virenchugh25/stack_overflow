class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.integer :dup_id
      t.boolean :wiki, default: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
