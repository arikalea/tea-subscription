class CreateTeas < ActiveRecord::Migration[5.2]
  def change
    create_table :teas do |t|
      t.references :subscription, foreign_key: true
      t.string :title
      t.string :description
      t.integer :brew_time

      t.timestamps
    end
  end
end
