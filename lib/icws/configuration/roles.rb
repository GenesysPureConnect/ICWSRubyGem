require 'icws/configuration/configurationitem'

class ICWS
  class Configuration
      # Represents the roles configuration in CIC.  This class can perform operations to create/edit/delete roles.

    class Roles < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'roles')
      end
    end
  end
end
