class Child < ActiveRecord::Base
	belongs_to :parent
	has_many :spouses
	
	has_many :parents
	
	has_attached_file :photo, styles: {
	medium: '300x300'
	}, :default_url => '/assets/default.png'

	# Validate the attached image is image/jpg, image/png, etc
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  
	accepts_nested_attributes_for :spouses, allow_destroy: true
	
  before_save :uppercase
  
  def uppercase
	fN = fullname.split(' ').join(' ')
	self.fullname = fN.upcase
  end	
	
end
