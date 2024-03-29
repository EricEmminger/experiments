require 'rails_helper'

RSpec.describe "subscriptions#index", type: :request do
  let(:params) { {} }

  subject(:make_request) do
    jsonapi_get "/api/v1/subscriptions", params: params
  end

  describe 'basic fetch' do
    let!(:subscription1) { create(:subscription) }
    let!(:subscription2) { create(:subscription) }

    it 'works' do
      expect(SubscriptionResource).to receive(:all).and_call_original
      make_request
      expect(response.status).to eq(200), response.body
      expect(d.map(&:jsonapi_type).uniq).to match_array(['subscriptions'])
      expect(d.map(&:id)).to match_array([subscription1.id, subscription2.id])
    end
  end
end
