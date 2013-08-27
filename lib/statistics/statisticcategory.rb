require '..\lib\statistics\statisticdefinition.rb'

class ICWS
    class StatisticCategory
      attr_reader :statistic_category_id
      attr_reader :display_string
      attr_reader :description
      attr_reader :statistic_definitions
      
      def initialize(propertyMap)
        @statistic_category_id = propertyMap['statisticCategoryId']
        @display_string = propertyMap['displayString']
        @description = propertyMap['description']
        @statistic_definitions = []
        propertyMap['statisticDefinitions'].each {|s| @statistic_definitions.push ICWS::StatisticDefinition.new(s)}
      end
      
      def to_s
        @display_string + '(' + @statistic_category_id + ')'
      end
  end
end