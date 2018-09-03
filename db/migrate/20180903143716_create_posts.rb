class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.string :url
      t.string :url_uniq

      t.timestamps
      t.index(:url_uniq, unique: true, name: "index_post_on_url_uniq")
    end
  end
end
