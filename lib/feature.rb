class ICWS
  class Connection
    class Feature
      attr_accessor :feature, :version

      def initialize(feature, version)
        @feature = feature
        @version = version
      end
    end
  end
end
