class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :name, null: false
      t.integer :number, null: false
      t.references :paper, foreign_key: true, null: false

      t.timestamps
    end

    add_index :questions, :number, unique: true
  end
end
