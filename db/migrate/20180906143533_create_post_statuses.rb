class CreatePostStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :post_statuses do |t|
      t.string :name
      t.string :description

      t.timestamps
      t.index(:name, unique: true, name: "index_status_on_name")
    end
  end
end
