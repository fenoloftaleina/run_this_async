module RunThisAsync::Callee
  class Decoder
    include Concord.new(:callee)
    include Procto.call

    def call
      if callee.is_a?(String)
        return Object.const_get(callee)
      end

      callee
    end
  end
end
