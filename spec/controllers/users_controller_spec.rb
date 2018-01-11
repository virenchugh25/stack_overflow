RSpec.describe Api::V1::UsersController, :type => :controller do
  let!(:user) { user = FactoryBot.build(:user) }

  describe 'GET #index' do
    context 'when users are present' do
      it 'returns list of users' do
        user.save
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect([JSON.parse(user.to_json)] - JSON.parse(response.body)).to eq([])
      end
    end

    context 'users are not present' do
      it 'returns empty list' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'GET #show' do
    context 'user to show is present' do
      it "returns user's details" do
        user.save
        get :show, params: { id: user.id }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(user.to_json)
      end
    end

    context 'user to show is not present' do
      it 'raises not found error' do
        get :show, params: { id: 22 }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'POST #create' do
    context 'parameters are correct' do
      it 'creates new user' do
        post :create, params: { user: { name: 'Viren Chugh', email: 'viren.chugh@1mg.com', password: 'abcd' } }

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq("application/json")
        expect(response.body).to eq(User.last.to_json)
      end
    end

    context 'parameters are not correct' do
      it 'raises an error' do
        post :create, params: { user: { name: 'Viren Chugh', email: 'viren.chugh.com', password: 'abcd' } }

        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'PUT #update' do
    context 'id given is correct' do
      it 'updates existing user' do
        user.save
        cookies.signed[:user_id] = user.id
        put :update, params: { id: user.id, user: { name: 'Visa Man' } }

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context 'id given is not correct' do
      it 'raises an error' do
        cookies.signed[:user_id] = 300
        put :update, params: { id: cookies.signed[:user_id], user: { name: 'Visa Man' } }

        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'id given is correct' do
      it 'soft deletes the user' do
        user.save
        cookies.signed[:user_id] = user.id
        delete :destroy, params: { id: user.id }

        expect(response).to have_http_status(:ok)
        expect(User.find_by(id: user.id)).to eq(nil)
      end
    end

    context 'id given is correct' do
      it 'soft deletes the user' do
        cookies.signed[:user_id] = 300
        delete :destroy, params: { id: 300 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
