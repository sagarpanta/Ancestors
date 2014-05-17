class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :fatherName
	  t.text :description
      t.date :fatherDOB
      t.string :motherName
      t.date :motherDOB
	  t.integer :child_id

      t.timestamps
    end
  end
end
