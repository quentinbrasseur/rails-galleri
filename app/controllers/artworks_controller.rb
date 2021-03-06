
class ArtworksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index, :search]

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
    @artwork.owner = current_user

    if @artwork.save
      redirect_to artwork_path(@artwork)
    else
      render :new
    end
  end

  def show
    @artwork = Artwork.find(params[:id])

    @hash = Gmaps4rails.build_markers(@artwork) do |artwork, marker|
      marker.lat artwork.latitude
      marker.lng artwork.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
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
     @paintings = {city: "Barcelona", category: "Painting", range: "06/16/2050 - 06/16/2051"}
     @drawings = {city: "Barcelona", category: "Drawing", range: "06/16/2050 - 06/16/2051"}
     @photography = {city: "Barcelona", category: "Photography", range: "06/16/2050 - 06/16/2051"}
     @sculptures = {city: "Barcelona", category: "Sculpture", range: "06/16/2050 - 06/16/2051"}
     @performances = {city: "Barcelona", category: "Performance", range: "06/16/2050 - 06/16/2051"}
     @barcelona = {city: "Barcelona", category: "Miscellaneous", range: "06/16/2050 - 06/16/2051"}
     test = params[:test].to_i

     if test == 1
      @result = Artwork.where(category: @paintings[:category])
    elsif test == 2
      @result = Artwork.where(category: @drawings[:category])
    elsif test == 3
      @result = Artwork.where(category: @photography[:category])
    elsif test == 4
      @result = Artwork.where(category: @sculptures[:category])
    elsif test == 5
      @result = Artwork.where(category: @performances[:category])
    elsif test == 6
      @result = Artwork.where(location: @barcelona[:city])
    else
      @search = Artwork.where(category: params[:category], location: params[:city])
      date = params[:date_range]
      date = date.split(%r{\s*-\s*})
      from = date[0].to_s
      to = date[1].to_s
      @from_request = Date.strptime(from, '%m/%d/%Y')
      @to_request = Date.strptime(to, '%m/%d/%Y')

      @search.all.map do |art|  #execute for all artwork instances

       booked = false  #defaults all artwork to 'unbooked'
       art.appointments.each do |appointment|
        (appointment.start_date.to_date..appointment.end_date.to_date).each do |date|
          booked = true if date.between?(@from_request   , @to_request  )
        end
      end
      unless booked
       artwork = {}
       artwork[:id] = art.id
       artwork[:title] = art.title
       artwork[:photo] = art.photo

           artwork[:artist] = art.owner.email #change to name if you don't wamt email
           @result << artwork
         end
       end



     end

#redirect_to search_path
end



#     # ################ Below calculates city match ##################
#     #  art.location.each do |location|
#     #   booked = true if location == @user.location_request

#     # end

#     # ################ Below calculates Art Type Match ##################
#     # art.category.each do |category|
#     #  booked = true if category == @user.category_request
#     # end

#     ################ Below calculates date match ##################
#     art.appointments.each do |appointment|
#       (appointment.start_date.to_date..appointment.end_date.to_date).each do |date|
#         booked = true if date.between?(@user.start_request, @user.end_request )
#       end
# ################### Original Code from Ruben#######################



#       #
#       unless booked
#         artwork = {}
#         artwork[:title] = art.title
#         artwork[:photo] = art.photo
#         @result << artwork
#       end




private

def artwork_params
  params.require(:artwork).permit(:title, :category, :size, :location, :photo)
end

end
