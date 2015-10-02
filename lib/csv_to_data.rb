require 'csv'
require_relative 'layer'

csv_text = File.read('./../base_geo.csv')
csv = CSV.parse(csv_text, :headers => true)
layers = []
csv.each do |row|
  layers << Layer.new(row.to_hash)
end
p layers.size
