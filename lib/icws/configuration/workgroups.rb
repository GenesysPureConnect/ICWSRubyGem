require 'icws/configuration/configurationitem'

class ICWS
    class Configuration
        # Represents the workgroups configuration in CIC.  This class can perform operations to create/edit/delete Workgroups.
        class Workgroups < ICWS::Configuration::ConfigurationItem
            def initialize(connection)
                super(connection,'workgroups')
            end
        end
    end
end
