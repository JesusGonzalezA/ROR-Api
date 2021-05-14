class CreateMovimientos < ActiveRecord::Migration[6.1]
  def change
    create_table :movimientos do |t|
      t.decimal :importe, precision: 8, scale: 2
      t.date :fecha_hora
      t.belongs_to :cuenta, null: false, foreign_key: true

      t.timestamps
    end
  end
end
