class UpdateTitleJob < ApplicationJob
  queue_as :default
  require 'open-uri'

  def perform(short_url_id)
    short_url = ShortUrl.find short_url_id
    begin
      short_url.title = Nokogiri::HTML.parse(open(short_url.full_url)).title
      short_url.save!
    rescue
      'Unable to fetch title for this URL'
    end
  end
end
