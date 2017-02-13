require 'rails_helper'

RSpec.describe 'Players API', type: :request do
  let!(:players) { create_list(:player, 10) }
  let(:player_id) { players.first.id }

  describe 'GET /players' do
    before(:each) { get '/players' }

    it 'should return players' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'should return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /players/:id' do
    before(:each) { get "/players/#{player_id}" }

    context 'when the record exists' do
      it 'should return the player' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(player_id)
      end

      it 'should return status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:player_id) { 100 }

      it 'should return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'should return a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  describe 'POST /players' do
    let(:valid_attributes) { attributes_for(:player, name: 'David') }

    context 'when the request is valid' do
      before(:each) { post '/players', params: valid_attributes }

      it 'should create a Player' do
        expect(json['name']).to eq('David')
      end

      it 'should return a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before(:each) { post '/players', params: {} }

      it 'should return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'should return a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  describe 'PUT /players/:id' do
    let(:valid_attributes) { attributes_for(:player, name: 'David') }

    context 'when the record exists' do
      before(:each) { put "/players/#{player_id}", params: valid_attributes }

      it 'should update the record' do
        expect(response.body).to be_empty
      end

      it 'should return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
