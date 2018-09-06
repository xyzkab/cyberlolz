class Category < ApplicationRecord

  validates :name, uniqueness: {case_sensitive: false}
  has_many :posts
end
