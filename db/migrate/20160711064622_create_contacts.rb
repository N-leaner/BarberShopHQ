class CreateContacts < ActiveRecord::Migration
  def change

	create_table :contacts do |t|
		t.string :email
  		t.text :note

  		t.timestamps
  	end

  end
end
