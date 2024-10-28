class CreateQuotes < ActiveRecord::Migration[7.2]
  def change
    create_table :quotes do |t|
      t.string :ticker, limit: 4
      t.datetime :timestamp
      t.integer :price

      t.timestamps
    end
    add_index :quotes, :ticker
  end
end
