require 'rails_helper'

RSpec.describe ReactionResource, type: :resource do
  describe 'serialization' do
    let!(:reaction) { create(:reaction) }

    it 'works' do
      render
      data = jsonapi_data[0]
      expect(data.id).to eq(reaction.id)
      expect(data.jsonapi_type).to eq('reactions')
    end
  end

  describe 'filtering' do
    let!(:reaction1) { create(:reaction) }
    let!(:reaction2) { create(:reaction) }

    context 'by id' do
      before do
        params[:filter] = { id: { eq: reaction2.id } }
      end

      it 'works' do
        render
        expect(d.map(&:id)).to eq([reaction2.id])
      end
    end
  end

  describe 'sorting' do
    describe 'by id' do
      let!(:reaction1) { create(:reaction) }
      let!(:reaction2) { create(:reaction) }

      context 'when ascending' do
        before do
          params[:sort] = 'id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            reaction1.id,
            reaction2.id
          ])
        end
      end

      context 'when descending' do
        before do
          params[:sort] = '-id'
        end

        it 'works' do
          render
          expect(d.map(&:id)).to eq([
            reaction2.id,
            reaction1.id
          ])
        end
      end
    end
  end

  describe 'sideloading' do
    # ... your tests ...
  end
end
