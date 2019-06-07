module Voitinged
  extend ActiveSupport::Concern

  included do
    before_action :set_voitingable, only: [:like, :dislike]
  end

  def like
    if !current_user.author_of?(@voitingable)
      @voiting = current_user.voitings.create(voitingable: @voitingable, raiting: 1)
      render json: @voiting.as_json.merge(sum_raiting: @voitingable.sum_raiting)
    else
      flash[:notice] = "Author the question can not voiting!"
      render :index
    end
  end

  def dislike
    if !current_user.author_of?(@voitingable)
      @voiting = current_user.voitings.create(voitingable: @voitingable, raiting: -1)
      render json: @voiting.as_json.merge(sum_raiting: @voitingable.sum_raiting)
    else
      flash[:notice] = "Author the question can not voiting!"
      render :index
    end
  end
  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_voitingable
    @voitingable = model_klass.find(params[:id])
  end
end
