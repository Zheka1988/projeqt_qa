class RewardsController < ApplicationController
  def index
    @reward = current_user.reward
  end
end
