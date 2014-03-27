class TasksController < ApplicationController

  def index
    # created_at でソート
    @tasks = Task.all.sort{ |a, b| a.created_at <=> b.created_at }
  end

  def create
    task = Task.new(params[:task])
    task.save
    redirect_to :back, notice: 'Created New Task.'
  rescue AWS::DynamoDB::Errors::ResourceNotFoundException
    # テーブルが存在しない場合は作成してリダイレクト
    Task.create_table 1, 1
    redirect_to :back, alert: 'Sorry, Try again.'
  end

  def destroy
    task = Task.find_by_id(params[:id])
    task.delete
    redirect_to :back, notice: 'Deleted Task.'
  end

end