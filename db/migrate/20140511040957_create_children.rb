class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :fullname
	  t.text :description
      t.date :dob
      t.string :gender
	  t.string :state
	  t.string :country
      t.integer :parent_id

      t.timestamps
    end
  end
end
