class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  # GET /parents
  # GET /parents.json
  def index
    @parents = Parent.all
  end

  # GET /parents/1
  # GET /parents/1.json
  def show
  	@jsonData = {'x' => '<ul><li>'+@parent.fatherName.upcase+' ** '+@parent.motherName.upcase+'</li></ul>' , 'y'=> @parent.photo.url(:medium), 'z' => @parent.description}
		
	respond_with(@jsonData) do |format|
      format.json {render json:@jsonData}
    end
  end

  # GET /parents/new
  def new
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  # POST /parents.json
  def create
    @parent = Parent.new(parent_params)
	
    respond_to do |format|
      if @parent.save
		
		#parent: father and mother
		fathername = @parent.fatherName
		mothername = @parent.motherName
	
		
		#the same child who is now a father
		child = Child.where('fullname = ?', fathername)

		if child[0].nil?
			#or the same child who is now a mother
			child = Child.where('fullname = ?', mothername)
		end
		
		
		fatherfatherName = params[:fatherfatherName].split(' ').join(' ').upcase
		if !child[0].nil? and child[0].parent.fatherName == fatherfatherName
			#the child's spouses
			spouses = child[0].spouses
			
			childExists = 0
			#loop to see if the parents are same as the child and spouse
			spouses.each do |s|
				spouse = s.fullname
				
				if spouse == fathername or spouse == mothername
					childExists = 1
				end
			end
			
			if childExists ==1
				@parent.update_attribute(:child_id, child[0].id)
				@parent.save
			else
				@parent.update_attribute(:child_id, 0)
				@parent.save
			
			end
		end
				
        format.html { redirect_to @parent, notice: 'Parent was successfully created.' }
        format.json { render :show, status: :created, location: @parent }
      else
        format.html { render :new }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parents/1
  # PATCH/PUT /parents/1.json
  def update
    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to @parent, notice: 'Parent was successfully updated.' }
        format.json { render :show, status: :ok, location: @parent }
      else
        format.html { render :edit }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1
  # DELETE /parents/1.json
  def destroy
    @parent.destroy
    respond_to do |format|
      format.html { redirect_to parents_url, notice: 'Parent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_params
      params.require(:parent).permit(:fatherName, :fatherDOB, :motherName, :motherDOB, :photo, :description, children_attributes: [:id, :fullname, :dob, :gender, :parent_id, :state, :country, :photo,:description,  :_destroy, spouses_attributes: [:id, :fullname, :dob, :gender, :child_id, :photo, :description, :_destroy]])
    end
end
