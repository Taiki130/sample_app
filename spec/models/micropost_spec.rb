require("rails_helper")
RSpec.describe(Micropost, :type => :model) do
  before do
    @user = users(:michael)
    @micropost = @user.microposts.build(:content => "Lorem ipsum")
  end
  it("should be valid") { expect(@micropost.valid?).to(eq(true)) }
  it("user id should be present") do
    @micropost.user_id = nil
    assert_not(@micropost.valid?)
  end
  it("content should be present") do
    @micropost.content = "   "
    assert_not(@micropost.valid?)
  end
  it("content should be at most 140 characters") do
    @micropost.content = ("a" * 141)
    assert_not(@micropost.valid?)
  end
end
