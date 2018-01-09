describe User do
  let(:user) { user = FactoryBot.create(:user) }

  context 'email' do
    it 'validates presence of email' do
      user.email = nil
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'validates format of email' do
      user.email = 'this should not work'
      expect { user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'validates uniqueness of email' do
      expect { FactoryBot.create(:user, email: user.email) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'default scope for active user' do
    it 'returns recently created active object' do
      expect{ User.find(user.id) }.not_to raise_error

      # expect(result).to eq [user]
    end

    # it 'returns recently created inactive object' do
    #   user = create(:user, deleted_at: Time.now)
    #   result = User.find_by(user)

    #   expect(result).to_not eq [user]
    # end
  end
end
