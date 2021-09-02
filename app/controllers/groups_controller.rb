class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[update edit]
  # GET /groups or /groups.json
  def index
    
    @g = Set[]
    current_user.memberships.each do |m|
      @g.add(m.group)
    end
    @groups = @g.to_a.filter_map{|e| e if e != nil }
  end

  # GET /groups/1 or /groups/1.json
  def show
    authorize @group
    @user_email = ""
    @names = @group.memberships
    puts(params[:user_email])

  end

  # GET /groups/new
  def new
    @group = Group.new
    @names = @group.memberships
    authorize @group
  end

  # GET /groups/1/edit
  def edit
    authorize @group
  end

  # POST /groups or /groups.json
  def create
    @group = Group.create(group_params)
    @group.creator = current_user
    puts(@group.users)
    respond_to do |format|
      if @group.save
        @membership = @group.memberships.create(:user => current_user)
        @membership.save
        format.html { redirect_to @group, notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    if(params[:user])
      if(!@user)
        @email = group_params[:email]
        @user = User.invite!(email: @email)
      end
      @member = @group.memberships.create(:user=>@user)
      puts(@user)
      @member.save
      puts(@group.name)
    end
    if(params[:group])
      p group_params[:name]
      @group.name = group_params[:name]
    end
    @group.save
    
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: "Group was successfully updated." }
    end
    # if(params[:group]!= nil)
    #   respond_to do |format|
    #     if @group.update(group_params)
    #       format.html { redirect_to @group, notice: "Group was successfully updated." }
    #       format.json { render :show, status: :ok, location: @group }
    #     else
    #       format.html { render :edit, status: :unprocessable_entity }
    #       format.json { render json: @group.errors, status: :unprocessable_entity }
    #     end
    #   end
    # else
      
    # end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])

    end

    # Only allow a list of trusted parameters through.
    def group_params
      if(params[:group] != nil)
        params.require(:group).permit(:name)
      elsif params[:user] != nil
        params.require(:user).permit(:email)
      end
    end
    def set_user
      @group = Group.find(params[:id])
      @user = User.find_by_email(params[:email])
    end
end
