require '.icws/messages/messagesubscriber.rb'

class ICWS
  class ChallangeMessageHandler < MessageSubscriber
    def initialize(connection, message_queue)
      super(connection, message_queue,'urn:inin.com:messaging:message6')
    end
    def event_received(message)
      nonce = message['value']
      
      response_arr = Array.new(nonce.length)
      
      for i in 0..nonce.length do
          response_arr[2*i] = nonce[i]
          response_arr[2*i+1] = @application_name[i % @application_name.length]
      end
      
      response = {}
      response['_'] = response_arr.join
      
      @client.post '/messaging/m', response

    end
  end
end