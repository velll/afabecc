require 'rails_helper'

RSpec.describe CreateEndpoint do
  let(:verb) { 'do' }
  let(:path) { 'something?cool=true' }

  let(:response_attrs) do
    {
      code: 200,
      headers: {},
      body: 'Oh dear!'
    }
  end

  subject do
    CreateEndpoint.call(verb: verb, path: path, response: response_attrs)
  end

  it 'creates new objects in db' do
    expect { subject }.to change { Endpoint.count }.by(1)
                      .and change { EndpointResponse.count }.by(1)
  end
end
