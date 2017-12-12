class CreateRepetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :repetitions do |t|
      t.integer :user_id, null: false
      t.integer :question_id, null: false
      t.timestamp :due_at, null: false
      t.integer :iteration, null: false
      t.integer :interval, null: false
      t.integer :ef, null: false
      t.timestamps

      t.index [:user_id, :question_id], unique: true
      t.index [:user_id, :due_at] # for search query
    end

    add_foreign_key :repetitions, :questions
    add_foreign_key :repetitions, :users
  end
end
