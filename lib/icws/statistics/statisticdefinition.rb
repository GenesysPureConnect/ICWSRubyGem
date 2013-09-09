
class ICWS
    class StatisticDefinition
      attr_reader :statistic_identifier
      attr_reader :display_string
      attr_reader :description
      attr_reader :units_display
      
      def initialize(propertyMap)
        @statistic_identifier = propertyMap['statisticIdentifier']
        @display_string = propertyMap['displayString']
        @description = propertyMap['description']
        @units_display = propertyMap['unitsDisplay']
      end
      
      def to_s
        '   ' + @display_string + '(' + @statistic_identifier + ')' 
      end
  end
end