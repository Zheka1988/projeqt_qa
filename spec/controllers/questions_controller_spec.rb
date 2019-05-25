require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let!(:user) { create(:user) }
  let(:question) { create :question, author: user }

  before { sign_in(user) }

  describe 'GET #index' do
    let(:questions) { create_list :question, 3, author: user  }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assign the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assign a new link @forr answer' do
      expect(assigns(:answer).links.first).to be_a_new(Link)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'assign a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'assign a new link @question' do
      expect(assigns(:question).links.first).to be_a_new(Link)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'communication with logged in user is established' do
        post :create, params: { question: attributes_for(:question) }
        expect(assigns(:question).author_id).to eq user.id
      end

      it 'saves a new question in the database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirect to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do

      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:question, :invalid) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'as author with valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question, question: { title: 'new title', body: 'new body' }, format: :js }
        question.reload

        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirect to updates questions' do
        patch :update, params: { id: question, question: attributes_for(:question) }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'as author with invalid attributes' do
      before { patch :update, params: { id: question, question: attributes_for(:question, :invalid) }, format: :js }

      it 'does not change question' do
        question.reload

        expect(question.title).to have_text 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template :update
      end
    end

    context 'as not author' do
      let!(:other_user) { create(:user) }
      let!(:other_question) { create :question, author: other_user }

      it 'attempt change question' do
        patch :update, params: { id: other_question, question: { body: "new body" } }, format: :js
        expect(response.status).to eq 403
      end

      it 'question attribute not change' do
        expect do
          patch :update, params: { id: other_question, question: { body: "new body" } }, format: :js
        end.to_not change(other_question, :body)
      end

    end
  end

  describe 'DELETE #destroy' do
    let!(:question) { create :question, author: user }
    let!(:other_user) { create(:user) }
    let!(:question_false) { create :question, author: other_user }

    it 'deletes the question if logged user is author' do
      expect { delete :destroy, params: { id: question }, format: :js }.to change(Question, :count).by(-1)
    end

    it 'deletes the question if user is not author' do
      expect { delete :destroy, params: { id: question_false }, format: :js }.to_not change(Question, :count)
    end

    it 'redirect to index' do
      delete :destroy, params: { id: question }, format: :js
      expect(response).to render_template :destroy
    end
  end

end
