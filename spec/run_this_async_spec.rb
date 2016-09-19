require 'spec_helper'

describe '#run_this' do
  let(:job_id) { nil }

  let(:arg) { 1 }
  let(:arg2) { 2 }

  let(:callee) { double }
  let(:encoded_callee) { double }

  before do
    allow(RunThisAsync::Callee::Encoder).to receive(:call).
      with(callee).and_return(encoded_callee)
  end

  context 'one method' do
    it 'schedules runner job' do
      expect(RunThisAsync::AsyncRunner).to receive(:perform_async).with(
        job_id, encoded_callee, [:call], [[arg]]
      )

      callee.run_this.call(arg).async
    end
  end

  context 'chained methods' do
    it 'schedules runner job' do
      expect(RunThisAsync::AsyncRunner).to receive(:perform_async).with(
        job_id, encoded_callee, [:new, :call], [[arg, arg2], []]
      )

      callee.run_this.new(arg, arg2).call.async
    end
  end

  context 'expected job id' do
    let(:job_id) { 'a certain expected job id' }

    it 'sets the job id' do
      expect(RunThisAsync::AsyncRunner).to receive(:perform_async).with(
        job_id, encoded_callee, [], []
      )

      callee.run_this(job_id).async
    end
  end
end
