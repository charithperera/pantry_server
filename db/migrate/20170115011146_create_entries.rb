class CreateEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :entries do |t|
      t.date :entry_date,     null:false
      t.decimal :servings,    default:1
      t.string :serving_size, null:false
      t.string :serving_type, null:false
      t.decimal :calories,    default:0.0
      t.decimal :fat,         default:0.0
      t.decimal :carbs,       default:0.0
      t.decimal :protein,     default:0.0
      t.references :user, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end
