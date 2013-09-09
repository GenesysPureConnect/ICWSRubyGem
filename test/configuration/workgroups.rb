require 'test_constants'
require 'test/unit'

require 'rubygems'
require 'icws/connection'
require 'icws/configuration/workgroups'
require 'securerandom'

class WorkgroupTest < Test::Unit::TestCase
=begin
  def test_create_new_get_update_and_delete
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    workgroupconfig = ICWS::Configuration::Workgroups.new connection
    
    id = SecureRandom.uuid;
    ext = Random.new.rand(20000..90000)
    
    newworkgroup = {}
    newworkgroup["extension"] = ext
    newworkgroup['homeSite'] = 1
    
    workgroupconfig.create_new id, newworkgroup
    
    workgroup = workgroupconfig.get id, "configurationId,extension"
    assert_not_nil workgroup
    
    assert workgroup["extension"].to_i == ext
    
    ext = ext + 1
    workgroup["extension"] = ext
    workgroupconfig.update(id,workgroup)
    
    workgroup = workgroupconfig.get id, "configurationId,extension"
    assert workgroup["extension"].to_i == ext
    
    workgroupconfig.delete id
    assert_raise RestClient::ResourceNotFound do
      workgroup = workgroupconfig.get id
    end
    
  end
=end
  def test_get_all
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    workgroupconfig = ICWS::Configuration::Workgroups.new connection
    assert_not_nil workgroupconfig
    
    allworkgroups = workgroupconfig.get_all
    
    assert_not_nil allworkgroups
    assert allworkgroups.length > 0
    assert_not_nil allworkgroups[0]["configurationId"]
  end
  
  def test_get_all_custom_attributes
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    workgroupconfig = ICWS::Configuration::Workgroups.new connection
    assert_not_nil workgroupconfig
    
    allworkgroups = workgroupconfig.get_all "configurationId,extension"
    
    assert_not_nil allworkgroups
    assert allworkgroups.length > 0
    assert_not_nil allworkgroups[0]["configurationId"]
    assert allworkgroups[0].has_key? "extension"
    assert allworkgroups[0].has_key?("foo") == false
  end
  
  def test_defaults
    connection = ICWS::Connection.new APPLICATIONNAME, SERVER
    connection.connect USERID, PASSWORD
    workgroupconfig = ICWS::Configuration::Workgroups.new connection
    assert_not_nil workgroupconfig
    assert_not_nil workgroupconfig.defaults
  end

end
