class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  before_action :set_question, only: [:new, :create]
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def edit; end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to @question, notice: 'Your answer has been published.'
    else
      flash[:notice] = 'Your answer has not been published.'
      render "questions/show"
    end
  end

  def destroy
    if current_user.author_of?(@answer.author_id)
      @answer.destroy
      flash[:notice] = 'Your answer has been deleted.'
    else
      flash[:notice] = 'Your answer has not been deleted.'
    end
    redirect_to question_path(@answer.question)
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
