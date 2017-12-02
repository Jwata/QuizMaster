class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :content, null: false
      t.string :answer, null: false

      t.timestamps
    end
  end
end
