require '..\lib\configuration\configurationitem.rb'

class ICWS
  class Configuration
    class Workgroups < ICWS::Configuration::ConfigurationItem
      def initialize(connection)
        super(connection,'workgroups')
      end
    end
  end
end