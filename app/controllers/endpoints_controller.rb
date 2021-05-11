class EndpointsController < ApplicationController
  def index
    endpoints = Endpoint.all

    render json: {
      data: endpoints.map { |endpoint| EndpointSerializer.encode(endpoint) }
    }
  end

  def show
    endpoint = Endpoint.find(params[:id])

    render json: { data: EndpointSerializer.encode(endpoint) }
  end

  def create
    endpoint = CreateEndpoint.call(verb: create_params[:verb],
                                   path: create_params[:path],
                                   response: create_params[:response])
    if endpoint.valid?
      render json: { data: EndpointSerializer.encode(endpoint) }, status: :created
    else
      render json: { errors: endpoint.errors }, status: :unprocessable_entity
    end
  end

  def update
    endpoint = Endpoint.find(params[:id])
    updated_endpoint = UpdateEndpoint.call(endpoint: endpoint,
                                           verb: create_params[:verb],
                                           path: create_params[:path],
                                           response: create_params[:response])

    if updated_endpoint.valid?
      render json: { data: EndpointSerializer.encode(updated_endpoint) }, status: :ok
    else
      render json: { errors: updated_endpoint.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    endpoint = Endpoint.find(params[:id])
    endpoint.destroy!

    render status: :no_content
  end

  private

  def create_params
    return @create_params if @create_params

    attributes.require(:verb)
    attributes.require(:path)
    attributes.require(:response).require(:code)

    @create_params = attributes.permit(:verb, :path, response: [:code, :body, { headers: {} }])
  end

  def attributes
    @attributes ||= params.require(:data).require(:attributes)
  end
end
