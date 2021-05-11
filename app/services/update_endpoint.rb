module UpdateEndpoint
  extend self

  def call(endpoint:, verb:, path:, response:)
    Endpoint.transaction do
      endpoint.update(verb: verb,
                      path: UrlUtils.normalize_path(path))
      endpoint.response.update(code: response[:code],
                               headers: response[:headers],
                               body: response[:body])
    end

    endpoint
  end
end
