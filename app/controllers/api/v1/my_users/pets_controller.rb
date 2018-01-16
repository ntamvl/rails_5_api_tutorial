module Api::V1
  class MyUsers::PetsController < ApiController
    swagger_controller :pets, "My User Management"

    swagger_api :index do
      summary "Fetches all User items"
      notes "This lists all the active users"
    end

    # GET /v1/users
    def index
      render json: User.all
    end
  end
end
