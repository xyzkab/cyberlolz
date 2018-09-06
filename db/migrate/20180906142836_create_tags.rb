class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.string :name
      t.string :description

      t.timestamps
      t.index(:name, unique: true, name: "index_tag_on_name")
    end
  end
end
