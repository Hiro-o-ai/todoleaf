class TasksController < ApplicationController
  before_action :set_tasks, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.recent
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
    if @task.save
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
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_tasks
    @task = current_user.tasks.find(params[:id])
  end
end
