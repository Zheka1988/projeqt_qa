class AnswersController < ApplicationController
  before_action :authenticate_user!

  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:edit, :destroy, :best_answer]

  def edit; end

  def create
    @answer = @question.answers.build(answer_params)
    @answer.author = current_user
    @answer.save
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
      # give_reward
    else
      flash[:notice] = "Shoose best answer for the question can only author the question!"
    end

  end

  private

  # def give_reward
  #   # @answer.question.rewards.each do |r|
  #   #   if r.rewardable_id ==  @answer.question.id
  #   #     @answer.author.rewards.create(name: @answer.question.reward.name, file: @answer.question.reward.file) #path: url_for(r.file)
  #   #   end
  #   # end
  #   @answer.author.create_reward(name: @answer.question.reward.name, file: @answer.question.reward.file)

  #   # debugger
  # end

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
