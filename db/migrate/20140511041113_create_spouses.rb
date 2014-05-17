class CreateSpouses < ActiveRecord::Migration
  def change
    create_table :spouses do |t|
      t.string :fullname
      t.date :dob
      t.string :gender
      t.integer :child_id
	  t.text :description
	  
      t.timestamps
    end
  end
end
