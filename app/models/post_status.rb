class PostStatus < ApplicationRecord

  validates :name, uniqueness: {case_sensitive: false}
  has_many :posts

  def self.default
    find_by(name: "new")
  end
end
