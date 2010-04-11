class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :add_friend, :remove_friend, :accept_friend, :reject_friend, :cancel_friendship_request]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :check_consistency, :only => [:add_friend, :remove_friend, :accept_friend, :reject_friend, :cancel_friendship_request]
  
  
  def show
    if signed_in?
      check_consistency()
      @friends = @user.friends
      @sent_invitations = @user.pending_out
      @received_invitations = @user.pending_in
    else
      @user = User.find(params[:id])
    end
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      @user.password = "";
      @user.password_confirmation = "";
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def index
    @title = "All users"
    @users = User.paginate :page => params[:page], :per_page => 5 
  end
  
  def destroy
    user = User.find(params[:id])
    if user.admin?
      flash[:success] = "Admins cannot destroy other admins."
    else
      user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end
  
  def add_friend
    if current_user?(@user)
      return unauthorized_link("Can't add yourself as a friend! Do'h..")
    end
    if @friendship_status==:friends
      return unauthorized_link("You are already friend with this person") 
    end
    if @friendship_status==:pending_out
      return unauthorized_link("An invite has already been issued")  
    end

    @relationship = Relationship.create(:user1_id =>current_user.id, :user2_id =>@user.id, :pending=>true)
    flash[:success] = "A pending invation was sent to #{@user.name} to be your friend."
    redirect_to @user
  end
  
  def remove_friend
    if @friendship_status!=:friends 
      return unauthorized_link("You are not friend with this person")
    end
    
    @relationship.destroy
    @reverse_relationship.destroy
    flash[:success] = "Person removed from the friends list."
    redirect_to @user
  end

  def accept_friend
    if @friendship_status==:friends
      return unauthorized_link("You already accepted this request")
    end
    if @friendship_status!=:pending_in
      return unauthorized_link("You have not been invited by this person to become friends")
    end
    
    @reverse_relationship.update_attributes(:pending => false)
    @relationship = Relationship.create(:user1_id =>current_user.id, :user2_id =>@user.id, :pending=>false)
    flash[:success] = "Friendship request accepted."
    redirect_to @user
  end

  def reject_friend
    if @friendship_status==:friends
      return unauthorized_link("You already accepted this request") 
    end
    if @friendship_status!=:pending_in
      return unauthorized_link("You have not been invited by this person to become friends") 
    end
    
    @reverse_relationship.destroy
    flash[:success] = "Friendship request rejected."
    redirect_to @user
  end

  def cancel_friendship_request
    if @friendship_status==:friends
      unauthorized_link("You are already friend with this person")
    end
    if @friendship_status!=:pending_out
      unauthorized_link("You have not issued such a friendship request") 
    end
    
    @relationship.destroy
    flash[:success] = "Friendship request cancelled."
    redirect_to @user
  end

private

  def friendship_status()
    @relationship = Relationship.find_by_user1_id_and_user2_id(current_user.id,@user.id)
    @reverse_relationship = Relationship.find_by_user1_id_and_user2_id(@user.id, current_user.id)

    # legal statuses
    return @friendship_status = :none if @relationship.nil? && @reverse_relationship.nil?
    return @friendship_status = :pending_in if @relationship.nil? && @reverse_relationship.pending?
    return @friendship_status = :pending_out if @reverse_relationship.nil? && @relationship.pending?
    return @friendship_status = :friends if !@relationship.nil? && !@reverse_relationship.nil? && !@relationship.pending? && !@reverse_relationship.pending?
    return @friendship_status = :inconsistent
  end

  def check_consistency()
    @user = User.find(params[:id])
    friendship_status()
    # illegal statuses
    if @friendship_status==:inconsistent
      repair_relationship(@relationship, current_user, @user)
      repair_relationship(@reverse_relationship, @user, current_user)
      flash.now[:notice] = "Inconsistent friendship state - repaired!"
      # repaired illegal statuses => friends
      @friendship_status = :friends
    end
    @friendship_status 
  end

  def repair_relationship(relationship, user1, user2)
      if relationship.nil?
        relationship = Relationship.create(:user1_id =>user1.id, :user2_id =>user2.id, :pending=>false)
      else 
        if relationship.pending?
          relationship.update_attributes(:pending => false)
        end
      end
  end

  def unauthorized_link(msg)
      flash[:error] = "#{msg}. Please use only the links in the website."
      redirect_to @user
  end

  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end