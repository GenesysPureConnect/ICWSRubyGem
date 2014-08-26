require 'icws/configuration/configurationitem'

class ICWS
  class Configuration
      # Represents the stations configuration in CIC.  This class can perform operations to create/edit/delete stations.

    class Stations < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'stations')
      end
    end
  end
end
