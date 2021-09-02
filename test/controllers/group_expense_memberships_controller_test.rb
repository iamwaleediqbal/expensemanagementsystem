require "test_helper"

class GroupExpenseMembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_expense_membership = group_expense_memberships(:one)
  end

  test "should get index" do
    get group_expense_memberships_url
    assert_response :success
  end

  test "should get new" do
    get new_group_expense_membership_url
    assert_response :success
  end

  test "should create group_expense_membership" do
    assert_difference('GroupExpenseMembership.count') do
      post group_expense_memberships_url, params: { group_expense_membership: { amount: @group_expense_membership.amount, borrower_id: @group_expense_membership.borrower_id, group_expense_id: @group_expense_membership.group_expense_id, lenter_id: @group_expense_membership.lenter_id } }
    end

    assert_redirected_to group_expense_membership_url(GroupExpenseMembership.last)
  end

  test "should show group_expense_membership" do
    get group_expense_membership_url(@group_expense_membership)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_expense_membership_url(@group_expense_membership)
    assert_response :success
  end

  test "should update group_expense_membership" do
    patch group_expense_membership_url(@group_expense_membership), params: { group_expense_membership: { amount: @group_expense_membership.amount, borrower_id: @group_expense_membership.borrower_id, group_expense_id: @group_expense_membership.group_expense_id, lenter_id: @group_expense_membership.lenter_id } }
    assert_redirected_to group_expense_membership_url(@group_expense_membership)
  end

  test "should destroy group_expense_membership" do
    assert_difference('GroupExpenseMembership.count', -1) do
      delete group_expense_membership_url(@group_expense_membership)
    end

    assert_redirected_to group_expense_memberships_url
  end
end
