class Api::SearchController < ApplicationController
  def index
    some_food = {
      name: "apple"
    }

    search_for = params['term']
    page_num = 1

    page = HTTParty.get("http://www.myfitnesspal.com/food/search?search=#{search_for}&page=#{page_num}")
    mfp_results = []
    parse_page = Nokogiri::HTML(page)
    food_results = parse_page.css('div.food_info')
    food_results.each_with_index do |item, index|
      result = {}
      result['id'] = item.search('a').attr('href').value.split('/')[-1]
      result['brand'] = item.search('a')[1].text.strip.capitalize
      result['name'] = item.search('a')[0].text.strip.capitalize
      result['serving_size'] = item.search('label')[0].next.text.strip.to_f.round(2)
      result['serving_type'] = item.search('label')[0].next.text.strip.chomp(',')
      result['serving_type'] = result['serving_type'].scan(/[A-Za-z]+/).first
      result['calories'] = item.search('label')[1].next.text.strip.chomp(',').to_f.round(2)
      result['fat'] = item.search('label')[2].next.text.strip.chomp('g,').to_f.round(2)
      result['carbs'] = item.search('label')[3].next.text.strip.chomp('g,').to_f.round(2)
      result['protein'] = item.search('label')[4].next.text.strip.chomp('g').to_f.round(2)
      mfp_results.push(result)
    end
    render json: mfp_results
  end
end
