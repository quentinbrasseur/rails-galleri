class ArtworksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @artworks = Artwork.all
  end

  def new
    @artwork = Artwork.new
  end

  def create
    @artwork = Artwork.new(artwork_params)
    if @artwork.save
      redirect_to artwork_path(@artwork)
    else
      render :new
    end
  end

  def show
    @artwork = Artwork.find(params[:id])
  end

  def edit
    @artwork = Artwork.find(params[:id])
  end

  def update
    @artwork = Artwork.find(params[:id])
    if @artwork.update(artwork_params)
      redirect_to artwork_path(@artwork)
    else
      render :edit
    end
  end

  def destroy
    @artwork = Artwork.find(params[:id])
    @artwork.destroy
    redirect_to artworks_path
  end

  # def search
  #   a = Artwork.all.map do |art|
  #     #
  #     rej = art.appointments.reject do |appointment|
  #       booked = false
  #       (appointment.start_date.to_date..appointment.end_date.to_date).each do |date|
  #         booked = true if date.between?(Date.today  , Date.today + 5  )
  #       end
  #       booked
  #     end
  #     #
  #   end
  #   raise
  # end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :category, :size, :location)
  end

end
