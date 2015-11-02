require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "Jason Leveille", email: "i@leve.us")
  end

  test "chef should be valid" do
    assert @chef.valid?
  end

  test "chef name should be present" do
    @chef.chefname = ''
    assert_not @chef.valid?
  end

  test "name length should be greater than 2 characters" do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end

  test "name length should be less than 41 characters" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end

  test "chef email should be present" do
    @chef.email = ''
    assert_not @chef.valid?
  end

  test "chef email length should be w/in bounds" do
    @chef.email = "a" * 105 + "@leve.us"
    assert_not @chef.valid?
  end

  test "chef email should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    # Save here, otherwise when we validate dup_chef it won't have
    # a matching email in the db to measure uniqueness against
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com first.last@email.com first+last@email.com]
    valid_addresses.each do |email|
      @chef.email = email
      assert @chef.valid?, '#{email.inspect} should be valid'
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@eee,com R_TDD-DS@eee_hello_org userexample_.com first.last@email+thing.com]
    invalid_addresses.each do |email|
      @chef.email = email
      assert_not @chef.valid?, '#{email.inspect} should not be valid'
    end
  end
end
