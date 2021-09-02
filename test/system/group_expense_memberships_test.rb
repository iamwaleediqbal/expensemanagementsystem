require "application_system_test_case"

class GroupExpenseMembershipsTest < ApplicationSystemTestCase
  setup do
    @group_expense_membership = group_expense_memberships(:one)
  end

  test "visiting the index" do
    visit group_expense_memberships_url
    assert_selector "h1", text: "Group Expense Memberships"
  end

  test "creating a Group expense membership" do
    visit group_expense_memberships_url
    click_on "New Group Expense Membership"

    fill_in "Amount", with: @group_expense_membership.amount
    fill_in "Borrower", with: @group_expense_membership.borrower_id
    fill_in "Group expense", with: @group_expense_membership.group_expense_id
    fill_in "Lenter", with: @group_expense_membership.lenter_id
    click_on "Create Group expense membership"

    assert_text "Group expense membership was successfully created"
    click_on "Back"
  end

  test "updating a Group expense membership" do
    visit group_expense_memberships_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @group_expense_membership.amount
    fill_in "Borrower", with: @group_expense_membership.borrower_id
    fill_in "Group expense", with: @group_expense_membership.group_expense_id
    fill_in "Lenter", with: @group_expense_membership.lenter_id
    click_on "Update Group expense membership"

    assert_text "Group expense membership was successfully updated"
    click_on "Back"
  end

  test "destroying a Group expense membership" do
    visit group_expense_memberships_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group expense membership was successfully destroyed"
  end
end
