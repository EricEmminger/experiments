require 'rails_helper'

RSpec.describe "reactions#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/reactions/#{reaction.id}", params: params
  end

  describe 'basic fetch' do
    let!(:reaction) { create(:reaction) }

    it 'works' do
      expect(ReactionResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('reactions')
      expect(d.id).to eq(reaction.id)
    end
  end
end
