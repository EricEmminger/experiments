require 'rails_helper'

RSpec.describe "reactions#destroy", type: :request do
  subject(:make_request) do
    jsonapi_delete "/api/v1/reactions/#{reaction.id}"
  end

  describe 'basic destroy' do
    let!(:reaction) { create(:reaction) }

    it 'updates the resource' do
      expect(ReactionResource).to receive(:find).and_call_original
      expect {
        make_request
        expect(response.status).to eq(200), response.body
      }.to change { Reaction.count }.by(-1)
      expect { reaction.reload }
        .to raise_error(ActiveRecord::RecordNotFound)
      expect(json).to eq('meta' => {})
    end
  end
end
