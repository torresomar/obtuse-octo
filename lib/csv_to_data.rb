require 'csv'
require_relative 'layer'
require 'json'

csv_text_entities = File.read('base_geo.csv')
csv_entities = CSV.parse(csv_text_entities, :headers => true)

csv_text_quantiles = File.read('quantiles.csv')
csv_quantiles = CSV.parse(csv_text_quantiles)

quantiles = Hash.new
csv_quantiles.each do |row|
  quantiles[row[0]] = [row[1], row[2], row[3], row[4]]
end

layers = []
csv_entities.each do |row|
  layers << Layer.new(row.to_hash)
end
metrics = {
  :pob => :population,
  :pobreza_pct => :poverty_percentage, 
  :pobreza_pob => :poverty_population,
  :extrema_pct => :extreme_poverty_percentage,
  :extrema_pob => :extreme_poverty_population,
  :moderada_pct => :moderate_poverty_percentage,
  :moderada_pob => :moderate_poverty_population, 
  :vulnerables_c_pct => :vulnerable_social_percentage,
  :vulnerables_c_pob => :vulnerable_social_population,
  :vulnerables_i_pct => :vulnerable_income_percentage,
  :vulnerables_i_pob => :vulnerable_income_population,  
  :rez_edu_pct => :education_lag_percentage,
  :rez_edu_pob => :education_lag_population,
  :rez_serv_salud_pct => :health_lag_percentage,
  :rez_serv_salud_pob => :health_lag_population,
  :rez_seg_social_pct => :social_s_lag_percentage,
  :rez_seg_social_pob => :social_s_lag_population,
  :rez_esp_viv_pct => :life_exp_lag_percentage,
  :rez_esp_viv_pob => :life_exp_lag_population,
  :rez_serv_viv_pct => :life_serv_lag_percentage,
  :rez_serv_viv_pob => :life_serv_lag_population,
  :rez_alim_pct => :nutrition_lag_percentage,
  :rez_alim_pob => :nutrition_lag_population,
  :ing_inf_bie_pct => :wellness_income_percentage,
  :ing_inf_bie_pob => :wellness_income_population,
  :ing_inf_min_pct => :minimum_income_percentage,
  :ing_inf_min_pob => :minimum_income_population,
  :gini => :gini_coefficient,
  :razon_ingreso => :income
}
# Clean JSON
Dir.glob('../data/*.json').each do |file| 
  File.delete(file)
end

# Create individual JSON for each metric
metrics.each do |key, lkey|
  entities = Hash.new
  layers.each do |layer, index|
    entities[layer.cv_mun] = {
      :value => layer.instance_variable_get("@#{key}")
    }
  end
  layers_json = {
    :entities => entities,
    :quantiles => quantiles["#{lkey}"]
  }
  File.open("../data/#{lkey}.json", "w") do |f|
    f.write(layers_json.to_json)
  end
end
