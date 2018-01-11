RSpec.describe Api::V1::CommentsController, :type => :controller do
  let!(:comment) { comment = FactoryBot.build(:question_comment) }
  let(:question) { question = FactoryBot.create(:question) }
  let!(:user) { user = FactoryBot.create(:user) }

  describe 'GET #index' do
    context 'when comments are present for question' do
      it 'returns list of comments' do
        pending
        comment.save
        get :index, params: { question_id: comment.question_id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect([JSON.parse(comment.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'comments are not present for question' do
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
    context 'comment to show is present' do
      it "returns comment's details" do
        pending
        comment.save
        get :show, params: { id: comment.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(comment.to_json)
      end
    end

    context 'comment to show is not present' do
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
      it 'creates new comment' do
        cookies.signed[:user_id] = user.id
        post :create, params: { question_id: question.id, comment: { text: 'Viren Chugh' } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(Comment.last.to_json)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        cookies.signed[:user_id] = user.id
        post :create, params: { question_id: question.id, comment: { texter: 'Viren Chugh' } }

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing comment' do
        comment.save
        cookies.signed[:user_id] = comment.user_id
        put :update, params: { question_id: comment.commentable_id, id: comment.id, comment: { text: 'Visa Man' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        cookies.signed[:user_id] = comment.user_id
        put :update, params: { id: 300, question_id: comment.commentable_id, comment: { name: 'Visa Man' } }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the comment' do
        comment.save
        cookies.signed[:user_id] = comment.user_id
        delete :destroy, params: { id: comment.id }

        expect(response).to have_http_status(:ok)
        expect(Comment.find_by(id: comment.id)).to eq(nil)
      end
    end

    context 'id given is not correct' do
      it 'raises a not found error' do
        cookies.signed[:user_id] = comment.user_id
        delete :destroy, params: { id: 300 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
