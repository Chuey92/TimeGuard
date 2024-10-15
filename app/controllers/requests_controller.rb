class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:show, :edit, :update, :approve, :reject]

  def index
    @requests = policy_scope(Request)
  end

  def show
    authorize @request
  end

  def new
    @request = Request.new
    authorize @request
  end

  def create
    @request = Request.new(request_params)
    authorize @request
    if @request.save
      redirect_to @request, notice: "Request created successfully."
    else
      render :new
    end
  end

  def update
    authorize @request
    if @request.update(request_params)
      redirect_to @request, notice: "Request updated successfully."
    else
      render :edit
    end
  end

  def approve
    authorize @request, :approve?
    @request.update(request_status: "approved")
    redirect_to @request, notice: "Request approved."
  end

  def reject
    authorize @request, :reject?
    @request.update(request_status: "rejected")
    redirect_to @request, notice: "Request rejected."
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:shift_id, :schedule_id, :date_of_request, :comment, :request_type, :request_status)
  end
end
