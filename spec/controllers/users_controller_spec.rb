require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

    before(:each) do
      @spanish = create(:spanish)
      @german = create(:german)
      @french = create(:french)
      @john = create(:john, languages:[@spanish, @french, @german])
      @skylar = create(:skylar)
      @roger = create(:roger)
      @bethanne = create(:bethanne)
      @hopeful_user = create(:hopeful_user)
      @silver_user = create(:silver_user)
    end
    let(:john) { @john }
    let(:skylar) { @skylar }
    let(:roger) { @roger }
    let(:bethanne) { @bethanne }
    let(:hopeful_user) { @hopeful_user }
    let(:silver_user) { @silver_user }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "groups @users by platinum status" do
      get :index, {}, valid_session
      expect(assigns(:users)[:platinums]).to_not include(@skylar)
      expect(assigns(:users)[:platinums]).to include(@john)
    end
    it "groups @users by gold status" do
      get :index, {}, valid_session
      expect(assigns(:users)[:golds]).to_not include(@john)
      expect(assigns(:users)[:golds]).to include(@skylar)
    end
    it "groups @users by silver status" do
      get :index, {}, valid_session
      expect(assigns(:users)[:silvers]).to_not include(@john)
      expect(assigns(:users)[:silvers]).to include(@silver_user)
    end
    it "groups @users by bronze status" do
      get :index, {}, valid_session
      expect(assigns(:users)[:bronzes]).to_not include(@john)
      expect(assigns(:users)[:bronzes]).to include(@bethanne)
    end
    it "groups @users by hopeful status" do
      get :index, {}, valid_session
      expect(assigns(:users)[:hopefuls]).to_not include(@john)
      expect(assigns(:users)[:hopefuls]).to include(@hopeful_user)
    end
    it "sends specific json when GETing /users.json" do
      request.accept = "application/json"
      get :index
      json = JSON.parse(response.body)
      john_deserialized = json['platinums'].find {|hash| hash["username"] == "johnkpaul"}
      expect(json['platinums'].length).to eq(2)
      expect(json['platinums']).to include(john_deserialized)
      expect(john_deserialized["languages"]).to include(Hash["name", "spanish"])
      expect(json['hopefuls'].length).to eq(1)
      expect(json['hopefuls'][0]["username"]).to eq("rice_bowl")
    end
  end

end
