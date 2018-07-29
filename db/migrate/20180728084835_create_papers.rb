class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.string :name, null: false
      t.references :semester, foreign_key: true, null: false

      t.timestamps
    end

    add_index :papers, [:name, :semester_id], unique: true
  end
end
