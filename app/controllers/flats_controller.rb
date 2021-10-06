class FlatsController < ApplicationController
  before_action :set_flat, only: %i[ show edit update destroy ]

  # GET /flats or /flats.json
  def index
    @flats = Flat.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
    # [{lat: 231, lng: 1246}, {lat...}]
  end

  # GET /flats/1 or /flats/1.json
  def show
  end

  # GET /flats/new
  def new
    @flat = Flat.new
  end

  # GET /flats/1/edit
  def edit
  end

  # POST /flats or /flats.json
  def create
    @flat = Flat.new(flat_params)

    if @flat.save
      redirect_to @flat
    else
      render :new
    end
  end

  # PATCH/PUT /flats/1 or /flats/1.json
  def update
    if @flat.update(flat_params)
      redirect_to @flat
    else
      render :edit
    end
  end

  # DELETE /flats/1 or /flats/1.json
  def destroy
    @flat.destroy
    redirect_to flats_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat
      @flat = Flat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flat_params
      params.require(:flat).permit(:name, :address)
    end
end
