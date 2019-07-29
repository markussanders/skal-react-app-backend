class CreateDrinks < ActiveRecord::Migration[5.2]
  def change
    create_table :drinks do |t|
      t.string :name
      t.string :image_url
      t.text :ingredients, array: true, default: []
      t.string :directions
      t.text :tools, array: true, default: []
      t.string :description
      t.integer :favorited_count

      t.timestamps
    end
  end
end
