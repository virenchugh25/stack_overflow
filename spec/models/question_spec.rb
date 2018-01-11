describe Question do
  let(:question) { FactoryBot.create(:question) }

  context 'text' do
    it 'validates its presence' do
      question.text = nil
      expect { question.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'user' do
    it 'validates its presence' do
      question.user_id = nil
      expect { question.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  # context 'default scope for active questions' do
  #   it 'returns recently created active question' do
  #     expect{ result = Question.find(question.id) }.not_to raise_error

  #     # expect(result).to eq question
  #   end

  #   # it 'does not return recently created inactive question' do
  #   #   result = Question.find_by(id: question.id)
  #   #   expect{Question.find(question.id)}.to raise_error

  #   #   expect(result).to_not eq question
  #   # end
  # end

  context 'Create question revision' do
    it 'creates revision on question create' do
      revision = Revision.find_by(revisable: question)

      expect(revision[:metadata]["text"]).to eq(question[:text])
    end

    it 'creates revision on question update' do
      question[:text] = 'Revised edition'
      question.save
      revision = Revision.find_by(revisable: question)

      expect(revision[:metadata]["text"]).to eq(question[:text])
    end
  end
end
