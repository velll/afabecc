module BuildHelpers
  def build_endpoint_response_body(hash: { 'some' => 'hash' })
    hash.to_json
  end

  def build_endpoint_response(code: 200, body: build_endpoint_response_body)
    EndpointResponse.new(code: code, headers: {}, body: body)
  end

  def build_endpoint(verb: 'GET', path: 'whatever', response: build_endpoint_response)
    Endpoint.new(
      verb: verb,
      path: path,
      response: response
    )
  end

  def create_endpoint(verb: 'GET', path: 'whatever', response: build_endpoint_response)
    endpoint = build_endpoint(verb: verb, path: path, response: response)
    endpoint.save

    endpoint
  end
end
