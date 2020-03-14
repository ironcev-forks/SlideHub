require 'rails_helper'

RSpec.describe PlayerController, type: :controller do
  let(:slide) { create(:slide) }
  render_views

  describe 'GET #show' do
    it 'succeeds to return encrypted JavaScript' do
      allow_any_instance_of(SlidePages).to receive(:list).and_return(['a'])
      get :show, params: { id: slide.id }
      expect(response.status).to eq(200)
      updated_data = Slide.find(slide.id)
      expect(updated_data.embedded_view).to eq(slide.embedded_view + 1)
      expect(updated_data.total_view).to eq(slide.total_view + 1)
    end

    it 'succeeds to return encrypted JavaScript for inside' do
      allow_any_instance_of(SlidePages).to receive(:list).and_return(['a'])
      get :show, params: { id: slide.id, inside: 1 }
      expect(response.status).to eq(200)
      updated_data = Slide.find(slide.id)
      expect(updated_data.embedded_view).to eq(slide.embedded_view)
      expect(updated_data.total_view).to eq(slide.total_view)
    end
  end
end
