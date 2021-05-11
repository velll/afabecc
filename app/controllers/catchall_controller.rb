class CatchallController < ApplicationController
  def index
    response = Endpoint.find_by!(verb: request.method,
                                 path: UrlUtils.normalize_path(params[:path])).response

    response.headers.each do |key, value|
      headers[key] = value
    end

    render json: response.body, status: response.code
  end
end
