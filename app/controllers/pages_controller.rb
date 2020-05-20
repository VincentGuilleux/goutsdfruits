class PagesController < ApplicationController
  skip_before_action :authenticate_client!

  def home
  end

  def show
    render template: "pages/#{params[:page]}"
  end

end
