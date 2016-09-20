module RunThisAsync::Callee
  class Decoder
    include Concord.new(:callee)
    include Procto.call

    def call
      if callee.instance_of?(String)
        return class_from_string
      elsif callee.instance_of?(RunThisAsync::ActiveRecordPointer)
        return activerecord_model
      end

      callee
    end

    private
    def class_from_string
      Object.const_get(callee)
    end

    def activerecord_model
      callee.klass.find_by(id: callee.id)
    end
  end
end
