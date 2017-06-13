class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
  end

  def show

  end

  def new
     @appointment = Appointment.new
  end

  def create
    def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to appointment_path(@appointment)
    else
      render :new
    end
  end
  end

  def edit
  end

  def update
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to homepage_path
  end
end
