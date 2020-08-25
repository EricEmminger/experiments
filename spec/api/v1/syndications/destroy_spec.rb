require 'rails_helper'

RSpec.describe "syndications#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/syndications/#{syndication.id}"
  end

  describe 'basic destroy' do
    let!(:syndication) { create(:syndication) }

    it 'updates the resource' do
      expect(SyndicationResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Syndication.count }.by(-1)
      expect { syndication.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
