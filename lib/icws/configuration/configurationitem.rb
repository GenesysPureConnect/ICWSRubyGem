require 'icws/connection'
require 'icws/icwsclient'

class ICWS
  class Configuration
    class ConfigurationItem
      protected
      def initialize(connection, class_name)
        @class_name = class_name
        @uri = '/configuration/'+ @class_name
        @client = ICWS::Client.new connection
      end
      
      public  
      # Gets the configuration item with the specified id.
      # @param id [String] ID of the configuration item.
      # @param fields [String] Comma ',' deliminated string of fields to return.  Check the ICWS documentation for the available fields.
      # @return [Object] The configuration item. 
      def get(id, fields="configurationId")
        @client.get(@uri + '/' + id + '?select='+ fields)
      end
      
      # Deletes the configuration item with the specified id.
      # @param id [String] ID of the configuration item.
      def delete(id)
        @client.delete @uri + '/' + id
      end
      
      # Gets all of the configured items.
      # @param fields [String] comma-delimitedstring of fields to return.  Check the ICWS documentation for the available fields.
      # @param where [String] A comma-delimited list of conditions to apply to the query. Only items that satisfy all conditions will be returned. The following operators can be used: eq - equals, sw - starts with, ct - contains Example: where=configurationId.id sw St
      # @param order_by [String] The name of the field to sort the results by. The default is to sort by configurationId.id in ascending order. A query can only be sorted by one field.  To order in descending order use: orderBy=configurationId.id desc
      # @param rights_filter [String] A comma-delimited list of conditions to apply to the query. Only items that satisfy all conditions will be returned. The following operators can be used: eq - equals, sw - starts with, ct - contains Example: where=configurationId.id sw St
      # @return [Array[Hash]] The configuration items. 
      def get_all(fields="configurationId", where=nil, order_by="configurationId.id", rights_filter="admin")
        
        query_string =  '?select='+ fields + '&orderBy=' + order_by +'rightsFilter=' + rights_filter
        if where != nil
          query_string += "&where=" + where
        end
        
        @client.get(@uri + query_string)["items"]
      end
      
      # Creates a new configuration item.
      # @param id [String] Id of the new item.
      # @param new_item [Hash] Object with the configuration properties of the new item.  See ICWS documentation for the valid properties.
      def create_new(id, new_item)
        if new_item['configurationId'].nil?
          config_id = {}
          config_id['id'] = id
          config_id['displayName'] = id
          new_item['configurationId'] = config_id
        end
        
        @client.post @uri, new_item
      end
      
      # Updates an existing configuration item.
      # @param id [String] Id of the item.
      # @param new_item [Hash] Object with the configuration properties of the new item.  See ICWS documentation for the valid properties.
      def update(id, configuration_item)
        if configuration_item['configurationId'].nil?
          config_id = {}
          config_id['id'] = id
          config_id['displayName'] = id
          new_item['configurationId'] = config_id
        end
        
        @client.put @uri + '/' + id, configuration_item
      end
      
      # Gets the default values for the configuration item.
      def defaults
        @client.get '/configuration/defaults/' + @class_name.chomp('s')
      end
    end
  end
end