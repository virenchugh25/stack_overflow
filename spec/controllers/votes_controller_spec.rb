RSpec.describe Api::V1::VotesController, :type => :controller do
  let!(:vote) { vote = FactoryBot.build(:question_vote) }
  let(:question) { question = FactoryBot.create(:question) }
  let!(:user) { user = FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'when votes are present for question' do
      it 'returns list of votes' do
        pending
        vote.save
        get :index, params: { question_id: vote.question_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect([JSON.parse(vote.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'votes are not present for question' do
      it 'returns empty list' do
        pending
        get :index, params: { question_id: question.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'vote to show is present' do
      it "returns vote's details" do
        pending
        vote.save
        get :show, params: { id: vote.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(vote.to_json)
      end
    end

    context 'vote to show is not present' do
      it 'raises 404 error' do
        pending
        get :show, params: { id: 300 }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new vote' do
        cookies.signed[:user_id] = user.id
        post :create, params: { question_id: question.id, vote: { vote_value: 1 } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(Vote.last.to_json)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        cookies.signed[:user_id] = user.id
        post :create, params: { question_id: question.id, vote: { voter_value: 1 } }

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  # describe 'PUT #update' do
  #   context 'id given is correct' do
  #     it 'updates existing vote' do
  #       vote.save
  #       cookies.signed[:user_id] = vote.user_id
  #       put :update, params: { question_id: vote.votable_id, id: vote.id, vote: { text: 'Visa Man' } }

  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to eq('application/json')
  #     end
  #   end

  #   context 'id given is not correct' do
  #     it 'raises a not found error' do
  #       cookies.signed[:user_id] = vote.user_id
  #       put :update, params: { id: 300, question_id: vote.votable_id, vote: { name: 'Visa Man' } }

  #       expect(response).to have_http_status(:not_found)
  #       expect(response.content_type).to eq('application/json')
  #     end
  #   end
  # end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the vote' do
        vote.save
        cookies.signed[:user_id] = vote.user_id
        delete :destroy, params: { id: vote.id }

        expect(response).to have_http_status(:ok)
        expect(Vote.find_by(id: vote.id)).to eq(nil)
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        cookies.signed[:user_id] = vote.user_id
        delete :destroy, params: { id: 300 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
