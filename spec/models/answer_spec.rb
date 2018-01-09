describe Answer do
  let(:answer) { FactoryBot.create(:answer) }
  
  context 'text' do
    it 'validates its presence' do
      answer.text = nil
      expect { answer.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'user' do
    it 'validates its presence' do
      answer.user_id = nil
      expect { answer.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'question' do
    it 'validates its presence' do
      answer.question_id = nil
      expect { answer.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'default scope for active answers' do
    it 'returns recently created active answer' do
      result = Answer.find_by(id: answer.id)
      expect(result).to eq answer
    end

    # it 'does not return recently created inactive answer' do
    #   answer = create(:answer, deleted_at: Time.now)
    #   result = Answer.find_by(id: answer.id)

    #   expect(result).to_not eq answer
    # end
  end

  context 'creating answer' do
    it 'creates revision' do
      revision = Revision.find_by(revisable: answer)

      expect(revision[:metadata]["text"]).to eq(answer[:text])
    end
  end

  context 'updating answer' do
    it 'creates revision' do
      answer[:text] = 'Revised edition'
      answer.save
      revision = Revision.where(revisable: answer).last

      expect(revision[:metadata]["text"]).to eq(answer[:text])
    end
  end
end
