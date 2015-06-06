require 'rails_helper'

RSpec.describe AppleController, type: :controller do
  describe "GET #index" do
    let(:valid_imei) { '013977000323877' }
    let(:not_valid_imei) { 'fail-imei' }

    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the show template with valid imei" do
      get :show, imei: valid_imei
      expect(response).to render_template('_show')
    end

    it "renders the error template with not valid imei" do
      get :show, imei: not_valid_imei
      expect(response).to render_template('_error')
    end
  end
end
