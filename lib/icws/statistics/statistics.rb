require '..\lib\messages\messagesubscriber.rb'
require '..\lib\statistics\statisticcategory.rb'

class ICWS
    #Subscribes to Statistics from CIC
    class Statistics < MessageSubscriber
        #Hash of Statistics catalogs
        attr_reader :statistic_catalog

        #Constructor which sets up a new watcher on the statistics catalog
        def initialize(connection, message_queue)
            super(connection, message_queue,'urn:inin.com:statistics:statisticCatalogMessage')
            @client = ICWS::Client.new connection
            @client.put '/messaging/subscriptions/statistics/statistic-catalog', {}

        end

        #block for when a new stat catalog message comes in
        def event_received(message)
            if message['__type'] == 'urn:inin.com:statistics:statisticCatalogMessage'
                @statistic_catalog = []
                message['statisticCategoryList'].each {|s| @statistic_catalog.push ICWS::StatisticCategory.new(s)}

            end
        end

    end
end
