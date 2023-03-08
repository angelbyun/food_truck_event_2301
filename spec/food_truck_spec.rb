require './lib/item'
require './lib/food_truck'

RSpec.describe FoodTruck do
  it 'exists' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    food_truck = FoodTruck.new("Rocky Mountain Pies")

    expect(food_truck).to be_a(FoodTruck)
    expect(food_truck.name).to eq("Rocky Mountain Pies")
  end

  it 'has an empty hash for inventory' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    food_truck = FoodTruck.new("Rocky Mountain Pies")

    expect(food_truck.inventory).to eq({})
  end

  it 'will check stock' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    food_truck = FoodTruck.new("Rocky Mountain Pies")

    expect(food_truck.check_stock(item1)).to eq(0)
  end

  it 'will add stock' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    food_truck = FoodTruck.new("Rocky Mountain Pies")

    food_truck.stock(item1, 30)

    expect(food_truck.inventory).to eq({
      item1 => 30
    })
    expect(food_truck.check_stock(item1)).to eq(30)

    food_truck.stock(item1, 25)

    expect(food_truck.inventory).to eq({
      item1 => 55
    })
    expect(food_truck.check_stock(item1)).to eq(55)

    food_truck.stock(item2, 12)

    expect(food_truck.inventory).to eq({
      item1 => 55,
      item2 => 12
    })
    expect(food_truck.check_stock(item2)).to eq(12)
  end
end