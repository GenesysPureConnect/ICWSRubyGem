[![Gem Version](https://badge.fury.io/rb/icws.svg)](http://badge.fury.io/rb/icws)
[![Build Status](https://travis-ci.org/InteractiveIntelligence/ICWSRubyGem.svg)](https://travis-ci.org/InteractiveIntelligence/ICWSRubyGem)
A gem that wraps up the ICWS ReST api

Examples
==============

Making a Connection

``` ruby
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
```

Deleting a user:
``` ruby
    def delete_user(id, connection)
        user_config = ICWS::Configuration::Users.new connection
        user_config.delete URI.escape id
    end
```

Create a Workgroup:

``` ruby
  def setup_workgroup(workgroup_name, extension, connection)
    workgroup_config = ICWS::Configuration::Workgroups.new connection
    workgroups = workgroup_config.get_all.select {|r| r['configurationId']['id'] == workgroup_name}

    workgroupId = workgroup_name

    if(workgroups.length ==0)
      new_workgroup = {
        :queueType => 5,
        :hasQueue => true,
        :isActive => true,
        :extension => extension
      }

      workgroup_config.create_new workgroupId, new_workgroup
    end
  end
```

Set a User's Status

``` ruby
    status = ICWS::Status.new connection
    status.set_user_status URI.escape(id), 'AVAILABLE'
```
