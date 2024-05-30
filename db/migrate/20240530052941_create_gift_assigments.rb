class CreateGiftAssigments < ActiveRecord::Migration[7.0]
  def change
    create_table :gift_assigments do |t|
      t.references :giver, null: false, foreign_key: { to_table: :people }
      t.references :recipient, null: false, foreign_key: { to_table: :people }
      t.integer :year

      t.timestamps
    end

    add_index :gift_assigments, %i[giver_id recipient_id year], unique: true
  end
end
