class Api::V1::MyUsers::UsersController < ApiController

  swagger_controller :my_users_users, "My User Management"

  swagger_api :index do
    summary "Fetches all User items"
    notes "This lists all the active users"
  end

  # GET /v1/users
  def index
    render json: User.all
  end
end
