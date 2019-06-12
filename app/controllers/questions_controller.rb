class QuestionsController < ApplicationController
  include Voitinged

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy ]

  after_action :publish_question, only: [:create]

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

  private
  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                        links_attributes: [:name, :url],
                                        reward_attributes: [:name, :file])
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: @question , current_user: nil}
        # json: { title: @question.title, body: @question.body }
        )
        #схема другая: отправляем не паршл,
        # а данные в json, а на клиенте из них строим уже нужный html
        # тут может быть полезен как раз шаблонизатор типа skim или подобный,
        #который на стороне js работает


    )
  end

end



