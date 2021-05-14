class CreateCuenta < ActiveRecord::Migration[6.1]
  def change
    create_table :cuenta do |t|
      t.decimal :saldo, precision: 8, scale: 2
      t.belongs_to :usuario, null: false, foreign_key: true

      t.timestamps
    end
  end
end
