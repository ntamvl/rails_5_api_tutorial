module Api::V1
  class ProductsController < ApiController
    swagger_controller :products, "Products Management"

    swagger_api :index do
      summary "Fetches all User items"
      notes "This lists all the active users"
    end

    def index
      render json: User.all
    end
  end
end
