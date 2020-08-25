require 'rails_helper'

RSpec.describe "syndications#show", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/syndications/#{syndication.id}", params: params
  end

  describe 'basic fetch' do
    let!(:syndication) { create(:syndication) }

    it 'works' do
      expect(SyndicationResource).to receive(:find).and_call_original
      make_request
      expect(response.status).to eq(200)
      expect(d.jsonapi_type).to eq('syndications')
      expect(d.id).to eq(syndication.id)
    end
  end
end
