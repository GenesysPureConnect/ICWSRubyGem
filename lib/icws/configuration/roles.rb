require 'icws/configuration/configurationitem'

class ICWS
  class Configuration
    class Roles < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'roles')
      end
    end
  end
end