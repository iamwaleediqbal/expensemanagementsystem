class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  
  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.filter_by_user(current_user.id).page(params[:page]).per(5)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = current_user.transactions.new(create_transaction_params)
    p(@transaction.bank_account_id)
    @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
    
    if(@bank_account.account_number == current_user.id.to_s)
      #Ex:- :null => false
      if(@transaction.is_a? Income) 
        @wallet = current_user.wallet
        @wallet.balance += @transaction.amount
        p @wallet
        @wallet.save
      elsif(@transaction.is_a? Expense)
        @wallet = current_user.wallet
        @wallet.balance -= @transaction.amount
        p @wallet
        @wallet.save
      else
        raise "Kindly Select Bank For sending from or to wallet" 
      end
    
    end
    if(@transaction.is_a? Income)
        @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
        @bank_account.balance += @transaction.amount
        @bank_account.save
    elsif(@transaction.is_a? Expense)
        @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
        @bank_account.balance -= @transaction.amount
        @bank_account.save
    else
        if(@transaction.from_wallet)
          current_user.wallet.balance -= @transaction.amount
          current_user.wallet.save
          @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
          @bank_account.balance += @transaction.amount
          @bank_account.save
        else
          current_user.wallet.balance += @transaction.amount
          current_user.wallet.save
          @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
          @bank_account.balance -= @transaction.amount
          @bank_account.save
        end
    end
    respond_to do |format|
      if @transaction.save
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

    @t = Transaction.new(transaction_params)
    @tran = current_user.transactions.find(@transaction.id)
    p @tran
    @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
    @bank = current_user.bank_accounts.find(@t.bank_account_id)
    
    if(@bank.account_number == current_user.id.to_s && (!@t.is_a? (Expense)) && (!@t.is_a? (Income)))
      raise "Kindly Select Bank to send money to or from wallet"
    end
    p current_user.wallet
    if(@bank_account.account_number == current_user.id.to_s)
      current_user.wallet.balance += (@tran.is_a? (Expense)) ? @tran.amount : (-1)*@tran.amount
      current_user.wallet.save
    elsif(@transaction.is_a? BankTransfer)
      
      @b = @current_user.bank_accounts.find(@tran.bank_account_id)
      if(@transaction.from_wallet)
        @b.balance -= @transaction.amount
        current_user.wallet.balance += @transaction.amount
      else
        @b.balance += @transaction.amount
        current_user.wallet.balance += @transaction.amount
      end
      @b.save
      current_user.wallet.save
    else
      @b = @current_user.bank_accounts.find(@tran.bank_account_id)
      @b.balance += (@tran.is_a? (Expense)) ? @tran.amount : (-1)*@tran.amount
      @b.save
    end
    respond_to do |format|
      if @transaction.update(transaction_params)
        @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
        if(@bank_account.account_number == current_user.id.to_s)
          if(@transaction.is_a? Income) 
            @wallet = current_user.wallet
            @wallet.balance += @transaction.amount
            p @wallet
            @wallet.save
          elsif(@transaction.is_a? Expense)
            @wallet = current_user.wallet
            @wallet.balance -= @transaction.amount
            p @wallet
            @wallet.save
          else
            raise "Kindly Select Bank For sending from or to wallet" 
          end
        
        end
        if(@transaction.is_a? Income)
            @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
            @bank_account.balance += @transaction.amount
            @bank_account.save
        elsif(@transaction.is_a? Expense)
            @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
            @bank_account.balance -= @transaction.amount
            @bank_account.save
        else
            if(@transaction.from_wallet)
              current_user.wallet.balance -= @transaction.amount
              current_user.wallet.save
              @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
              @bank_account.balance += @transaction.amount
              @bank_account.save
            else
              current_user.wallet.balance += @transaction.amount
              current_user.wallet.save
              @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
              @bank_account.balance -= @transaction.amount
              @bank_account.save
            end
        end  
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
    p(@transaction.bank_account_id)
    @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
    
    if(@bank_account.account_number == current_user.id.to_s)
      if(@transaction.is_a? Income) 
        @wallet = current_user.wallet
        @wallet.balance -= @transaction.amount
        p @wallet
        @wallet.save
      elsif(@transaction.is_a? Expense)
        @wallet = current_user.wallet
        @wallet.balance += @transaction.amount
        p @wallet
        @wallet.save
      end
    else
      if(@transaction.is_a? Income)
        @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
        @bank_account.balance -= @transaction.amount
        @bank_account.save
      elsif(@transaction.is_a? Expense)
        @bank_account = current_user.bank_accounts.find(@transaction.bank_account_id)
        @bank_account.balance += @transaction.amount
        @bank_account.save
      else
        if(@transaction.from_wallet)
          current_user.wallet.balance += @transaction.amount
          current_user.wallet.save
          @bank_account.balance -= @transaction.amount
          @bank_account.save
        else
          current_user.wallet.balance -= @transaction.amount
          current_user.wallet.save
          @bank_account.balance += @transaction.amount
          @bank_account.save
        end
      end

    end
    
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
    end

    # Only allow a list of trusted parameters through.
    def create_transaction_params
      # if params.has_key? :income
      #   params[:transaction] = params.delete :income
      # elsif params.has_key? :expense
      #   params[:transaction] = params.delete :expense
      # end
      params.require(:transaction).permit(:bank_account_id, :user_id, :amount, :type,:from_wallet, :date_performed, :category)
    end
    def transaction_params
      # if params.has_key? :income
      #   params[:transaction] = params.delete :income
      # elsif params.has_key? :expense
      #   params[:transaction] = params.delete :expense
      # end
      params.require(params[:type].to_sym).permit(:bank_account_id, :user_id, :amount, :type, :from_wallet, :date_performed, :category)
    end
end
