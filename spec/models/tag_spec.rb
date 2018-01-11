describe Tag do
  let(:tag) { FactoryBot.create(:tag) }

  context 'name' do
    it 'validates its presence' do
      tag.name = nil

      expect { tag.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
