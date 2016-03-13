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
    end
    let(:john) { @john }
    let(:skylar) { @skylar }
    let(:roger) { @roger }
    let(:bethanne) { @bethanne }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all users as @users" do
      get :index, {}, valid_session
      expect(assigns(:users)).to include(@skylar)
      expect(assigns(:users)).to include(@john)
      expect(assigns(:users)).to include(@roger)
      expect(assigns(:users)).to include(@bethanne)
    end
    it "sends specific json when GETing /users.json" do
      request.accept = "application/json"
      get :index
      json = JSON.parse(response.body)
      johnkpaul_deserialized = json['users'].find {|x| x['username'] == 'johnkpaul'}
      expect(json['users'].length).to eq(4)
      expect(johnkpaul_deserialized['languages'].length).to eq(3)
      expect(johnkpaul_deserialized['languages']).to include(Hash["name", "french"])
      expect(johnkpaul_deserialized['languages']).to include(Hash["name", "spanish"])
      expect(johnkpaul_deserialized['languages']).to include(Hash["name", "german"])
    end
  end

end
