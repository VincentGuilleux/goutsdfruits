class CustomersController < ApplicationController
  before_action :authenticate_client!
end


