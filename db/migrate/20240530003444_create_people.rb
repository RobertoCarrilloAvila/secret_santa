class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.references :family, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
