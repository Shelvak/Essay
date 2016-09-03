Fabricator(:sample) do

  
  element { Faker::Lorem.sentence }

  
  quantity { rand(1000) }
end
