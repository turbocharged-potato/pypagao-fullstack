class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :code, null: false
      t.references :university, foreign_key: true, null: false

      t.timestamps
    end

    add_index :courses, :code, unique: true
  end
end
