describe "matches/index.html.haml" do
  before do
    assign :matches, []
    render
  end
  subject { rendered }
  it { should be }
end
