require 'rails_helper'

RSpec.describe CatchallController do
  let!(:endpoint) { create_endpoint(verb: 'GET', path: 'whatever') }

  it 'catches known endpoints' do
    get :index, params: { path: endpoint.path }

    expect(response.status).to be(endpoint.response.code)
    expect(response.body).to eq(endpoint.response.body)
  end

  it 'refuses to catch an endpoint when a wrong verb is used' do
    post :index, params: { path: endpoint.path }
    expect(response.status).to be(404)
  end

  context 'distractor endpoints' do
    let!(:specific_endpoint) do
      create_endpoint(verb: 'PATCH',
                      path: endpoint.path,
                      response: build_endpoint_response(code: 418))
    end

    it 'matches the correct endpoint verb' do
      patch :index, params: { path: endpoint.path }

      expect(response.status).to be(specific_endpoint.response.code)
    end
  end
end
