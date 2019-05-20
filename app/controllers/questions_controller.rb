class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy, :delete_atach_file]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = current_user.authored_questions.build(question_params)
    if @question.save
      redirect_to @question, notice: "Your question successfully created."
    else
      render :new
    end
  end

  def update
    if current_user.author_of?(@question)
      @question.update(question_params)
    else
      head :forbidden
    end
  end

  def destroy
    if current_user.author_of?(@question)
      @question.destroy
    else
      flash[:notice] = "Only author the question can delete the question!"
    end
  end

  def delete_attach_file

    # debugger
    if @question.files.find(blob_id: params[:blob_id]).purge
      render @question
    else
      flash[:notice] = "Что-то пошло не так!"
    end
  end

  private
  def question_params
    params.require(:question).permit(:title, :body, files: [])
  end

  def load_question
    @question = Question.find(params[:id])
  end

end



