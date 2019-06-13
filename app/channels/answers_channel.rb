class AnswersChannel < ApplicationCable::Channel

  def start_st_answers(data)
    stream_from "answers_#{data['question_id']}"
  end
end
