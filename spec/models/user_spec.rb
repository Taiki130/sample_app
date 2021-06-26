require("rails_helper")
RSpec.describe(User, :type => :model) do
  before do
    @user = User.new(:name => "Example User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar")
  end
  it("should be valid") { expect(@user.valid?).to(eq(true)) }
  it("name should be present") do
    @user.name = "     "
    assert_not(@user.valid?)
  end
  it("email should be present") do
    @user.email = "     "
    assert_not(@user.valid?)
  end
  it("name should not be too long") do
    @user.name = ("a" * 51)
    assert_not(@user.valid?)
  end
  it("email should not be too long") do
    @user.email = (("a" * 244) + "@example.com")
    assert_not(@user.valid?)
  end
  it("email validation should reject invalid addresses") do
    invalid_addresses = ["user@example,com", "user_at_foo.org", "user.name@example.", "foo@bar_baz.com", "foo@bar+baz.com", "foo@bar..com"]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not(@user.valid?, "#{invalid_address.inspect} should be invalid")
    end
  end
  it("email addresses should be unique") do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not(duplicate_user.valid?)
  end
  it("password should be present (nonblank)") do
    @user.password = @user.password_confirmation = (" " * 6)
    assert_not(@user.valid?)
  end
  it("password should have a minimum length") do
    @user.password = @user.password_confirmation = ("a" * 5)
    assert_not(@user.valid?)
  end
  it("authenticated? should return false for a user with nil digest") do
    assert_not(@user.authenticated?(:remember, ""))
  end
  it("associated microposts should be destroyed") do
    @user.save
    @user.microposts.create!(:content => "Lorem ipsum")
    expect { @user.destroy }.to(change { Micropost.count }.by(-1))
  end
  it("should follow and unfollow a user") do
    michael = users(:michael)
    archer = users(:archer)
    assert_not(michael.following?(archer))
    michael.follow(archer)
    expect(michael.following?(archer)).to(eq(true))
    expect(archer.followers.include?(michael)).to(eq(true))
    michael.unfollow(archer)
    assert_not(michael.following?(archer))
  end
  it("feed should have the right posts") do
    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)
    lana.microposts.each do |post_following|
      expect(michael.feed.include?(post_following)).to(eq(true))
    end
    michael.microposts.each do |post_self|
      expect(michael.feed.include?(post_self)).to(eq(true))
    end
    archer.microposts.each do |post_unfollowed|
      assert_not(michael.feed.include?(post_unfollowed))
    end
  end
end
