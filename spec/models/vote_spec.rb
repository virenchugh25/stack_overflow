describe Vote do
  let(:vote) { FactoryBot.create(:question_vote) }

  context 'vote_value' do
    it 'validates its presence' do
      vote.vote_value = nil

      expect { vote.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'user' do
    it 'validates its presence' do
      vote.user_id = nil

      expect { vote.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'votable' do
    it 'validates its presence' do
      vote.votable = nil

      expect { vote.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'creating vote' do
    it 'creates revision' do
      revision = Revision.find_by(revisable: vote)

      expect(revision[:metadata]["vote_value"]).to eq(vote[:vote_value])
    end
  end

  context 'updating vote' do
    it 'creates revision' do
      vote[:vote_value] = -1
      vote.save
      revision = Revision.where(revisable: vote).last

      expect(revision[:metadata]["vote_value"]).to eq(vote[:vote_value])
    end
  end
end
