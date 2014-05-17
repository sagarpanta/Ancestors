class SpousesController < ApplicationController
  before_action :set_spouse, only: [:show, :edit, :update, :destroy]

  # GET /spouses
  # GET /spouses.json
  def index
    @spouses = Spouse.all
  end

  # GET /spouses/1
  # GET /spouses/1.json
  def show
  end

  # GET /spouses/new
  def new
    @spouse = Spouse.new
  end

  # GET /spouses/1/edit
  def edit
  end

  # POST /spouses
  # POST /spouses.json
  def create
    @spouse = Spouse.new(spouse_params)

    respond_to do |format|
      if @spouse.save
        format.html { redirect_to @spouse, notice: 'Spouse was successfully created.' }
        format.json { render :show, status: :created, location: @spouse }
      else
        format.html { render :new }
        format.json { render json: @spouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spouses/1
  # PATCH/PUT /spouses/1.json
  def update
    respond_to do |format|
      if @spouse.update(spouse_params)
        format.html { redirect_to @spouse, notice: 'Spouse was successfully updated.' }
        format.json { render :show, status: :ok, location: @spouse }
      else
        format.html { render :edit }
        format.json { render json: @spouse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spouses/1
  # DELETE /spouses/1.json
  def destroy
    @spouse.destroy
    respond_to do |format|
      format.html { redirect_to spouses_url, notice: 'Spouse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spouse
      @spouse = Spouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spouse_params
      params.require(:spouse).permit(:fullname, :dob, :gender, :child_id,:photo, :description,:_destroy)
	end
end
