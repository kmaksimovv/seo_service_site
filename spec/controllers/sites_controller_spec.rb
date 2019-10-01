require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  let(:user) { create :user }
  describe 'GET #index' do
    let!(:sites) { create_list :site, 3, user: user }

    before { login user }

    before { get :index }

    it 'returns a 200 custom status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'list of all sites' do
      expect(assigns(:sites)).to match_array(sites)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    let(:site) { Site.new }
    before { login user }

    before { get :new }

    it 'is a new Site' do
      expect(site).to be_a_new(Site)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { login user }
    context 'valid attributes' do
      let(:site) { attributes_for(:site) }

      it 'creates new PromoGroup' do
        expect do
          post :create, params: { site: site }
        end.to change(Site, :count).by(1)
      end

      it 'redirects to promo_groups list' do
        post :create, params: { site: site }
        expect(response).to redirect_to sites_path
      end
    end
  end

  describe 'GET #show' do
    let(:site) { create(:site, user: user) }

    before { login user }

    before { get :show, params: { id: site } }

    it 'assigns the requested site to @site' do
      expect(assigns(:site)).to eq site
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end
end
