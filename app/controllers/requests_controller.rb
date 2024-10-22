# app/controllers/requests_controller.rb

class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: [:show, :edit, :update, :approve, :reject]

  def index
    @requests = policy_scope(Request).includes(:user, :shift, :schedule).order(created_at: :desc)
    # No need to authorize the array, each individual request will be authorized in the view
  end

  def show
    authorize @request
  end

  def new
    @request = Request.new
    authorize @request
  end

  def create
    @request = current_user.requests.build(request_params)
    authorize @request
      # Retrieve the schedule for the selected shift and the shift they want to swap with
    @request.schedule_id = Shift.find(@request.shift_id).schedule_id
    swap_shift = Shift.find(@request.swap_with_shift_id)
    @request.swap_schedule_id = swap_shift.schedule_id # Assuming swap_schedule_id exists

    @request.request_status ||= "pending"
    @request.date_of_request = Time.current
    if @request.save
      redirect_to requests_path, notice: "Request created successfully."
    else
      puts @request.errors.full_messages # Debug the validation errors
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @request
  end

  def update
    authorize @request
    if @request.update(request_params)
      redirect_to requests_path, notice: "Request updated successfully."
    else
      render :edit
    end
  end

  def approve
    authorize @request, :approve?
    handle_request_update("approved", params[:comment])  # Call to a helper method
  end

  def reject
    authorize @request, :reject?
    handle_request_update("rejected", params[:comment])  # Call to a helper method
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:shift_id, :schedule_id, :swap_with_shift_id, :comment, :request_type, :request_status)
  end

  def handle_request_update(status, comment)
    respond_to do |format|
      if @request.update(request_status: status, comment: comment)
        send_approval_or_rejection_email(status)
        flash[:notice] = "Request #{status} successfully."
      else
        flash[:alert] = "Failed to #{status} the request."
      end

      format.html { redirect_to requests_path }
      format.js # Renders the appropriate .js.erb file
    end
  end

  def send_approval_or_rejection_email(status)
    if status == "approved"
      RequestMailer.approval_email(@request).deliver_later
    else
      RequestMailer.rejection_email(@request).deliver_later
    end
  end
end
