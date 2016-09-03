Fabricator(:essay) do

  
  title { Faker::Lorem.sentence }

  
  quantity { rand(1000) }

  
  user { Fabricate(:user).id }
end
