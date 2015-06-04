require "capybara/dsl"
require 'capybara-webkit'

class Spider
  include Capybara::DSL

  def initialize
    Capybara.register_driver :webkit do |app|
      Capybara::Webkit::Driver.new(app).tap do |driver|
        driver.block_unknown_urls
        driver.allow_url "www.apple.com"
        driver.allow_url "selfsolve.apple.com"
      end
    end

    Capybara.run_server = false

    Capybara.configure do |c|
      c.javascript_driver = :webkit
      c.default_driver = :webkit
    end
  end

  def parse(imei, url)
    visit(url)

    fill_in('sn', :with => imei)
    click_button('Continue')

    if all('#error').length > 0
      return {
        :is_error => true,
        :error_text => find('#error').text
      }
    end

    container = find('#warranty')

    return {
      :image => container.find('#productimage').find('img')[:src],
      :title => container.find('#productname').text,
      :imei => container.find('#productsn').text,
      :registration => grab_node(container.find('#registration'), 'registration'),
      :phone => grab_node(container.find('#phone'), 'phone'),
      :hardware => grab_node(container.find('#hardware'), 'hardware')
    }
  end

  private

  def grab_node(node, typeof)
    return {
      :status => node.all('h3').map { |e| e.text }.join,
      :description => node.find("##{typeof}-text").text
    }
  end
end
