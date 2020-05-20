class ApplicationController < ActionController::Base
  before_action :authenticate_client!

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

end


