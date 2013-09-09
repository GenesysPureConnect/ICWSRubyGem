require 'icws/configuration/configurationitem'

class ICWS
  class Configuration
    class Workgroups < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'workgroups')
      end
    end
  end
end