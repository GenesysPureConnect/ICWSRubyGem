class ICWS
  class StatusMessage
    attr_reader :status_id
    attr_reader :message_text
    attr_reader :icon_uri
    attr_reader :group_tag
    attr_reader :can_have_date
    attr_reader :can_have_time
    attr_reader :is_do_not_disturb_status
    attr_reader :is_selectable_status
    attr_reader :is_persistent_status
    attr_reader :is_forward_status
    attr_reader :is_after_call_work_status
    attr_reader :is_acd_status
    attr_reader :is_allow_follow_up_status
    attr_reader :system_id
    
    def initialize(property_map)
      @status_id = property_map['statusId']
      @message_text = property_map['messageText']
      @icon_uri = property_map['iconUri']
      @group_tag = property_map['groupTag']
      @can_have_date = property_map['canHaveDate']
      @can_have_time = property_map['canHaveTime']
      @is_do_not_disturb_status = property_map['isDoNotDisturbStatus']
      @is_selectable_status = property_map['isSelectableStatus']
      @is_fersistent_status = property_map['isPersistentStatus']
      @is_forward_status = property_map['isForwardStatus']
      @is_after_call_work_status = property_map['isAfterCallWorkStatus']
      @is_acd_status = property_map['isAcdStatus']
      @is_allow_follow_up_status = property_map['isAllowFollowUpStatus']
      @system_id   = property_map['systemId']
    end
    
    def to_s
      status_id + ', ' + message_text + ',' + icon_uri 
    end
  end
end


