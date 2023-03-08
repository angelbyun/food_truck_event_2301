require './lib/item'
require './lib/food_truck'
require './lib/event'

RSpec.describe Event do
  it 'exists' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    food_truck = FoodTruck.new("Rocky Mountain Pies")
    event = Event.new("South Pearl Street Farmers Market")

    expect(event).to be_an(Event)
    expect(event.name).to eq("South Pearl Street Farmers Market")
  end

  it 'will have an empty array for food_trucks' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    event = Event.new("South Pearl Street Farmers Market")

    expect(event.food_trucks).to eq([])
  end

  it 'will add food_trucks' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    event = Event.new("South Pearl Street Farmers Market")

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    expect(event.food_trucks).to eq([food_truck1, food_truck2, food_truck3])
  end

  it 'can list all food_truck names' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    event = Event.new("South Pearl Street Farmers Market")

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    expect(event.food_truck_names).to eq(["Rocky Mountain Pies", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
  end

  it 'can list food_trucks that sell specific item' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    event = Event.new("South Pearl Street Farmers Market")

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)

    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)

    food_truck3.stock(item1, 65)

    expect(event.food_trucks_that_sell(item1)).to eq([food_truck1, food_truck3])
    expect(event.food_trucks_that_sell(item4)).to eq([food_truck2])
    expect(event.food_trucks_that_sell(item2)).to eq([food_truck1])
    expect(event.food_trucks_that_sell(item3)).to eq([food_truck2])
  end

  it 'will list potential revenue' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    event = Event.new("South Pearl Street Farmers Market")

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)

    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)

    food_truck3.stock(item1, 65)

    expect(food_truck1.potential_revenue).to eq(148.75)
    expect(food_truck2.potential_revenue).to eq(345.00)
    expect(food_truck3.potential_revenue).to eq(243.75)

    food_truck3.stock(item2, 35)

    expect(food_truck3.potential_revenue).to eq(331.25)
  end

  it 'lists overstocked items' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    event = Event.new("South Pearl Street Farmers Market")

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)

    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)

    food_truck3.stock(item1, 65)

    expect(event.overstocked_items).to eq([item1])

    food_truck3.stock(item3, 75)

    expect(event.overstocked_items).to eq([item1, item3])
  end

  it 'can sort list of items alphabetically in array' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    event = Event.new("South Pearl Street Farmers Market")

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)

    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)

    food_truck3.stock(item1, 65)

    expect(event.sorted_item_list).to eq(['Apple Pie (Slice)', "Banana Nice Cream", 'Peach Pie (Slice)', "Peach-Raspberry Nice Cream"])
  end

  it 'lists total inventory' do
    item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    food_truck3 = FoodTruck.new("Palisade Peach Shack")
    event = Event.new("South Pearl Street Farmers Market")

    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)

    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)

    food_truck3.stock(item1, 65)

    expect(event.total_inventory).to eq({
      item1 => {'Quantity' => 100,
                'Food Trucks' => [food_truck1, food_truck3]},
      item2 => {'Quantity' => 7,
                'Food Trucks' => [food_truck1]},
      item3 => {'Quantity' => 25,
                'Food Trucks' => [food_truck2]},
      item4 => {'Quantity' => 50,
                'Food Trucks' => [food_truck2]}
    })

    food_truck3.stock(item4, 50)

    expect(event.total_inventory).to eq({
      item1 => {'Quantity' => 100,
                'Food Trucks' => [food_truck1, food_truck3]},
      item2 => {'Quantity' => 7,
                'Food Trucks' => [food_truck1]},
      item3 => {'Quantity' => 25,
                'Food Trucks' => [food_truck2]},
      item4 => {'Quantity' => 100,
                'Food Trucks' => [food_truck2, food_truck3]}
    })
  end
end