class AnswersController < ApplicationController
  include Voitinged

  before_action :authenticate_user!

  before_action :set_question, only: [:create]
  before_action :set_answer, only: [:edit, :destroy, :best_answer]
  before_action :gon_question, only: [:create]
  after_action :publish_answer, only: [:create]


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
    else
      flash[:notice] = "Shoose best answer for the question can only author the question!"
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

  def publish_answer
    return if @answer.errors.any?
    attach = {}
    @answer.attachments.each do |a|
      attach[:id] = a.id
      attach[:file_url] = a.file.url
      attach[:file_name] = a.file.identifier
    end
    ActionCable.server.broadcast(
      "answers_#{@question.id}",
      answer:             @answer,
      answer_attachments: attach,
      answer_voitings:      @answer.voitings,
      question_user_id:   @answer.question.user_id
    )
  end

  def gon_question
    gon.question_id = @question.id
  end

end
