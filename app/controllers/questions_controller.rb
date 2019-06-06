class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy, :like, :dislike]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @answer.links.new

  end

  def new
    @question = Question.new
    @question.links.new
    @question.build_reward
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

  def like
    if !current_user.author_of?(@question)
      @voiting = current_user.voitings.create(voitingable_type: 'Question', voitingable_id: @question.id, raiting: 1)
    else
      flash[:notice] = "Author the question can not voiting!"
    end
    render json: @voiting.as_json.merge(sum_raiting: @question.sum_raiting)
  end

  def dislike
    if !current_user.author_of?(@question)
      @voiting = current_user.voitings.create(voitingable_type: 'Question', voitingable_id: @question.id, raiting: -1)
    else
      flash[:notice] = "Author the question can not voiting!"
    end
    render json: @voiting.as_json.merge(sum_raiting: @question.sum_raiting)
  end

  private
  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                        links_attributes: [:name, :url],
                                        reward_attributes: [:name, :file])
  end

  def load_question
    @question = Question.find(params[:id])
  end

end



