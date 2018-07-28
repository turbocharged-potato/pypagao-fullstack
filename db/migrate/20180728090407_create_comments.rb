class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.references :user, foreign_key: true, null: false
      t.references :answer, foreign_key: true, null: false

      t.timestamps
    end

    add_index :comments, :created_at
  end
end
