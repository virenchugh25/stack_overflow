RSpec.describe Api::V1::SessionsController, :type => :controller do
  let(:user) { user = FactoryBot.create(:user) }
  let(:session) { session = FactoryBot.create(:session) }

  describe 'post #login' do
    context 'when email and password are legitimate' do
      it 'sets auth_token and user_id in cookie' do
        post :login, params: { user: { email: user.email, password: user.password } }

        expect(response).to have_http_status(:created)
        expect(cookies.signed[:user_id]).to eq(user.id)
        expect(cookies.signed[:auth_token]).to eq(Session.find_by(user_id: user.id).auth_token)
      end
    end

    context 'when email and password are not legitimate' do
      it 'responds with unauthorized error' do
        post :login, params: { user: { email: user.email, password: 'Invalid' } }

        expect(response).to have_http_status(:unauthorized)
        expect(cookies.signed[:user_id]).to eq(nil)
        expect(cookies.signed[:auth_token]).to eq(nil)
      end
    end

    context 'when user is already logged in' do
      it 'responds with logged in error' do
        cookies.signed[:user_id] = session.user_id
        cookies.signed[:auth_token] = session.auth_token
        post :login, params: { user: { email: user.email, password: user.password } }

        expect(response).to have_http_status(:found)
        expect(cookies.signed[:user_id]).to eq(session.user_id)
        expect(cookies.signed[:auth_token]).to eq(session.auth_token)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is logged in' do
      it 'deletes cookie and logs user out' do
        cookies.signed[:user_id] = session.user_id
        cookies.signed[:auth_token] = session.auth_token
        delete :destroy

        expect(response).to have_http_status(:ok)
        expect(Session.find_by(auth_token: session.auth_token)).to eq(nil)
        expect(response.cookies[:user_id]).to eq(nil)
        expect(response.cookies[:auth_token]).to eq(nil)
      end
    end
  end
end