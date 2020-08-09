module Api
  module V1

    class TasksController < ApplicationController
      before_action :set_task, only: [:show, :update, :destroy]
      before_action :require_same_user, only: [:update, :destroy]
      
      def index
        @tasks = logged_in_user.tasks
        render json: @tasks
      end

      def show
        render json: @task, status: :ok
      end

      def create
        @task = Task.new(task_params)
        @task.user = logged_in_user
        if @task.save
          render json: @task, status: :created
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: @task, status: :ok
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @task.destroy
          render json: { message: "Task deleted successfully" }, status: :ok
        else
          render json: { errors: "Task can't be deleted" }, status: :unprocessable_entity
        end
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:name)
      end

      def require_same_user
        if logged_in_user != @task.user
          render json: { errors: "You can't perform this action" }, status: :unprocessable_entity
        end
      end
      
    end

  end
end