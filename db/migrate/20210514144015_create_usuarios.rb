class CreateUsuarios < ActiveRecord::Migration[6.1]
  def change
    create_table :usuarios do |t|
      t.string :email
      t.string :password

      t.timestamps
    end
    add_index :usuarios, :email, unique: true
  end
end
