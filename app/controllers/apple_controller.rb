class AppleController < ApplicationController
  def index
  end

  def show
    imei = params[:imei]
    if imei
      spider = Spider.new
      @result = spider.parse(imei, Rails.application.config.url)

      if @result[:is_error]
        render :partial => '/apple/error', :result => @result
      else
        expiration_date = /Estimated Expiration Date: (\w+ \w+, \w+)/.match(@result[:hardware][:description])
        @warranty = if expiration_date
                      expiration_date
                    else
                      @result[:hardware][:status]
                    end

        render :partial => '/apple/show', :result => @result
      end
      return
    end
  end
end
