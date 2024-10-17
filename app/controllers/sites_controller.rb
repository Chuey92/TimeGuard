class SitesController < ApplicationController
  def index
    @sites = Site.all
    @markers = @sites.geocoded.map do |site|
      {
        lat: site.latitude,
        lng: site.longitude
      }
    end
  end
end
