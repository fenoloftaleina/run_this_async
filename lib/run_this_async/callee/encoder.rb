module RunThisAsync::Callee
  class Encoder
    include Concord.new(:callee)
    include Procto.call

    def call
      if callee.is_a?(Class)
        return stringified_class
      elsif callee.is_a?(ActiveRecord::Base)
        return activerecord_pointer
      end

      callee
    end

    private
    def stringified_class
      callee.to_s
    end

    def activerecord_pointer
      RunThisAsync::ActiveRecordPointer.new(callee.class, callee.id)
    end
  end
end
