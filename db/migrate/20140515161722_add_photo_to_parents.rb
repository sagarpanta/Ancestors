class AddPhotoToParents < ActiveRecord::Migration
  def change
	add_attachment :parents, :photo
  end
end
