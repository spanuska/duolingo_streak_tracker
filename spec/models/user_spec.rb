require 'rails_helper'

RSpec.describe User, type: :model do
  context "For tests to sort by days" do
    before(:each) do
      @spanish = create(:spanish)
      @german = create(:german)
      @french = create(:french)
      @john = create(:john, languages:[@spanish, @french, @german])
      @skylar = create(:skylar)
      @roger = create(:roger)
      @bethanne = create(:bethanne)
      @hopeful_user = create(:hopeful_user)
    end
    let(:john) { @john }
    let(:skylar) { @skylar }
    let(:roger) { @roger }
    let(:bethanne) { @bethanne }
    let(:hopeful_user) { @hopeful_user }

    it "should create a sorted list of users by days" do
      expect(User.get_all_sorted_by_days).to eq([roger, john, skylar, bethanne, hopeful_user])
    end

    it "should have a languages array" do
      languages = john.languages
      expect(languages).to include(@spanish)
      expect(languages).to include(@german)
      expect(languages).to include(@french)
    end

    it "should have platnium users with all more than 719 days" do
      platinums = User.platinum
      expect(platinums).to include(john)
      expect(platinums).to include(roger)
      expect(platinums).to_not include(bethanne)
    end

    it "should have gold users with all more than 364 days and less than 720 days" do
      golds = User.gold
      expect(golds).to include(skylar)
      expect(golds).to_not include(john)
      expect(golds).to_not include(roger)
      expect(golds).to_not include(bethanne)
    end
    it "should have silver users with all more than 200 days and less than 365 days" do
      silvers = User.silver
      expect(silvers).to_not include(skylar)
      expect(silvers).to_not include(john)
      expect(silvers).to_not include(roger)
      expect(silvers).to_not include(bethanne)
    end
    it "should have bronze users with all more than 100 days and less than 200 days" do
      bronzes = User.bronze
      expect(bronzes).to_not include(skylar)
      expect(bronzes).to_not include(john)
      expect(bronzes).to_not include(roger)
      expect(bronzes).to include(bethanne)
    end
    it "should have hopeful users with all more than 0 days and less than 100 days" do
      hopefuls = User.hopeful
      expect(hopefuls).to_not include(skylar)
      expect(hopefuls).to_not include(john)
      expect(hopefuls).to_not include(roger)
      expect(hopefuls).to_not include(bethanne)
      expect(hopefuls).to include(hopeful_user)
    end
  end


end
