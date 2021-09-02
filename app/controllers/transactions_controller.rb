class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  
  # GET /transactions or /transactions.json
  def index
    @transactions = current_user.transactions.order('created_at DESC').page(params[:page]).per(5)
    authorize @transactions
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end
  
  # GET /transactions/new
  def new
    @transaction = current_user.transactions.new
    @accounts = []
    current_user.bank_accounts.each do |bank_account| @accounts.push([bank_account.name,bank_account.id]) end
    @accounts.push([current_user.wallet.class.name,current_user.wallet.id])
    authorize @transaction
  end
  
  def handle_change
    if(@transaction.transfer_from_type == "Wallet")
        
      if(@transaction.is_a? Income)
        current_user.wallet.balance += @transaction.amount
        current_user.wallet.save
      else
        current_user.wallet.balance -= @transaction.amount
        current_user.wallet.save
      end
      if(@transaction.transfer_to_id != nil)
        @b = current_user.bank_accounts.find(@transaction.transfer_to_id)
        @b.balance += @transaction.amount
        @b.save
      end

    elsif(@transaction.transfer_from_type == "BankAccount")
      @b = current_user.bank_accounts.find(@transaction.transfer_from_id)
      if(@transaction.is_a? Income)
        @b.balance += @transaction.amount
        @b.save
      else
        @b.balance -= @transaction.amount
        @b.save
      end
      if(@transaction.transfer_to_id != nil)
        current_user.wallet.balance += @transaction.amount
        current_user.wallet.save
      end
    end

  end
  def handle_update
    if(@transaction.transfer_from_type == "Wallet")
      if(@transaction.is_a? Income)
        current_user.wallet.balance -= @transaction.amount
        current_user.wallet.save
      else
        current_user.wallet.balance += @transaction.amount
        current_user.wallet.save
      end
      if(@transaction.transfer_to_id != nil)
        @b = current_user.bank_accounts.find(@transaction.transfer_to_id)
        @b.balance -= @transaction.amount
        @b.save
      end

    elsif(@transaction.transfer_from_type == "BankAccount")
      @b = current_user.bank_accounts.find(@transaction.transfer_from_id)
      if(@transaction.is_a? Income)
        @b.balance -= @transaction.amount
        @b.save
      else
        @b.balance += @transaction.amount
        @b.save
      end
      if(@transaction.transfer_to_id != nil)
        current_user.wallet.balance -= @transaction.amount
        current_user.wallet.save
      end
    end

  end
  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    params[:transaction].delete(:transfer_from)
    @transaction = current_user.transactions.new(create_transaction_params)
    if(@transaction.is_a?(Expense) || @transaction.is_a?(BankTransfer))
      if(@transaction.transfer_from_type == "Wallet")
        if(current_user.wallet.balance < @transaction.amount)
          flash[:alert] = "You have low Balance"
          redirect_to request.referrer
          return
        end
      end
      if( @transaction.transfer_from_type == "BankAccount")
        if( current_user.bank_accounts.find(@transaction.transfer_from_id).balance < @transaction.amount)
          flash[:alert] = "You have low Balance"
          redirect_to request.referrer
          return
        end
      end
    end
      
    p @transaction
    authorize @transaction
    
    respond_to do |format|
      if @transaction.save
        
        handle_change
        format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    handle_update
    respond_to do |format|
      if @transaction.update(transaction_params)
        handle_change
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    handle_update
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
      authorize @transaction
    end

    # Only allow a list of trusted parameters through.
    def create_transaction_params
      # if params.has_key? :income
      #   params[:transaction] = params.delete :income
      # elsif params.has_key? :expense
      #   params[:transaction] = params.delete :expense
      # end
      params.require(:transaction).permit(:transfer_from_id,:transfer_from_type, :transfer_to_id, :transfer_to_type, :user_id, :amount, :type,:from_wallet, :date_performed, :category)
    end
    def transaction_params
      # if params.has_key? :income
      #   params[:transaction] = params.delete :income
      # elsif params.has_key? :expense
      #   params[:transaction] = params.delete :expense
      # end
      params.require(params[:type].to_sym).permit(:transfer_from_id,:transfer_from_type, :transfer_to_id, :transfer_to_type, :user_id, :amount, :type, :from_wallet, :date_performed, :category)
    end
end
