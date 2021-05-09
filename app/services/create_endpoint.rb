module CreateEndpoint
  extend self

  def call(verb:, path:, response:)
    Endpoint.create(
      verb: verb,
      path: path,
      response: EndpointResponse.new(response)
    )
  end
end
