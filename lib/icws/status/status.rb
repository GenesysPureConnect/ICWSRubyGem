require 'icws/status/statusmessage'
require 'icws/status/userstatus'

class ICWS
  class ICWS::Status
    
    def initialize(connection)
      @client = ICWS::Client.new connection 
    end
    
    def all_system_statuses
      status_list = @client.get '/status/status-messages'
      statuses = []
      status_list['statusMessageList'].each {|s| statuses.push ICWS::StatusMessage.new(s)}
      return statuses
    end
    
    def allowable_statuses (user_id)
      status = @client.get '/status/status-messages-user-access/' + user_id
      status['statusMessages']
    end
    
    def get_user_status(user_id)
      status = @client.get '/status/user-statuses/' + user_id
      ICWS::Status::UserStatus.new(status )
    end
    
    def set_user_status(user_id, status_id)
      status_data = {}
      status_data[:statusId] = status_id
      
      @client.put '/status/user-statuses/' + user_id, status_data
    end
  end
end