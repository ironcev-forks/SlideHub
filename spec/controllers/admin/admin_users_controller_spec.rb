require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  describe 'Users' do
    render_views
    let(:admin_user) { create(:admin_user) }
    before do
      login_by_admin_user admin_user
    end

    describe 'GET /admin/users/' do
      it 'works!' do
        get 'index'
        expect(response.status).to eq(200)
      end
    end

    describe 'GET /admin/users/edit/1' do
      it 'works!' do
        target = create(:default_user)
        get 'edit', params: { id: target.id }
        expect(response.status).to eq(200)
      end
    end

    describe 'POST /admin/users/update' do
      it 'works!' do
        target = create(:default_user)
        data = User.find(target.id)
        update_name = 'SushiKuitai'
        data[:display_name] = update_name
        keys = %w[id username display_name email biography admin]
        data_attr = data.attributes
        data_attr.each_key do |k, _v|
          data_attr.delete(k) unless keys.include?(k)
        end
        post :update, params: { id: data.id, user: data_attr }
        new_name = User.find(target.id).display_name
        expect(new_name).to eq(update_name)
        expect(response.status).to eq(302)
      end
    end

    describe 'POST /admin/users/update' do
      it 'move to edit screen' do
        target = create(:default_user)
        data = User.find(target.id)
        update_name = '' # validation error
        data[:display_name] = update_name
        keys = %w[id username display_name email biography admin]
        data_attr = data.attributes
        data_attr.each_key do |k, _v|
          data_attr.delete(k) unless keys.include?(k)
        end
        post :update, params: { id: data.id, user: data_attr }
        expect(response.status).to eq(200)
        expect(response).to render_template :edit
      end
    end

    describe 'DELETE /admin/users' do
      it 'works' do
        target = create(:default_user)
        delete :destroy, params: { id: target.id }
        expect(response.status).to eq(302)
        expect(response).to redirect_to admin_users_path
        expect(User.where(id: target.id).count).to eq(0)
      end
    end
  end
end
