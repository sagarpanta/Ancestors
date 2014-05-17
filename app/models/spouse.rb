class Spouse < ActiveRecord::Base
	belongs_to :child
	
	has_attached_file :photo, styles: {
	thumb: '100x100>'
	}, :default_url => '/assets/1.png'

	# Validate the attached image is image/jpg, image/png, etc
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
	
end
