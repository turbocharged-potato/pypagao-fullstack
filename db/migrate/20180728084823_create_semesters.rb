class CreateSemesters < ActiveRecord::Migration[5.2]
  def change
    create_table :semesters do |t|
      t.integer :start_year, null: false
      t.integer :end_year, null: false
      t.integer :number, null: false
      t.references :course, foreign_key: true, null: false

      t.timestamps
    end

    add_index :semesters, [:start_year, :end_year, :number, :course_id], unique: true, name: 'unique_constraint_thingy'
  end
end
