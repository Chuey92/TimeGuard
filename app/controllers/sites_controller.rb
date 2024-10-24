class SitesController < ApplicationController
  def index
    @sites = Site.all
    @markers = @sites.geocoded.map do |site|
      {
        lat: site.latitude,
        lng: site.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { site: site})
      }
    end
  end

  def new
    @site = Site.new
  end

  def create
    @site = Site.new(site_params)
    @site.user = current_user
    if @site.save
      redirect_to sites_path, notice: "Site was successfully created."
    else
      flash.now[:alert] = "There was an issue creating the site."
      render :new
    end
  rescue StandardError => e
    Rails.logger.error "Error creating site: #{e.message}"
    render :new
  end

  def show
    @site = Site.find(params[:id])
  end

  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to sites_path, notice: "Site successfully removed."
  end

  private

  def authorize_manager
    unless current_user.manager?
      redirect_to root_path, alert: "Only managers can create sites."
    end
  end

  def site_params
    params.require(:site).permit(:name, :address, :id)
  end
end
