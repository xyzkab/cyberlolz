class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description

      t.timestamps
      t.index(:name, unique: true, name: "index_category_on_name")
    end
  end
end
