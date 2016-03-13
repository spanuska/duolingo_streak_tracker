require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :username => "johnkpaul",
        :days => 12
      ),
      User.create!(
        :username => "skylar",
        :days => 365
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select ".username" do |elements|
      elements.each_with_index do |el, index|
        assert_select 'td', {text: 'skylar'}
        assert_select 'td', {text: 'johnkpaul'}
      end
    end

  end
end
