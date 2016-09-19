require 'spec_helper'

describe RunThisAsync::Callee::Decoder do
  subject { described_class }

  context 'callee is a string' do
    let(:klass) { Object }
    let(:callee) { klass.to_s }

    it 'decodes to a class' do
      expect(subject.call(callee)).to eq(klass)
    end
  end
end
