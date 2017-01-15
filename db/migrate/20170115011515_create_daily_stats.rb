class CreateDailyStats < ActiveRecord::Migration[5.0]
  def change
    create_table :daily_stats do |t|
      t.date :stat_date,   null:false
      t.decimal :calories, default:0.0
      t.decimal :fat,      default:0.0
      t.decimal :carbs,    default:0.0
      t.decimal :protein,  default:0.0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
