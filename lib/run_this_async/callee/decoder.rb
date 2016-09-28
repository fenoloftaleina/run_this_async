module RunThisAsync::Callee
  class Decoder
    include Concord.new(:callee)
    include Procto.call

    def call
      if callee.instance_of?(String)
        return Object.const_get(callee)
      end

      callee
    end
  end
end
