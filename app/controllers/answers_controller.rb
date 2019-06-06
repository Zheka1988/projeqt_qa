class AnswersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:edit, :destroy, :best_answer, :like, :dislike]

  def edit; end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.author = current_user
    @answer.save

    # respond_to do |format|
    #   # format.html { head :ok }
    #   # format.js
    #   if @answer.save
    #     format.html { render @answer }
    #   else
    #     format.html { render partial: 'shared/errors', locals: { resource: @answer },
    #                                        status: :unprocessable_entity }
    #   end
    # end
    # respond_to do |format|
    #   if @answer.save
    #     format.json { render json: @answer }
    #   else
    #     format.json do
    #       render json: @answer.errors.full_messages, status: :unprocessable_entity
    #     end
    #   end
    # end

  end

  def update
    @answer = Answer.find(params[:id])
    if current_user.author_of?(@answer)
      @answer.update(answer_params)
      @question = @answer.question
    else
      flash[:notice] = "Only author the answer can change the answer!"
      redirect_to @answer.question
    end
  end

  def destroy
    if current_user.author_of?(@answer)
      @answer.destroy
    else
      flash[:notice] = "Only author the answer can delete the answer!"
    end
  end

  def best_answer
    if current_user.author_of?(@answer.question)
      @answer.shoose_best_answer
      flash[:notice] = "Автору вопроса присвоена награда!"
    else
      flash[:notice] = "Shoose best answer for the question can only author the question!"
    end
  end

  def like
    if !current_user.author_of?(@answer)
      @voiting = current_user.voitings.create(answer_id: @answer.id, raiting: 1)
    else
      flash[:notice] = "Author the answer can not voiting!"
    end
  end

  def dislike
    if !current_user.author_of?(@answer)
       @voiting = current_user.voitings.create(answer_id: @answer.id, raiting: -1)
    else
      flash[:notice] = "Author the answer can not voiting!"
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
    params.require(:answer).permit(:body, :best, files: [], links_attributes: [:name, :url])
  end

end
