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
    @question.create_voiting
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
      like = @question.voiting.like
      @question.voiting.update(like: like + 1)
      # respond_to do |format|
      #   format.json { render json: questions_path }
      # end
    else
      flash[:notice] = "Author can not voite the question!"
    end
  end

  def dislike
    if !current_user.author_of?(@question)
      dislike = @question.voiting.like
      @question.voiting.update(dislike: dislike + 1)
      # respond_to do |format|
      #   format.json { render json: questions_path }
      # end
    else
      flash[:notice] = "Author can not voite the question!"
    end
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



