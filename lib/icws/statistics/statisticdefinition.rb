
class ICWS
    #Definition of a supervisor statistic
    class StatisticDefinition
        #ID of the statistic
        attr_reader :statistic_identifier
        #Display String of the statistic
        attr_reader :display_string
        #Description of the statistic
        attr_reader :description
        #Statistic Units
        attr_reader :units_display

        #Creates a new Statistic category.
        # @param propertyMap [Hash] Map or properties that define the statistic.
        def initialize(propertyMap)
            @statistic_identifier = propertyMap['statisticIdentifier']
            @display_string = propertyMap['displayString']
            @description = propertyMap['description']
            @units_display = propertyMap['unitsDisplay']
        end

        #String reporesentation - DisplayString (Stat Id)
        def to_s
            '   ' + @display_string + '(' + @statistic_identifier + ')'
        end
    end
end
