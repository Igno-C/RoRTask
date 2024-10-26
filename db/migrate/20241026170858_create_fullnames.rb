class CreateFullnames < ActiveRecord::Migration[7.2]
  def change
    create_table :fullnames do |t|
      t.string :ticker, limit: 4
      t.string :name

      t.timestamps
    end
    add_index :fullnames, :ticker
  end
end
