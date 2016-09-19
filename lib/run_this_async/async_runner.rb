require 'sidekiq'
require 'run_this_async/callee/decoder'

class RunThisAsync::AsyncRunner
  include ::Sidekiq::Worker

  def perform(expected_job_id, callee, method, args = nil)
    return if unexpected_job_id?(expected_job_id)

    callee = RunThisAsync::Callee::Decoder.call(callee)

    if method.is_a?(Array)
      send_chain_of_methods(callee, method, args)
    else
      send_method_to_callee(callee, method, args)
    end
  end

  private
  def send_method_to_callee(callee, method, args)
    callee.send(method, *args)
  end

  def send_chain_of_methods(callee, methods, arrays_of_args)
    return callee if methods.empty?

    send_chain_of_methods(
      callee.send(methods.shift, *arrays_of_args.shift),
      methods,
      arrays_of_args
    )
  end

  def unexpected_job_id?(expected_job_id)
    expected_job_id && expected_job_id != jid
  end
end
