class SitesController < ApplicationController
  def index
    @sites = Site.all
    @markers = @sites.geocoded.map do |site|
      {
        lat: site.latitude,
        lng: site.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { site: })
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
      redirect_to sites_path, notice: "New site created!"
    else
      render :new
    end
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

  def site_params
    params.require(:site).permit(:name, :address, :id)
  end
end
