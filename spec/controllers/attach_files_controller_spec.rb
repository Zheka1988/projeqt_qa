require 'rails_helper'

RSpec.describe AttachFilesController, type: :controller do
  let!(:user) { create(:user) }
  let(:question) { create :question, author: user }

  describe 'DELETE #destroy' do

    it 'delete attach file' do
      file = fixture_file_upload("#{Rails.root}/spec/spec_helper.rb")
      question.files.attach(io: File.open("#{Rails.root}/spec/spec_helper.rb"),
        filename: 'spec_helper.rb', content_type: 'file/rb')
        # expect(question.files).to be_attached
      expect { delete :destroy, params: { id: question.files.first.id } }.to change(question.files, :count).by(-1)
    end
  end
end

