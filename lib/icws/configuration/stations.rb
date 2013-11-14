require 'icws/configuration/configurationitem'

class ICWS
  class Configuration
    class Stations < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'stations')
      end
    end
  end
end