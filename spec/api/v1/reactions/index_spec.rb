require 'rails_helper'

RSpec.describe "reactions#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/reactions", params: params
  end

  describe 'basic fetch' do
    let!(:reaction1) { create(:reaction) }
    let!(:reaction2) { create(:reaction) }

    it 'works' do
      expect(ReactionResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['reactions'])
      expect(d.map(&:id)).to match_array([reaction1.id, reaction2.id])
    end
  end
end
