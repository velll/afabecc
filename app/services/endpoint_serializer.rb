module EndpointSerializer
  extend self

  def encode(endpoint)
    {
      type: 'endpoints',
      id: endpoint.id,
      attributes: {
        verb: endpoint.verb,
        path: endpoint.path,
        response: {
          code: endpoint.response.code,
          headers: endpoint.response.headers,
          body: endpoint.response.body
        }
      }
    }
  end
end
