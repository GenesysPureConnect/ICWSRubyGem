require 'icws/status/statusmessage'
require 'icws/status/userstatus'

class ICWS
    #Status message handler
    class Status
        #Creates a new instance
        def initialize(connection)
            @client = ICWS::Client.new connection
        end
        #Retreives all the statuses configured in the system
        # @return [Array[StatusMessage]] The status messages.
        def all_system_statuses
            status_list = @client.get '/status/status-messages'
            statuses = []
            status_list['statusMessageList'].each {|s| statuses.push ICWS::StatusMessage.new(s)}
            return statuses
        end

        #Retreives all the statuses for a given user.
        # @param user_id [String] The user Id
        # @return [Array[StatusMessage]] The status messages.
        def allowable_statuses (user_id)
            status = @client.get '/status/status-messages-user-access/' + user_id
            status['statusMessages']
        end

        #Retreives the current status for a given user.
        # @param user_id [String] The user Id
        # @return [StatusMessage] The user's status.
        def get_user_status(user_id)
            status = @client.get '/status/user-statuses/' + user_id
            ICWS::Status::UserStatus.new(status )
        end

        #Sets the current status for a given user.
        # @param user_id [String] The user Id
        # @param status_id [String] The Id of the status to set to.
        def set_user_status(user_id, status_id)
            status_data = {}
            status_data[:statusId] = status_id

            @client.put '/status/user-statuses/' + user_id, status_data
        end
    end
end
