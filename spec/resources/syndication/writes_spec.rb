require 'rails_helper'

RSpec.describe SyndicationResource, type: :resource do
  describe 'creating' do
    let(:payload) do
      {
        data: {
          type: 'syndications',
          attributes: attributes_for(:syndication)
        }
      }
    end

    let(:instance) do
      SyndicationResource.build(payload)
    end

    it 'works' do
      expect {
        expect(instance.save).to eq(true), instance.errors.full_messages.to_sentence
      }.to change { Syndication.count }.by(1)
    end
  end

  describe 'updating' do
    let!(:syndication) { create(:syndication) }

    let(:payload) do
      {
        data: {
          id: syndication.id.to_s,
          type: 'syndications',
          attributes: { } # Todo!
        }
      }
    end

    let(:instance) do
      SyndicationResource.find(payload)
    end

    xit 'works (add some attributes and enable this spec)' do
      expect {
        expect(instance.update_attributes).to eq(true)
      }.to change { syndication.reload.updated_at }
      # .and change { syndication.foo }.to('bar') <- example
    end
  end

  describe 'destroying' do
    let!(:syndication) { create(:syndication) }

    let(:instance) do
      SyndicationResource.find(id: syndication.id)
    end

    it 'works' do
      expect {
        expect(instance.destroy).to eq(true)
      }.to change { Syndication.count }.by(-1)
    end
  end
end
