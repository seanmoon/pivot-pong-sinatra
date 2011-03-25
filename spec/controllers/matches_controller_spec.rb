require 'spec_helper'

describe MatchesController do
  describe "GET #index" do
    before { get :index }
    subject { response }
    it { should be_success }
  end
end
