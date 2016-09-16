require 'spec_helper'

describe '#run_this' do
  let(:job_id) { nil }

  let(:arg) { 1 }
  let(:arg2) { 2 }

  shared_examples 'scheduler' do
    context 'one method' do
      it 'schedules runner job' do
        expect(RunThisAsync::AsyncRunner).to receive(:perform_async).with(
          job_id, job_format_callee, [:call], [[arg]]
        )

        callee.run_this.call(arg).async
      end
    end

    context 'chained methods' do
      it 'schedules runner job' do
        expect(RunThisAsync::AsyncRunner).to receive(:perform_async).with(
          job_id, job_format_callee, [:new, :call], [[arg, arg2], []]
        )

        callee.run_this.new(arg, arg2).call.async
      end
    end

    context 'expected job id' do
      let(:job_id) { 'a certain expected job id' }

      it 'sets the job id' do
        expect(RunThisAsync::AsyncRunner).to receive(:perform_async).with(
          job_id, job_format_callee, [], []
        )

        callee.run_this(job_id).async
      end
    end
  end

  context 'class callee' do
    let(:job_format_callee) { callee.to_s }
    let(:callee) { Object }

    it_behaves_like 'scheduler'
  end

  context 'object callee (bad idea to pass an object to a job, but works)' do
    let(:job_format_callee) { callee }
    let(:callee) { Object.new }

    it_behaves_like 'scheduler'
  end
end
