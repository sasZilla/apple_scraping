require 'test_helper'

class SpiderTest < ActiveSupport::TestCase
  test "should exist spider" do
    spider = Spider.new
    assert !!spider
  end

  test "should be found" do
    spider = Spider.new
    parsed_data = spider.parse('013977000323877', 'https://selfsolve.apple.com/agreementWarrantyDynamic.do')

    assert_not parsed_data[:is_error]
    assert_equal parsed_data[:imei], '013977000323877'
  end

  test "empty imei" do
    spider = Spider.new
    parsed_data = spider.parse('', 'https://selfsolve.apple.com/agreementWarrantyDynamic.do')

    assert parsed_data[:is_error]
    assert_equal parsed_data[:error_text], "Please enter your product's serial number."
  end

  test "not valid imei" do
    spider = Spider.new
    parsed_data = spider.parse('fail-imei', 'https://selfsolve.apple.com/agreementWarrantyDynamic.do')

    assert parsed_data[:is_error]
    assert_equal parsed_data[:error_text], "Please enter a valid serial number."
  end
end
