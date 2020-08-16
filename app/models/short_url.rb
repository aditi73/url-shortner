class ShortUrl < ApplicationRecord

  # validations
  validates_presence_of :full_url
  validate :validate_full_url
  validates_uniqueness_of :short_code, :full_url

  #callbacks
  after_create :short_code!, :update_title!

  def short_code!
    self.short_code = UrlShortner.generate_short_code(self.id)
    self.save!
  end

  def update_title!
    UpdateTitleJob.perform_now(self.id)
  end

  private

  def validate_full_url
    if self.full_url.present?
      uri = URI.parse(URI.encode(self.full_url.strip))
      unless uri.is_a?(URI::HTTP) && !uri.host.nil?
        errors.add(:full_url, "is not a valid url")
      end
    else
      errors.add(:full_url, "can't be blank")
    end
  end

end
