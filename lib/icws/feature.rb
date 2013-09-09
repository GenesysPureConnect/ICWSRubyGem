class ICWS
  class Connection
    class Feature
      attr_accessor :feature, :version

      def initialize(feature, version)
        @feature = feature
        @version = version
      end
      
      def to_s
        @feature + ' - ' + @version.to_s
      end
    end
  end
end