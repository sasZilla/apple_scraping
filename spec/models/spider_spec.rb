require 'rails_helper'

RSpec.describe Spider, type: :model do
  describe 'Spider for apple scrapping' do
    context 'should exist spider' do
      it 'Should create new object of Spider Class' do
        spider = Spider.new
        expect(!!spider)
      end
    end

    context 'scrape info from apple by IMEI' do
      let(:valid_imei) { '013977000323877' }
      let(:empty_imei) { '' }
      let(:not_valid_imei) { 'fail-imei' }
      let(:url_for_scrapping) {'https://selfsolve.apple.com/agreementWarrantyDynamic.do'}

      it 'should be found' do
        spider = Spider.new
        parsed_data = spider.parse(valid_imei, url_for_scrapping)
        expect(parsed_data[:is_error]).to be nil
        expect(parsed_data[:imei]).to eq(valid_imei)
      end

      it 'empty imei' do
        spider = Spider.new
        parsed_data = spider.parse(empty_imei, url_for_scrapping)
        expect(parsed_data[:is_error]).to be true
        expect(parsed_data[:error_text]).to eq("Please enter your product's serial number.")
      end

      it 'not valid imei' do
        spider = Spider.new
        parsed_data = spider.parse(not_valid_imei, url_for_scrapping)
        expect(parsed_data[:is_error]).to be true
        expect(parsed_data[:error_text]).to eq("Please enter a valid serial number.")
      end
    end
  end
end
