require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with a valid email should be valid" do
    user = User.new(email: "test@test.org", password_digest: "test")
    assert user.valid?
  end

  test "user with a invalid email should not be valid" do
    user = User.new(email: "testtest.org", password_digest: "test")
    assert_not user.valid?
  end

  test "user with a duplicate email should not be valid" do
    other_user = users(:one)
    user = User.new(email: other_user.email, password_digest: "test")
    assert_not user.valid?
  end

  test 'destroy user should destroy linked product' do
    assert_difference('Product.count', -1) do
    users(:one).destroy
    end
  end
  
end
