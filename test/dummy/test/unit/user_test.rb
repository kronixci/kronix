require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should pass" do
    assert "Jonathan Duarte", users(:jonathan).name
  end
end
