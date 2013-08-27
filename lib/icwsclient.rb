require 'rest_client'
require 'rubygems'
require 'json'

class ICWS
  class Client
    def initialize(connection)
      @connection = connection
      headers = {:Cookie => @connection.cookie,"ININ-ICWS-CSRF-Token" => @connection.token}
      @http_resource = RestClient::Resource.new(@connection.base_uri, :headers => headers)
    end
    
    def post(url, body, headers={})
      begin
        JSON.parse @http_resource[url].post body.to_json, headers
      rescue => e
        puts e.inspect
        throw e
      end
    end
    
    def get(url, headers={})
      JSON.parse @http_resource[url].get headers 
    end
    
    def delete(url, headers={})
      @http_resource[url].delete headers
    end
    
    def put(url, body, headers={})
      begin
      @http_resource[url].put body.to_json, headers
      rescue => e
        puts e.inspect
        throw e
      end
        
    end
  end
end
