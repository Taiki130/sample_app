require("rails_helper")
RSpec.describe(Relationship, :type => :model) do
  before do
    @relationship = Relationship.new(:follower_id => users(:michael).id, :followed_id => users(:archer).id)
  end
  it("should be valid") { expect(@relationship.valid?).to(eq(true)) }
  it("should require a follower_id") do
    @relationship.follower_id = nil
    assert_not(@relationship.valid?)
  end
  it("should require a followed_id") do
    @relationship.followed_id = nil
    assert_not(@relationship.valid?)
  end
end
