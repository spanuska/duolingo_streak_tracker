json.users @users do |user|
  json.username user.username
  json.days user.days
  json.languages user.languages do |language|
    json.name language.name
  end

end
