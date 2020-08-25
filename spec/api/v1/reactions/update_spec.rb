require 'rails_helper'

RSpec.describe "reactions#update", type: :request do
  subject(:make_request) do
    jsonapi_put "/api/v1/reactions/#{reaction.id}", payload
  end

  describe 'basic update' do
    let!(:reaction) { create(:reaction) }

    let(:payload) do
      {
        data: {
          id: reaction.id.to_s,
          type: 'reactions',
          attributes: {
            # ... your attrs here
          }
        }
      }
    end

    # Replace 'xit' with 'it' after adding attributes
    xit 'updates the resource' do
      expect(ReactionResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { reaction.reload.attributes }
    end
  end
end
