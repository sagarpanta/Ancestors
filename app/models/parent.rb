class Parent < ActiveRecord::Base
	has_many :children

	has_attached_file :photo, styles: {
	medium: '300x300'
	}, :default_url =>  '/assets/default.png'

	# Validate the attached image is image/jpg, image/png, etc
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
	
	accepts_nested_attributes_for :children, allow_destroy: true
	
	
  before_save :uppercase
  
  def uppercase
	fN = fatherName.split(' ').join(' ')
	mN = motherName.split(' ').join(' ')
	self.fatherName = fN.upcase
	self.motherName = mN.upcase
  end
  
  
  def self.buildtree(id, tags)
	parent = Parent.find_by_id(id)
	
	if !parent.nil?
		
		if parent.id == Parent.first.id
			tags +=  '<li>' + parent.fatherName + ' ** ' + parent.motherName + '<div style="display:none" data-url="/parents/'+parent.id.to_s+'.json" >'+parent.photo.url(:medium)+'</div>' + '<ul>'
		else
			photoURL = Child.find_by_id(parent.child_id).photo.url(:medium)
			tags +=  '<li>' + parent.fatherName + ' ** ' + parent.motherName + '<div style="display:none" data-url="/children/'+parent.child_id.to_s+'.json" >'+photoURL+'</div>' + '<ul>'
		end
		children = parent.children
		children.each do |e|
			child_as_a_father = Parent.where('child_id=?', e.id)
			if !child_as_a_father[0].nil?
				tags = Parent.buildtree(child_as_a_father[0].id, tags)
				if child_as_a_father.count >1 
					tags = Parent.buildtree(child_as_a_father[1].id, tags)
				end
			else
				spouses = ''
				e.spouses.each do |s|
					spouses += ' ** '+s.fullname
				end
				tags += '<li>'+e.fullname+spouses+ '<div style="display:none" data-url="/children/'+e.id.to_s+'.json" >'+e.photo.url(:medium)+'</div>' + '</li>'
			end
		end
		tags += '</ul></li>'
	end
	return tags
  end
  

  def self.partialtree(id, tags)
	
	clickedPerson = Child.find_by_id(id)
	parent = clickedPerson.parent

	siblings = parent.children
	
	clickedPerson_as_a_parent = Parent.where('child_id = ?', id)
	
	photoURL = parent.id == Parent.first.id ? parent.photo.url(:medium): Child.find_by_id(parent.child_id).photo.url(:medium)
	tags +=  '<li>' + parent.fatherName + ' ** ' + parent.motherName + '<div style="display:none" data-url="/children/'+parent.child_id.to_s+'.json" >'+photoURL+'</div>' + '<ul>'
	clickedPerson_as_a_parent_name = ''
		
	if clickedPerson_as_a_parent[0].nil?
		clickedPerson_children = nil
		clickedPerson_as_a_parent_name = ''
	else

		clickedPerson_as_a_parent.each do |c|
			clickedPerson_children = c.children
			clickedPerson_as_a_parent_name = c.fatherName
			
			tags +=  '<li>' + c.fatherName+' ** '+c.motherName + '<div style="display:none" data-url="/children/'+clickedPerson.id.to_s+'.json" >'+clickedPerson.photo.url(:medium)+'</div>' + '<ul>'

			if !clickedPerson_children.nil?
				clickedPerson_children.each do |e|
					spouses = ''
					e.spouses.each do |s|
						spouses += ' ** '+s.fullname
					end
					tags += '<li>'+e.fullname+spouses+ '<div style="display:none" data-url="/children/'+e.id.to_s+'.json" >'+e.photo.url(:medium)+'</div>' + '</li>'	
				end
				tags += '</ul>'
			end		
		
		end
		
	end

	if !siblings.nil?
		siblings.each do |e|
			if e.fullname != clickedPerson_as_a_parent_name
				spouses = ''
				e.spouses.each do |s|
					spouses += ' ** '+s.fullname
				end
				tags += '<li>'+e.fullname+ spouses+ '<div style="display:none" data-url="/children/'+e.id.to_s+'.json" >'+e.photo.url(:medium)+'</div>' + '</li>'	
			end
		end
		tags += '</ul>'
	end
	
	tags += '</ul></li>'
	return tags
  end

 
  
  def self.sidebar()
	@names = []
	name_part = []
	if !Parent.first.nil?
		id = Parent.first.id
		name_part <<  Parent.first.fatherName
		name_part <<  '/parents/' + Parent.first.id.to_s + '.json'
		name_part << Parent.first.photo.url(:medium)
		@names << name_part
		name_part = []
		
		Child.all.order('fullname').each do |c|
			name_part << c.fullname
			name_part << '/children/'+ c.id.to_s + '.json'
			name_part << c.photo.url(:medium)
			@names << name_part
			name_part = []
		end
	
	end	
	return @names

  end

  
  
end
