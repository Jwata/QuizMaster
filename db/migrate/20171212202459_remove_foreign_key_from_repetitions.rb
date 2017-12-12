class RemoveForeignKeyFromRepetitions < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :repetitions, :questions
  end
end
