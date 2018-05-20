class LecturesController < ApplicationController
  load_and_authorize_resource
  before_action :set_lecture, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , except: [:index, :show]

  # GET /lectures
  # GET /lectures.json
  def index
    course = Course.find(params[:course_id])
    @lectures = course.lectures
  end

  def download
    id = params[:id]
    lecture = Lecture.find(id)
    extension = lecture.attachment.split('.')
    send_file Rails.root.join('public' , 'uploads' , lecture.attachment),
    :type =>"application/#{extension[1]}", :x_sendfile=>true
  end

  def upvote 
    @lecture = Lecture.find(params[:id])
    @lecture.upvote_by current_user , :vote_scope => 'likes'
    redirect_back(fallback_location: root_path)
  end  
  
  def downvote
    @lecture = Lecture.find(params[:id])
    @lecture.downvote_by current_user , :vote_scope => 'likes'
    redirect_back(fallback_location: root_path)
  end

  def spam 
    @lecture = Lecture.find(params[:id])
    @lecture.upvote_by current_user, :vote_scope => 'spam'
    redirect_back(fallback_location: root_path)
  end 

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @lecture = Lecture.find(params[:id])
    if user_signed_in?
      @new_comment = Comment.build_from(@lecture,current_user.id, "")
    end
  end

  # GET /lectures/new
  def new
    course = Course.find(params[:course_id])
    @lecture = course.lectures.build
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = current_user.lectures.build(lecture_params)
    # @lecture = Lecture.new(lecture_params)
    # save file to server
    # if(params.key?(:lecture) && params.key?(:attachment))
    if @lecture.attachment?
        uploaded_io = params[:lecture][:attachment]
        File.open(Rails.root.join('public' , 'uploads' , uploaded_io.original_filename), 'wb') do |file|
          file.write(uploaded_io.read)
        end 
      
      @lecture.attachment = uploaded_io.original_filename
    end  

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to [@lecture.course , @lecture], notice: 'Lecture was successfully created.' }
        format.json { render :show, status: :created, location: [@lecture.course,@lecture] }
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to [@lecture.course , @lecture], notice: 'Lecture was successfully updated.' }
        format.json { render :show, status: :ok, location: [@lecture.course,@lecture] }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to course_lectures_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:content, :attachment, :course_id)
    end
end
