require 'rails_helper'

RSpec.describe User, type: :model do
  context "For tests to sort by days" do
    before(:each) do
      @spanish = create(:spanish)
      @german = create(:german)
      @french = create(:french)
    end
    let(:john) {create(:john, languages:[@spanish, @french, @german])}
    let(:skylar) {create(:skylar)}
    let(:roger) {create(:roger)}
    let(:bethanne) {create(:bethanne)}

    it "should create a sorted list of users by days" do
      expect(User.get_all_sorted_by_days).to eq([roger, john, skylar, bethanne])
    end

    it "should have a languages array" do
      languages = john.languages
      expect(languages).to include(@spanish)
      expect(languages).to include(@german)
      expect(languages).to include(@french)
    end
  end


end
