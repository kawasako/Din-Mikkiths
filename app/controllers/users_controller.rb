class UsersController < ApplicationController

  def index
    @users = User.all.sort{ |a, b| b.created_at <=> a.created_at }
  end

  def login
    user_id = params[:id]
    user = User.find_by_id(params[:user][:id])
    if user.password == params[:user][:password]
      session[:user_id] = params[:user][:id]
      redirect_to :records
    else
      redirect_to :root
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :root
  end

  def create
    user = User.new(params[:user])
    user.has_records = ["nill"]
    user.save
    redirect_to :back, notice: 'Created New User.'
  end

  def destroy
    user = User.find_by_id(params[:id])
    for record_id in user.has_records do
      unless record_id == "nill"
        record = Record.find_by_id(record_id)
        record.delete
      end
    end

    user.delete
    redirect_to :back, notice: 'Deleted User.'
  end

end
