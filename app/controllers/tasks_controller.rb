class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @tasks.generate_csv, filename: "tasks-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def import
    current_user.tasks.import(params[:file])
    redirect_to tasks_url, notice: "タスクを追加しました"
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    # user_idの代入は Task.new(task_params.merge(user_id: current_user.id))でもOK
    # 下記はhas_manyと記述したことで使用できる関連を利用
    @task = current_user.tasks.new(task_params)

    if params[:back].present?
      render :new
      return
    end

    if @task.save
      TaskMailer.creation_email(@task).deliver_now
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    # redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
    # レスポンスボディなしでHTTPステータスとして204を
    # head :no_content
  end

  def confilm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  def set_tasks
    @task = current_user.tasks.find(params[:id])
  end
end
