class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :answer, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :score, null: false, default: 0

      t.timestamps
    end

    add_index :votes, :score, using: 'hash'
    add_index :votes, [:answer_id, :user_id], unique: true
  end
end
