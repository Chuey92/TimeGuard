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
      redirect_to dashboard_path, notice: "Site was successfully created."
    else
      flash.now[:alert] = "There was an issue creating the site."
      render :new
    end
  rescue StandardError => e
    Rails.logger.error "Error creating site: #{e.message}"
    render :new
  end

  private

  def site_params
    params.require(:site).permit(:name, :address)
  end
end
