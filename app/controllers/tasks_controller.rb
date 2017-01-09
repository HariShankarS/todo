class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :newsubtask]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all.where(:parent_id => nil)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @subtasks = @task.subtasks
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end


  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @subtask = Task.new(task_params)

    respond_to do |format|
      if @subtask.save
        @task = Task.find_by_id(@subtask.parent_id) || @subtask
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.js { render :layout => false }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    if @task.parent_id.present?
      if @task.update(task_params)
        @task = Task.find_by_id(@task.parent_id)
        respond_to do |format|
          format.html { redirect_to @task, notice: 'Task was successfully updated.' }
          format.json { render :show, status: :ok, location: @task }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end      
    else
      if @task.update(task_params)
        respond_to do |format|
          format.html { redirect_to @task, notice: 'Task was successfully updated.' }
          format.json { render :show, status: :ok, location: @task }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    if @task.parent_id.present?
      @task = Task.find_by_id(@task.parent_id)
      respond_to do |format|
        format.html { redirect_to @task, notice: 'Task was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to tasks_path, notice: 'Task was successfully destroyed.' }
        format.json { head :no_content }
      end
    end      
  end


  def newsubtask
    @subtasks = @task.subtasks
    @subtask = @subtasks.new
    respond_to do |format|
      format.js { render :layout => false }
    end   
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:work, :finished, :parent_id)
    end
end
