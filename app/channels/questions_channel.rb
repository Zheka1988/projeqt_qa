class QuestionsChannel < ApplicationCable::Channel
  # def do_something(data)
  #   Rails.logger.info data
  # end
  # def echo(data)
  #   transmit data
  # end
  def follow
    stream_from "questions"
  end

end
