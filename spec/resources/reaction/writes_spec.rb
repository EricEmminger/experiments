require 'rails_helper'

RSpec.describe ReactionResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'reactions',
          attributes: attributes_for(:reaction)
        }
      }
    end

    let(:instance) do
      ReactionResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Reaction.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:reaction) { create(:reaction) }

    let(:payload) do
      {
        data: {
          id: reaction.id.to_s,
          type: 'reactions',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      ReactionResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { reaction.reload.updated_at }
      # .and change { reaction.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:reaction) { create(:reaction) }

    let(:instance) do
      ReactionResource.find(id: reaction.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Reaction.count }.by(-1)
    end
  end
end
