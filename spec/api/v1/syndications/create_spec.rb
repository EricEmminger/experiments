require 'rails_helper'

RSpec.describe "syndications#create", type: :request do
  subject(:make_request) do
    jsonapi_post "/api/v1/syndications", payload
  end

  describe 'basic create' do
    let(:params) do
      attributes_for(:syndication)
    end
    let(:payload) do
      {
        data: {
          type: 'syndications',
          attributes: params
        }
      }
    end

    it 'works' do
      expect(SyndicationResource).to receive(:build).and_call_original
      expect {
        make_request
        expect(response.status).to eq(201), response.body
      }.to change { Syndication.count }.by(1)
    end
  end
end
