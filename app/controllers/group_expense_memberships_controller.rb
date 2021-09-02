class GroupExpenseMembershipsController < ApplicationController
  before_action :set_group_expense_membership, only: %i[ show edit update destroy ]

  # GET /group_expense_memberships or /group_expense_memberships.json
  def index
    @group_expense = GroupExpense.find(params[:group_expense_id])
    @group_expense_memberships = @group_expense.group_expense_memberships
  end

  # GET /group_expense_memberships/1 or /group_expense_memberships/1.json
  def show
  end

  # GET /group_expense_memberships/new
  def new
    @group_expense_membership = GroupExpenseMembership.new
  end

  # GET /group_expense_memberships/1/edit
  def edit
  end

  # POST /group_expense_memberships or /group_expense_memberships.json
  def create
    @group_expense_membership = GroupExpenseMembership.new(group_expense_membership_params)

    respond_to do |format|
      if @group_expense_membership.save
        format.html { redirect_to @group_expense_membership, notice: "Group expense membership was successfully created." }
        format.json { render :show, status: :created, location: @group_expense_membership }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_expense_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_expense_memberships/1 or /group_expense_memberships/1.json
  def update
    respond_to do |format|
      if @group_expense_membership.update(group_expense_membership_params)
        format.html { redirect_to @group_expense_membership, notice: "Group expense membership was successfully updated." }
        format.json { render :show, status: :ok, location: @group_expense_membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group_expense_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_expense_memberships/1 or /group_expense_memberships/1.json
  def destroy
    @group_expense_membership.destroy
    respond_to do |format|
      format.html { redirect_to group_expense_memberships_url, notice: "Group expense membership was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_expense_membership
      @group_expense_membership = GroupExpenseMembership.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_expense_membership_params
      params.require(:group_expense_membership).permit(:group_expense_id, :borrower_id, :lenter_id, :amount)
    end
end
