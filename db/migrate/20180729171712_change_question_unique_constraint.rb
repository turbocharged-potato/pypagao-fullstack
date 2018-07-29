class ChangeQuestionUniqueConstraint < ActiveRecord::Migration[5.2]
  def change
    remove_index :questions, :number
    add_index :questions, %i[number paper_id], unique: true
  end
end
