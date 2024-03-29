class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]

include ApplicationHelper
  # GET /cities
  # GET /cities.json
  def index
    @cities = City.all
  end

  # GET /cities/1
  # GET /cities/1.json
  def show
  end

  # GET /cities/new
  def new
    @city = City.new
  end

  # GET /cities/1/edit
  def edit
  end

  # POST /cities
  # POST /cities.json
  def create
    @city = City.new(city_params)

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cities/1
  # PATCH/PUT /cities/1.json
  def update
    respond_to do |format|
      if @city.update(city_params)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cities/1
  # DELETE /cities/1.json
  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params.require(:city).permit(:name)
    end

    def youwon
      @cities = City.all
    end

    def new
      @city = City.new
      @cities = City.all      
    end

    def create
      @message = ""
      @city = City.new(city_params)
      #check if duplicate
      @cities = City.all
      correct = check_answer(@city.name)
      is_dup = check_for_dup(@city.name,@cities)

      # error messages
      if correct==false
        @message = "That is not a city TTS is in."
      elsif is_dup==true
        @message = "You already got that one!"          
    end

    respond_to do |format|
      #if we have > 1 city left to name, and the user's answer is true and not a duplicate answer, we'll save it in the database and redirect back to the same page
  if @cities.count <= 4 && correct == true && is_dup == false && @city.save
  format.html { redirect_to new_city_path, notice: 'City was successfully recorded.' }

  format.json { render action: 'show', status: :created, location: @city }

  #if this is our last city to name, and the user's answer is true and not a duplicate answer, we'll save it in the database and redirect to the 'you won!' page

  elsif @cities.count == 5 && correct == true && is_dup == false && @city.save

  format.html { redirect_to youwon_path, notice: 'City was successfully created.' }

  format.json { render action: 'show', status: :created, location: @city }

  else
  format.html { render action: 'new' }
  format.json { render json: @city.errors, status: :unprocessable_entity }

  end
end