require 'rails_helper'

RSpec.describe "syndications#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/syndications/#{syndication.id}", payload
  end

  describe 'basic update' do
    let!(:syndication) { create(:syndication) }

    let(:payload) do
      {
        data: {
          id: syndication.id.to_s,
          type: 'syndications',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(SyndicationResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { syndication.reload.attributes }
    end
  end
end
