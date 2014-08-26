require '..\lib\statistics\statisticdefinition.rb'

class ICWS
    #Defines a category for supervisor statistics
    class StatisticCategory
        #Category Id
        attr_reader :statistic_category_id
        #Category display string
        attr_reader :display_string
        #Category Description
        attr_reader :description
        #List of StatisticDefinition
        attr_reader :statistic_definitions

        #Creates a new Statistic category.
        # @param propertyMap [Hash] Map or properties that define the statistic.
        def initialize(propertyMap)
            @statistic_category_id = propertyMap['statisticCategoryId']
            @display_string = propertyMap['displayString']
            @description = propertyMap['description']
            @statistic_definitions = []
            propertyMap['statisticDefinitions'].each {|s| @statistic_definitions.push ICWS::StatisticDefinition.new(s)}
        end

        #String reporesentation - DisplayString (Category Id)
        def to_s
            @display_string + '(' + @statistic_category_id + ')'
        end
    end
end
