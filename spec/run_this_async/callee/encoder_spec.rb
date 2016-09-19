require 'spec_helper'

describe RunThisAsync::Callee::Encoder do
  subject { described_class }

  shared_examples 'encoder' do
    it 'encodes callee' do
      expect(subject.call(callee)).to eq(encoded_callee)
    end
  end

  context 'class callee' do
    let(:encoded_callee) { callee.to_s }
    let(:callee) { Object }

    it_behaves_like 'encoder'
  end

  context 'object callee (bad idea to pass an object to a job, but works)' do
    let(:encoded_callee) { callee }
    let(:callee) { Object.new }

    it_behaves_like 'encoder'
  end
end
