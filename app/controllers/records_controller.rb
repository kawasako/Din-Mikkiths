class RecordsController < ApplicationController

  skip_before_filter :verify_authenticity_token ,:only=>[:update]

  def index
    # Record.create_table 1, 1, { :hash_key => { :id => :string }, :range_key => { :time => :string } }
    if session[:user_id].blank?
      redirect_to :root
      return
    end
    @user = User.find_by_id(session[:user_id])
    @records = []
    for record_id in @user.has_records do
      unless record_id == "nill"
        @records.push(Record.find_by_id(record_id))
      end
    end
  end

  def create
    user = User.find_by_id(session[:user_id])
    record_id = user.id + '_' + params[:record]['id']

    user.has_records = user.has_records.add(record_id)
    user.save

    record = Record.new({id: record_id, value:''})
    record.save
    redirect_to :back, notice: 'Created New Record.'
  end

  def update
    # user = User.find_by_id(session[:user_id])
    record_id = params[:record]['id']
    record = Record.find_by_id(record_id)
    record.read_permission = params[:record]['read_permission']
    record.write_permission = params[:record]['write_permission']
    record.save
    redirect_to :back, notice: 'Updated New Record.'
  end

  def destroy
    user = User.find_by_id(session[:user_id])
    record_id = params[:id]

    user.has_records = user.has_records.delete(record_id)
    user.save

    record = Record.find_by_id(record_id)
    record.delete
    redirect_to :back, notice: 'Deleted Record.'
  end

end
