require 'test_constants'
require 'minitest/autorun'

require 'rubygems'
require 'icws/connection'
require 'icws/status/status.rb'

class StatusTest <  MiniTest::Unit::TestCase

  def test_get_all_system_statuses
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD

    status = ICWS::Status.new connection
    assert status != nil

    systemStatuses = status.all_system_statuses

    assert systemStatuses != nil
    assert systemStatuses.length > 0
  end

  def test_get_allowable_statuses
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD

    status = ICWS::Status.new connection
    assert status != nil

    systemStatuses = status.allowable_statuses USERID

    assert systemStatuses != nil
    assert systemStatuses.length > 0
  end



  def test_get_user_status
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD

    status = ICWS::Status.new connection
    assert status != nil

    userStatus = status.get_user_status USERID

    assert userStatus != nil
  end

end
