class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  before_action :set_question, only: [:new, :create]
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def show; end

  def edit; end

  def new
    @answer = @question.answers.new
  end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.author_id = current_user.id
    if @answer.save
      redirect_to @question, notice: 'Your answer has been published.'
    else
      redirect_to @question, notice: 'Your answer has not been published.'
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to admin_answer_path(@answer)
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @answer.author_id
      @answer.destroy
      redirect_to question_path(@answer.question), notice: 'Your answer has been deleted.'
    else
      redirect_to question_path(@answer.question), notice: 'Your answer has not been deleted.'
    end
  end

  private
  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

end
