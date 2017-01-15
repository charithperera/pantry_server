class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.text :brand,            null:false
      t.text :name,             null:false
      t.decimal :serving_size,  null:false
      t.string :serving_type,   null:false
      t.decimal :calories,      default:0.0
      t.decimal :fat,           default:0.0
      t.decimal :carbs,         default:0.0

      t.timestamps
    end
  end
end
