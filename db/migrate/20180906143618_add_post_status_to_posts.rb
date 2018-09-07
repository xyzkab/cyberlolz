class AddPostStatusToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :post_status, foreign_key: true
  end
end
