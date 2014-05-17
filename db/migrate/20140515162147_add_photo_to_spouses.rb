class AddPhotoToSpouses < ActiveRecord::Migration
  def change
	add_attachment :spouses, :photo
  end
end
