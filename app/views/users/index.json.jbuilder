

json.platinums @users[:platinums] do |user|
  json.username user.username
  json.days user.days
  json.languages user.languages do |language|
    json.name language.name
  end
end

json.golds @users[:golds] do |user|
  json.username user.username
  json.days user.days
  json.languages user.languages do |language|
    json.name language.name
  end
end

json.silvers @users[:silvers] do |user|
  json.username user.username
  json.days user.days
  json.languages user.languages do |language|
    json.name language.name
  end
end

json.bronzes @users[:bronzes] do |user|
  json.username user.username
  json.days user.days
  json.languages user.languages do |language|
    json.name language.name
  end
end

json.hopefuls @users[:hopefuls] do |user|
  json.username user.username
  json.days user.days
  json.languages user.languages do |language|
    json.name language.name
  end
end
