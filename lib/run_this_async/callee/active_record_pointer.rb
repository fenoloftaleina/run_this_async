module ActiveRecord
  class Base; end
end

module RunThisAsync
  class ActiveRecordPointer < Struct.new(:klass, :id); end
end
