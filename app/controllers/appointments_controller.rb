class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all #all appts for current user

  end

  def show
  @appointment = Appointment.find(params[:id])

  end


  def new
     @artwork = Artwork.find(params[:artwork_id])
     @appointment = Appointment.new
  end

  def create

    @artwork = Artwork.find(params[:artwork_id])
    @appointment = Appointment.new(appointment_params)
    @appointment.artwork = @artwork
    @appointment.user = current_user
    @appointment.save


    if @appointment.save
      redirect_to appointment_path(@appointment)
    else
      render :new
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])

    #redirect_to homepage_path(@appointment)
  end

  def update

    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_params)

    redirect_to appointment_path(@appointment)

  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path
  end

   def appointment_params
    params.require(:appointment).permit(:start_date, :end_date)
  end

end
