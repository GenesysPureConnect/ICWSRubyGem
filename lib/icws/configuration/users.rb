require 'icws/configuration/configurationitem'

class ICWS
  class Configuration
    class Users < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'users')
      end
    end
  end
end