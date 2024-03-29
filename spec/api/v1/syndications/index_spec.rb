require 'rails_helper'

RSpec.describe "syndications#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/syndications", params: params
  end

  describe 'basic fetch' do
    let!(:syndication1) { create(:syndication) }
    let!(:syndication2) { create(:syndication) }

    it 'works' do
      expect(SyndicationResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['syndications'])
      expect(d.map(&:id)).to match_array([syndication1.id, syndication2.id])
    end
  end
end
