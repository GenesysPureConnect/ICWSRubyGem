require '..\lib\connection.rb'
require '..\lib\icwsclient.rb'

class ICWS
  class Configuration
    class ConfigurationItem
      protected
      def initialize(connection, class_name)
        @uri = '/configuration/'+ class_name
        @client = ICWS::Client.new connection
      end
      
      public  
      def get(id, fields="configurationId")
        @client.get(@uri + '/' + id + '?select='+ fields) 
      end
      
      def delete(id)
        @client.delete @uri + '/' + id
      end
      
      def get_all(fields="configurationId")
        @client.get @uri + '?select='+ fields
      end
      
      def create_new(new_item)
        @client.post @uri, new_item
      end
      
      def update(id, configuration_item)
        @client.put @uri + '/' + id, configuration_item
      end
    end
  end
end