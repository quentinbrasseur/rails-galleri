class ArtworksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @artworks = Artwork.where.not(latitude: nil, longitude: nil)

    @hash = Gmaps4rails.build_markers(@artworks) do |artwork, marker|
      marker.lat artwork.latitude
      marker.lng artwork.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
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

  def search
    @result = [ ]  #shows the results from the filter
     Artwork.all.map do |art|
      #
      booked = false
      art.appointments.each do |appointment|
        (appointment.start_date.to_date..appointment.end_date.to_date).each do |date|
          booked = true if date.between?(Date.today   , Date.today + 50  )
        end
      end
      #
      unless booked
        artwork = {}
        artwork[:title] = art.title
        artwork[:photo] = art.photo
        @result << artwork
      end

    end
  end

  private

  def artwork_params
    params.require(:artwork).permit(:title, :category, :size, :location, :photo)
  end

end
