require 'spec_helper'

describe RunThisAsync::AsyncRunner do
  subject { described_class.new }

  describe '#perform' do
    let(:callee) { double }
    let(:callee2) { double }

    let(:method) { :method }
    let(:method2) { :method2 }

    let(:arg) { 1 }
    let(:arg2) { 2 }
    let(:arg3) { 3 }
    let(:arg4) { 4 }

    let(:jid) { 'job real id' }

    before do
      allow(subject).to receive(:jid).and_return(jid)
    end

    context 'without expecting a certain job id' do
      let(:expected_job_id) { nil }

      context 'one method' do
        it 'calls a method on a said callee with args' do
          expect(callee).to receive(method).with(arg, arg2)

          subject.perform(expected_job_id, callee, method, [arg, arg2])
        end

        it 'calls a method on a said callee without args' do
          expect(callee).to receive(method).with(no_args)

          subject.perform(expected_job_id, callee, method)
        end
      end

      context 'array of methods' do
        it 'calls consecutive methods with consecutive collections of args' do
          expect(callee).to receive(method).with(arg, arg2).and_return(callee2)
          expect(callee2).to receive(method2).with(arg3, arg4)

          subject.perform(
            expected_job_id,
            callee,
            [method, method2],
            [[arg, arg2], [arg3, arg4]]
          )
        end
      end

      context 'callee is a string' do
        let(:klass) { Object }
        let(:callee) { klass.to_s }

        it 'calls the klass' do
          expect(klass).to receive(method)

          subject.perform(expected_job_id, callee, method)
        end
      end
    end

    context 'with a certain job id expected' do
      context 'unexpected job id' do
        let(:different_jid) { jid + ' or is it?' }

        it 'does not call any methods' do
          expect(callee).not_to receive(method)

          subject.perform(different_jid, callee, method)
        end
      end

      context 'expected job id' do
        it 'calls methods alright' do
          expect(callee).to receive(method)

          subject.perform(jid, callee, method)
        end
      end
    end
  end
end
