class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :phone_number
      t.string :first_name
      t.string :last_name
      t.string :zip_code

      t.timestamps
    end
  end
end
