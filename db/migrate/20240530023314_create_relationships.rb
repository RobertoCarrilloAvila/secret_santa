# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.references :person, null: false, foreign_key: true
      t.references :linked_person, null: false, foreign_key: { to_table: :people }
      t.string :relationship_type

      t.timestamps
    end

    add_index :relationships, %i[person_id linked_person_id], unique: true
  end
end
