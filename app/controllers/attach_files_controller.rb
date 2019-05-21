class AttachFilesController < ApplicationController

  def destroy
    @file = ActiveStorage::Attachment.find(params[:id])
    if @file.purge
      redirect_to render_page(@file)
    else
      flash[:notice] = "Что-то пошло не так!"
    end
  end

  def render_page(file)
    if file.record_type == "Question"
      file.record
    elsif file.record_type == "Answer"
      file.record.question
    end
  end
end
