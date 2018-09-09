require 'elasticsearch/model'

class Post < ApplicationRecord

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  before_validation :set_uniq_url
  validate :parse_url
  validates :url_uniq, uniqueness: {case_sensitive: false}

  belongs_to :category, optional: true
  belongs_to :tag, optional: true
  belongs_to :post_status, optional: true

  def as_indexed_json(options = {})
    as_json(
      include: {
        status: { except: [:created_at, :updated_at] },
        category: { except: [:created_at, :updated_at] }
      }
    )
  end

  def category
    super || Category.default
  end

  def post_status
    super || PostStatus.default
  end

  alias_method :status, :post_status

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
    if uri.path&.ends_with?("/") # remove last / if exist
      uri.path = uri.path[0..-2]
      uri.host.gsub!(/www./,'') # remove www. in hostname if exist
      self.url_uniq = "https://#{uri.host}#{uri.path}"
    end
  end
end
