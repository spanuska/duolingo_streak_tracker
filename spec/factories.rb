FactoryGirl.define do  
  factory :john, class: User do
    username "johnkpaul"
    days  720

  end
  factory :skylar, class: User do
    username "slpengy2"
    days  365
  end
  factory :bethanne, class: User do
    username "bethanne"
    days  102
  end
  factory :roger, class: User do
    username "roger"
    days  100000
  end
  factory :hopeful_user, class: User do
    username "rice_bowl"
    days 3
  end
  factory :spanish, class: Language do
    name "spanish"
  end
  factory :french, class: Language do
    name "french"
  end
  factory :german, class: Language do
    name "german"
  end

end
