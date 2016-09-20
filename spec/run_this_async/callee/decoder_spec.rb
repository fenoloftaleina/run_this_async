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

  context 'callee is an ActiveRecordPointer' do
    class X < ActiveRecord::Base; end

    let(:id) { 123 }
    let(:model_klass) { X }
    let(:model) { model_klass.new }
    let(:callee) { RunThisAsync::ActiveRecordPointer.new(X, id) }

    it 'decodes to a model' do
      allow(model_klass).to receive(:find_by).with(id: id).
        and_return(model)

      expect(subject.call(callee)).to eq(model)
    end
  end
end
