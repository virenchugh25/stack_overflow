describe Comment do
  let(:comment) { FactoryBot.create(:question_comment) }
  
  context 'text' do
    it 'validates its presence' do
      comment.text = nil

      expect { comment.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'user' do
    it 'validates its presence' do
      comment.user_id = nil

      expect { comment.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'commentable' do
    it 'validates its presence' do
      comment.commentable = nil

      expect { comment.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'creating comment' do
    it 'creates revision' do
      revision = Revision.find_by(revisable: comment)

      expect(revision[:metadata]["text"]).to eq(comment[:text])
    end
  end

  context 'updating comment' do
    it 'creates revision' do
      comment[:text] = 'Revised edition'
      comment.save
      revision = Revision.where(revisable: comment).last

      expect(revision[:metadata]["text"]).to eq(comment[:text])
    end
  end
end
