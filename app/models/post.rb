class Post < ApplicationRecord

  before_validation :set_uniq_url
  validate :parse_url
  validates :url_uniq, uniqueness: {case_sensitive: false}

  belongs_to :category, optional: true

  def category
    super || Category.find_by(name: "uncategorized")
  end

  private

  def parse_url
    schemes = ["http","https"]
    begin
      uri = URI.parse(url)
      raise URI::InvalidURIError.new("invalid host") if uri.host.nil?
      raise URI::InvalidURIError.new("invalid scheme") if !schemes.include?(uri.scheme)
    rescue URI::InvalidURIError => e
      errors.add(:url, e.message)
    end
  end

  def set_uniq_url
    return if url.nil?
    uri = URI.parse(url)
    uri.path = uri.path[0..-2] if uri.path.ends_with?("/") # remove last / if exist
    uri.host.gsub!(/www./,'') # remove www. in hostname if exist
    self.url_uniq = "https://#{uri.host}#{uri.path}"
  end
end
