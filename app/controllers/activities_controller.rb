class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy]

  def index
    @activities = Activity.all
  end

  def show
  end

  def new
    @activity = Activity.new
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to root_path, notice: "Activity was successfully created." }
        format.json { render :statistics, status: :created, location: @activity }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: "Activity was successfully updated." }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: "Activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def statistics
    activities_per_days = Activity.group_by_day
    @activities = []
    activities_per_days.each do |day, activities|
      row = {
        distance: activities.select(&:distance).sum(&:distance),
        created_at: day
      }
      @activities << row
    end
    @activities
  end

  private
  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:starting_address, :end_address, :created_at)
  end
end
