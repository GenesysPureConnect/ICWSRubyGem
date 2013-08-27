require 'Date'

class ICWS
  class Status
    class UserStatus
      attr_reader :user_id
      attr_reader :status_id
      attr_reader :status_changed #"=>"20130808T211625Z", 
      attr_reader :notes
      attr_reader :ic_servers
      attr_reader :stations
      attr_reader :logged_in
      attr_reader :on_phone
      attr_reader :on_phone_changed
      
      def initialize(property_map)
        @status_id = property_map['statusId']
        @user_id = property_map['userId']
        @notes = property_map['notes']
        @ic_servers = property_map['icServers']
        @stations = property_map['stations']
        @logged_in = property_map['loggedIn']
        @on_phone = property_map['onPhone']
        @status_changed = DateTime.parse property_map['statusChanged']
        @system_id   = DateTime.parse property_map['onPhoneChanged']
      end
      
      def to_s
        @user_id + ' - ' + @status_id 
      end
    end
  end
end