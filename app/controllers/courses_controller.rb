class CoursesController < ApplicationController
  before_filter :login_required, only: [:new, :edit, :destroy, :epub]
  before_filter :get_course, only: [:show, :edit, :update, :destroy]
  # GET /courses
  # GET /courses.json
  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @courses = @category.courses.visible
    elsif params[:enrolled]
      login_required
      @courses = []
      Enrollment.where("user_id = ?", current_user.id).each do |e|
        @courses << e.course
      end
    elsif params[:taught] && logged_in?
      @courses = current_user.courses.order('updated_at desc')
    elsif params[:search]
      @courses = Course.search(params[:search]).bestest
    elsif params[:all]
      @courses = Course.visible
    else
      @courses = Course.best
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    track "view course", course_id: @course.id, title: @course.title
    respond_to do |format|
      format.html
      format.json { render json: @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    track "new course page"
    @course = current_user.courses.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course }
    end
  end

  # GET /courses/1/edit
  def edit
    authorize! :edit, @course
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(params[:course])
    authorize! :create, @course
    track "course created", course_id: @course, title: @course.title
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: "#{@course.title.titleize} was successfully created." }
        format.json { render json: @course, status: :created, location: @course }
      else
        format.html { render action: "new" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    authorize! :update, @course
    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    authorize! :destroy, @course
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  def epub
    @course = Course.find(params[:course_id])
    authorize! :read, @course
    if enrolled?(@course, current_user)
      data_opts = {type: "application/epub+zip", filename: "#{@course.title.slugify}.epub"}
      send_data File.read(@course.to_epub), data_opts
    else
      redirect_to root_url
    end
  end

  private

  def get_course
    @course = Course.unscoped.find(params[:id])
  end
end
