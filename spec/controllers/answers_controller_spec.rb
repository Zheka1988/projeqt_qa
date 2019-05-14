require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let(:question) { create :question, author: user }
  let(:answer) { create :answer, question: question, author: user }

  before { sign_in(user) }

  describe 'POST #create' do
    context 'with valid data' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js }.to change(Answer, :count).by(1)
      end

      it 'communication with logged in user is established' do
        post :create, params: { question_id: question, author_id: user, answer: attributes_for(:answer) },format: :js
        expect(assigns(:answer).author_id).to eq(user.id)
      end

      it 'the answer is related to the question' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
        expect(response).to render_template :create #redirect_to assigns(:question)
      end
    end

    context 'with invalid data' do
      it 'does not save the answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }, format: :js }.to_not change(Answer, :count)
      end

      it 'render to new view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(subject).to render_template :create #("questions/show")
      end
    end
  end

  # describe 'GET #edit' do
  #   before { get :edit, params: { id: answer } }

  #   it 'assign the requested answer to @answer' do
  #     expect(assigns(:answer)).to eq answer
  #   end

  #   it 'render edit view' do
  #     expect(response).to render_template :edit
  #   end
  # end

  describe 'DELETE #destroy' do
    let!(:answer) { create :answer, question: question, author: user }
    let!(:other_user) { create(:user) }
    let!(:answer_false) { create :answer, question: question, author: other_user  }

    it 'deletes the question if logged user is author ' do
      expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
    end

    it 'deletes the question if user is not author ' do
      expect { delete :destroy, params: { id: answer_false }, format: :js }.to_not change(Answer, :count)
    end

    it 'redirect to index' do
      delete :destroy, params: { id: answer }, format: :js
      expect(response).to render_template :destroy #redirect_to question_path(question)
    end
  end

  describe 'PATH #update' do
    # let(:answer) { create :answer, question: question, author: user }
    context 'with valid attribute' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end
      it 'rendering update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attribute' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :body)
      end

      it 'rendering update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end

end
