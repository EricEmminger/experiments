require 'rails_helper'

RSpec.describe "subscriptions#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/subscriptions", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:subscription)
    end
    let(:payload) do
      {
        data: {
          type: 'subscriptions',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(SubscriptionResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Subscription.count }.by(1)
    end
  end
end
