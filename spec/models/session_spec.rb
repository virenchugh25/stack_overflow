describe Session do
  let(:session) { FactoryBot.create(:session) }

  context 'user' do
    it 'validates its presence' do
      session.user_id = nil

      expect { session.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'auth_token' do
    it 'validates its presence' do
      session.auth_token = nil

      expect { session.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
