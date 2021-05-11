module CreateEndpoint
  extend self

  def call(verb:, path:, response:)
    Endpoint.create(verb: verb,
                    path: path,
                    response: EndpointResponse.new(code: response[:code],
                                                   headers: response[:headers],
                                                   body: response[:body]))
  end
end
