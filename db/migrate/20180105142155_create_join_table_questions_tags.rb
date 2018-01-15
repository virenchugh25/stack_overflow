class CreateJoinTableQuestionsTags < ActiveRecord::Migration[5.1]
  def change
    create_join_table :questions, :tags do |t|
      t.belongs_to :question, index: true, null: false, foreign_key: true
      t.belongs_to :tag, index: true, null: false, foreign_key: true
      t.timestamp :deleted_at

      t.t.timestamps
    end
  end
end
