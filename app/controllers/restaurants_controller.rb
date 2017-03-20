class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = policy_scope(Restaurant)
    # not authorize since what we put in application controller, but poclity scope
    # scope handles the index, you put Restaurant.all in the resolve method in restaurant_policy
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    authorize @restaurant
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    authorize @restaurant
  end

  # GET /restaurants/1/edit
  def edit
    authorize @restaurant
  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    authorize @restaurant
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /restaurants/1
  # PATCH/PUT /restaurants/1.json
  def update
    authorize @restaurant
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    authorize @restaurant
    @restaurant.destroy
      redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :user_id)
    end
end
