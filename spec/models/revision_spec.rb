describe Revision do
  let(:revision) { FactoryBot.create(:answer_revision) }

  context 'revisable' do
    it 'validates its presence' do
      revision.revisable = nil

      expect { revision.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
