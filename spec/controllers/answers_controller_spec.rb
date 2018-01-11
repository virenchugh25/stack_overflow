RSpec.describe Api::V1::AnswersController, :type => :controller do
  let!(:answer) { answer = FactoryBot.build(:answer) }
  let(:question) { question = FactoryBot.create(:question) }
  let!(:user) { user = FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'when answers are present for question' do
      it 'returns list of answers' do
        pending
        answer.save
        get :index, params: { question_id: answer.question_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(answer.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'answers are not present for question' do
      it 'returns empty list' do
        pending
        get :index, params: { question_id: question.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'answer to show is present' do
      it "returns answer's details" do
        pending
        answer.save
        get :show, params: { id: answer.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(answer.to_json)
      end
    end

    context 'answer to show is not present' do
      it 'raises 404 error' do
        pending
        get :show, params: { id: 300 }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new answer' do
        cookies.signed[:user_id] = user.id
        post :create, params: { question_id: question.id, answer: { text: 'Viren Chugh' } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(Answer.last.to_json)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        cookies.signed[:user_id] = user.id
        post :create, params: { question_id: question.id, answer: { texter: 'Viren Chugh' } }

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing answer' do
        answer.save
        cookies.signed[:user_id] = answer.user_id
        put :update, params: { question_id: answer.question_id, id: answer.id, answer: { text: 'Visa Man' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        cookies.signed[:user_id] = answer.user_id
        put :update, params: { id: 300, question_id: answer.question_id, answer: { name: 'Visa Man' } }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the answer' do
        answer.save
        cookies.signed[:user_id] = answer.user_id
        delete :destroy, params: { id: answer.id }

        expect(response).to have_http_status(:ok)
        expect(Answer.find_by(id: answer.id)).to eq(nil)
      end
    end

    context 'id given is not correct' do
      it 'raise a not found error' do
        cookies.signed[:user_id] = answer.user_id
        delete :destroy, params: { id: 300 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
