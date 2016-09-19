module RunThisAsync::Callee
  class Encoder
    include Concord.new(:callee)
    include Procto.call

    def call
      if callee.is_a?(Class)
        return callee.to_s
      end

      callee
    end
  end
end
