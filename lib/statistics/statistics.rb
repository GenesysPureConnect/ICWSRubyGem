require '..\lib\messages\messagesubscriber.rb'
require '..\lib\statistics\statisticcategory.rb'

class ICWS
  class Statistics < MessageSubscriber
    attr_reader :statistic_catalog
    
    def initialize(connection, message_queue)
      super(connection, message_queue,'urn:inin.com:statistics:statisticCatalogMessage')
      @client = ICWS::Client.new connection
      @client.put '/messaging/subscriptions/statistics/statistic-catalog', {}
      
    end
    
    def event_received(message)
      if message['__type'] == 'urn:inin.com:statistics:statisticCatalogMessage'
        @statistic_catalog = []
        message['statisticCategoryList'].each {|s| @statistic_catalog.push ICWS::StatisticCategory.new(s)}
        
      end
    end
    
  end
end