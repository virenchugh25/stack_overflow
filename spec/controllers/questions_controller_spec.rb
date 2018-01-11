RSpec.describe Api::V1::QuestionsController, :type => :controller do
  let!(:question) { question = FactoryBot.build(:question) }
  let!(:user) { user = FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'when questions are present' do
      it 'returns list of questions' do
        question.save
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(question.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'questions are not present' do
      it 'returns empty list' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'question to show is present' do
      it "returns question's details" do
        question.save
        get :show, params: { id: question.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(question.to_json)
      end
    end

    context 'question to show is not present' do
      it 'raises 404 error' do
        get :show, params: { id: 300 }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new question' do
        cookies.signed[:user_id] = user.id
        post :create, params: { user_id: user.id, question: { text: 'Viren Chugh' } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(Question.last.to_json)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        cookies.signed[:user_id] = user.id
        post :create, params: { user_id: user.id, question: { texter: 'Viren Chugh' } }

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing question' do
        question.save
        cookies.signed[:user_id] = question.user_id
        put :update, params: { id: question.id, question: { text: 'Visa Man' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        cookies.signed[:user_id] = question.user_id
        put :update, params: { id: 300, question: { text: 'Visa Man' } }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the question' do
        question.save
        cookies.signed[:user_id] = question.user_id
        delete :destroy, params: { id: question.id }

        expect(response).to have_http_status(:ok)
        expect(Question.find_by(id: question.id)).to eq(nil)
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        cookies.signed[:user_id] = question.user_id
        delete :destroy, params: { id: 300 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
