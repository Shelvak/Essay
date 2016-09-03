Fabricator(:shift) do

  
  start_at { Time.now }

  
  finish_at { Time.now }

  
  user { Fabricate(:user).id }
end
