class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :answer, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :score, null: false

      t.timestamps
    end

    add_index :votes, :score, using: 'hash'
  end
end
