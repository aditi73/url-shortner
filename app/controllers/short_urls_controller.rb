class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    short_url = ShortUrl.new(full_url: params[:full_url])
    if short_url.save!
      render json: {short_code: short_url.short_code}, status: 200
    else
      render json: {errors: 'Full url is not a valid url'}, status: 422
    end
  end

  def show
    short_url = ShortUrl.find_by_short_code params[:id]
    if short_url.present?
      short_url.click_count += 1
      short_url.save
      redirect_to short_url.full_url
    else
      render json: {error: 'Url not present!'}, status: 404
    end
  end

end
