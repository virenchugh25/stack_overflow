class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :text
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.belongs_to :question, index: true, foreign_key: true, null: false
      t.boolean :accepted
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
