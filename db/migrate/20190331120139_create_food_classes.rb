class CreateFoodClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :food_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
