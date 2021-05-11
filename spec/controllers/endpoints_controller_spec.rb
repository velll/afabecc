require 'rails_helper'

RSpec.describe EndpointsController do
  describe 'GET index' do
    it 'renders all endpoints' do
      create_endpoint(verb: 'GET', path: 'whatever')
      create_endpoint(verb: 'POST', path: 'something_else')

      get :index
      expect(response.status).to be(200)

      endpoints = JSON.parse(response.body)

      expect(endpoints['data'].size).to be(2)
      expect(endpoints['data'].map { |record| record['attributes']['verb'] }).to eq(['GET', 'POST'])
    end
  end

  describe 'GET show' do
    let!(:endpoint) { create_endpoint(verb: 'GET', path: 'hey') }

    it 'renders a given endpoint with details' do
      get :show, params: { id: endpoint.id }

      expect(response.status).to be(200)

      attrs = JSON.parse(response.body)['data']['attributes']

      expect(attrs['verb']).to eq(endpoint.verb)
      expect(attrs['path']).to eq(endpoint.path)

      # expect(details['response']).to eq(endpoint_response)
    end

    it '404s for a nonexistent endpoint' do
      get :show, params: { id: -1 }
      expect(response.status).to be(404)
    end
  end

  describe 'POST create' do
    let(:path) { 'hey' }
    let(:example_endpoint) { build_endpoint(verb: 'GET', path: path) }
    let(:create_params) { EndpointSerializer.encode(example_endpoint) }

    it 'creates a new endpoint' do
      expect { post :create, params: { data: create_params } }
        .to change { Endpoint.count }.by(1)

      expect(response.status).to be(201)
    end

    it 'new endpoint has matching attribites' do
      post :create, params: { data: create_params }

      new_endpoint = Endpoint.find(JSON.parse(response.body)['data']['id'])

      expect(new_endpoint.verb).to eq(example_endpoint.verb)
      expect(new_endpoint.path).to eq(example_endpoint.path)

      expect(new_endpoint.response.code).to eq(example_endpoint.response.code)
      expect(new_endpoint.response.body).to eq(example_endpoint.response.body)
    end

    it 'includes a link to a new endpoint in the location header' do
      post :create, params: { data: create_params }

      new_endpoint = Endpoint.find(JSON.parse(response.body)['data']['id'])
      expect(response.headers['Location']).to eq("#{root_url}/#{new_endpoint.path}")
    end

    context 'with leading slash' do
      let(:path) { '/tomorrow' }

      it 'new endpoint has normalized path' do
        post :create, params: { data: create_params }

        new_endpoint = Endpoint.find(JSON.parse(response.body)['data']['id'])

        expect(new_endpoint.path).to eq('tomorrow')
      end
    end
  end

  describe 'PATCH update' do
    let!(:endpoint) { create_endpoint(verb: 'GET', path: 'hey') }

    let(:updated_path) { 'bye' }
    let(:updated_response_code) { 418 }
    let(:update_params) do
      EndpointSerializer.encode(endpoint).tap do |record|
        record[:attributes][:path] = updated_path
        record[:attributes][:response][:code] = updated_response_code
      end
    end

    it 'updates the existing endpoint' do
      patch :update, params: { id: endpoint.id, data: update_params }
      expect(response.status).to be(200)

      endpoint.reload

      expect(endpoint.path).to eq(updated_path)
      expect(endpoint.response.code).to eq(updated_response_code)
    end

    it '404s for a nonexistent endpoint' do
      patch :update, params: { id: -1, data: update_params }
      expect(response.status).to be(404)
    end
  end

  describe 'DELETE destroy' do
    let!(:endpoint) { create_endpoint(verb: 'GET', path: 'hey') }

    it 'removes an endpoint' do
      expect do
        delete :destroy, params: { id: endpoint.id }
      end.to change { Endpoint.count }.by(-1)

      expect(response.status).to be(204)
    end

    it '404s for a nonexistent endpoint' do
      delete :destroy, params: { id: -1 }
      expect(response.status).to be(404)
    end
  end
end
