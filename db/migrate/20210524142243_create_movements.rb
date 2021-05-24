class CreateMovements < ActiveRecord::Migration[6.1]
  def change
    create_table :movements do |t|
      t.decimal :balance, precision: 8, scale: 2
      t.date :when
      t.belongs_to :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
