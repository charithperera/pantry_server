class DiaryController < ApplicationController
  before_action :authenticate_request!

  def add_food
    food = params[:food]

    local_result = Food.where(brand: food[:brand], name: food[:name]).first
    mfp_result = nil

    if local_result.nil?
      mfp_result = Food.new({
        brand: food[:brand],
        name: food[:name],
        serving_type: food['serving_type'],
        serving_size: food['serving_size'],
        calories: food[:calories].to_f,
        fat: food[:fat].to_f,
        carbs: food[:carbs].to_f,
        protein: food[:protein].to_f
      })
      mfp_result.save
    end

    new_food = local_result || mfp_result
    new_entry = Entry.new
    params[:date] ? new_entry.entry_date = Date.parse(params[:date]) : new_entry.entry_date = Date.today
    new_entry.food = new_food
    save_entry(new_entry, new_food, params)
    @current_user.entries << new_entry
    @current_user.save
    return_days
  end

def save_entry(entry, food, params)
    params[:servings].nil? || params[:servings].empty? ? entry.servings = 1 : entry.servings = params[:servings]
    entry.serving_type = params['serving-type-choice'] || 'servings'
    if entry.serving_type == 'servings'
      entry.calories = entry.servings * food.calories
      entry.fat = entry.servings * food.fat
      entry.carbs = entry.servings * food.carbs
      entry.protein = entry.servings * food.protein

      entry.serving_size = "#{food.serving_size} #{food.serving_type}"
    else
      calories_per_unit = food.calories / food.serving_size
      fat_per_unit = food.fat / food.serving_size
      carbs_per_unit = food.carbs / food.serving_size
      protein_per_unit = food.protein / food.serving_size

      entry.calories = entry.servings * calories_per_unit
      entry.fat = entry.servings * fat_per_unit
      entry.carbs = entry.servings * carbs_per_unit
      entry.protein = entry.servings * protein_per_unit

      entry.serving_size = "1 #{food.serving_type}"
    end
    entry.save
  end

  def return_days
    output = {

    }

    @current_user.entries.map do |entry|
        puts entry.food.brand
    end

  end

end
