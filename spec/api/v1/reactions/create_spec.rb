require 'rails_helper'

RSpec.describe "reactions#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/reactions", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:reaction)
    end
    let(:payload) do
      {
        data: {
          type: 'reactions',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(ReactionResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Reaction.count }.by(1)
    end
  end
end
