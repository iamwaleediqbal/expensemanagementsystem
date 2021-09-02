class GroupExpensesController < ApplicationController
  before_action :set_group_expense, only: %i[ show edit update destroy ]

  # GET /group_expenses or /group_expenses.json
  def index
    @group = Group.find(params[:group_id])
  
    @group_expenses = @group.group_expenses.order('created_at DESC').page(params[:page]).per(5)
    authorize @group_expenses
  end

  def user_wallet(member)
    if(!member.user.wallet)
      member.user.wallet = Wallet.new
      member.user.wallet.balance = 0
      member.user.wallet.amount_borrowed = 0
      member.user.wallet.amount_lent = 0
      member.user.wallet.save
    end
    if(member.user.wallet.amount_borrowed == nil)
      member.user.wallet.amount_borrowed = 0
      member.user.wallet.save
    end
    if(member.user.wallet.amount_lent == nil)
      member.user.wallet.amount_lent = 0
      member.user.wallet.save
    end
  end

  def settle 

    ret = false
    @group_expense.group_expense_memberships.each do |gem|
      if(gem.settled == true && gem.borrower != @group_expense.creator)
        ret = true
      elsif(gem.borrower != @group_expense.creator)
        ret = false
        break
      end
    end
    if(ret == true)
      @group_expense.group_expense_memberships.each do |gem|
        if(gem.settled == false && gem.borrower == @group_expense.creator)
          gem.settled = true
          gem.save
        end
      end
    end
  end
  # GET /group_expenses/1 or /group_expenses/1.json
  def show
    authorize @group_expense
  end

  # GET /group_expenses/new
  def new
    @group = Group.find(params[:group_id])
    @group_expense = @group.group_expenses.new
    @accounts = []
    current_user.bank_accounts.each do |bank_account| @accounts.push([bank_account.name,("#{bank_account.name} - #{bank_account.id}")]) end
    @accounts.push([current_user.wallet.class.name,"Wallet - #{current_user.wallet.id}"])
    authorize @group_expense
  end

  # GET /group_expenses/1/edit
  def edit
    authorize @group_expense
    settle
  end

  # POST /group_expenses or /group_expenses.json
  def create
    if(current_user.wallet.balance < group_expense_params[:expense].to_i)
      respond_to do |format|
    
        flash[:alert] = "Low Balance"
        redirect_to request.referrer
      end
      return
    end
    @b = params[:bank].split(' - ')
    
    @bank = @b[0] == "Wallet"? Wallet.find(@b[1]) : BankAccount.find(@b[1]) 
    #debugger
    @group = Group.find(params[:group_id])
    puts(@group)
    @group_expense = @group.group_expenses.new(group_expense_params)
    @group_expense.creator = current_user
    #puts(params[:amount])
    #debugger
    @ids = []
    if(params[:id])
      params[:id].each do |i|
        @ids.push(i)
      end
    end
    @amounts = []
    
    if(params[:amount].size != params[:id].size)
      @amounts = params[:amount].select{|e| e.to_i != 0}
    else
      @amounts = params[:amount]
    end
    @a = []
    
    if(@group_expense.percent)
      @amounts.each do |a|
        div = a.to_f / 100
        p div
        p @group_expense.expense*div
        @a.push(@group_expense.expense*div)
      end
    else
      @a = @amounts
    end
    p @amounts
    p @a 
    if(@a.size != params[:id].size)
      flash[:alert] = "Backend Error"
      redirect_to request.referrer
      return
    end
    iter = 0
    @user_ids = []
    @selected_group = []
    @ids.each do |i|
      if(iter < @a.size)
        member = @group.memberships.find(i)
        @user_ids.push(member.user.id)
        #puts(member)
        member.active = true;
        member.amount = @a[iter]
        member.save
        @selected_group.push(member)
        iter += 1
        puts(member.attributes)
      end
    end
    puts(@selected_group)
    @setids = []
    if(params[:set])
      params[:set].each do |i|
        m = @group.memberships.find(i).user
        @setids.push(m.id)
      end
    end
    @selected_group.each do |member|
      puts member
      user_wallet member
      if(member.user == current_user)   
        p member.amount
        p member
        member.user.wallet.amount_lent += (@group_expense.expense - member.amount)
        p member.user.wallet.amount_lent
        member.user.wallet.save
        @bank.balance -= @group_expense.expense
        @bank.save
      else
        member.user.wallet.amount_borrowed += member.amount
        member.user.wallet.save
      end
      member.save
    end
  
   
    iter = 0
   respond_to do |format|
      if @group_expense.save
        ActiveRecord::Base.transaction do
          @user_ids.each do |i|
            if(params[:set])
              if(@setids.include? i)
                @group_expense_membership = @group_expense.group_expense_memberships.new(lenter: current_user, borrower_id: i, amount: @a[iter], settled: true)
                @u = @group_expense_membership.borrower
                @amt = @a[iter].to_f
                @u.wallet.amount_borrowed -= @amt
                @u.wallet.save
                @bank.balance -= @amt
                @bank.save
        
                @group_expense.creator.wallet.balance += @amt
                @group_expense.creator.wallet.amount_lent -= @amt
                @group_expense.creator.wallet.save
              else  
                @group_expense_membership = @group_expense.group_expense_memberships.new(lenter: current_user, borrower_id: i, amount: @a[iter], settled: false)
              end
            else
              @group_expense_membership = @group_expense.group_expense_memberships.new(lenter: current_user, borrower_id: i, amount: @a[iter], settled: false)
            end
            p @group_expense_membership.save
            iter += 1
          end
        end
        settle
        format.html { redirect_to request.referrer, notice: "Group expense was successfully created."}
        format.json { render :show, status: :created, location: @group_expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_expenses/1 or /group_expenses/1.json
  def update
    
    if(params[:set])
      params[:set].each do |settle|
        @group = Group.find(params[:group_id])
        @groups_expense = @group.group_expenses.find(params[:id])
        @amt = 0
        @ge = @group_expense.group_expense_memberships.find(settle)
        @u = @ge.borrower
        @group_expense.group_expense_memberships.each do |m|
          if(m.borrower == @u)
            @amt = m.amount
          end
        end
        @ge.settled = true
        @ge.save
        @u.wallet.amount_borrowed -= @amt
        @u.wallet.balance -= @amt
        @u.wallet.save
        
        @group_expense.creator.wallet.balance += @amt
        @group_expense.creator.wallet.amount_lent -= @amt
        @group_expense.creator.wallet.save
      end
    end
    settle
    respond_to do |format|
      if @group_expense.save
        format.html { redirect_to group_group_expenses_url, notice: "Group expense was successfully updated." }
        format.json { render :show, status: :ok, location: @group_expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group_expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_expenses/1 or /group_expenses/1.json
  def destroy
    @group_expense.group_expense_memberships.each do |a| 
      if(a.settled)
        a.borrower.wallet.balance += a.amount
        a.borrower.wallet.save
      else
        a.lenter.wallet.balance += a.amount
        a.lenter.wallet.amount_lent -= a.amount
        a.lenter.wallet.save
      end

      a.destroy
    end
    @group_expense.destroy
    respond_to do |format|
      format.html { redirect_to group_group_expenses_url, notice: "Group expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_expense
      @group = Group.find(params[:group_id])
      @group_expense = @group.group_expenses.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def group_expense_params
        params.require(:group_expense).permit(:group_id, :expense, :equal,:percent,memberships_attributes: [:id,:active,:amount])
    end
end
