require 'run_this_async/version'
require 'concord'
require 'procto'
require 'run_this_async/async_runner'
require 'run_this_async/callee/encoder'

module Kernel
  def run_this(expected_job_id = nil)
    RunThisAsync::AsyncPlan.new(self, expected_job_id)
  end
end

module RunThisAsync
  class AsyncPlan < BasicObject
    def initialize(callee, expected_job_id)
      @callee = ::RunThisAsync::Callee::Encoder.call(callee)
      @expected_job_id = expected_job_id
      @methods_to_call = []
      @with_args = []
    end

    def async
      ::RunThisAsync::AsyncRunner.perform_async(
        @expected_job_id, @callee, @methods_to_call, @with_args
      )
    end

    def method_missing(name, *args)
      @methods_to_call << name
      @with_args << args

      self
    end
  end
end
