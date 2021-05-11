class CatchallController < ApplicationController
  def index
    response = Endpoint.find_by!(verb: request.method, path: params[:path]).response

    render json: response.body, status: response.code
  end
end
