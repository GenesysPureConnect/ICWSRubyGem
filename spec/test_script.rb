require '../lib/connection.rb'
require '../lib/messages/messagequeue.rb'
require '../lib/statistics/statistics.rb'
require '../lib/status/status.rb'
require '../lib/configuration/users.rb'
require '../lib/configuration/workgroups.rb'
require '../lib/INTERNAL/challangemessagehandler.rb'


def colorize(text, color_code)
  #"\e[#{color_code}m#{text}\e[0m"
  puts text
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end

# Actual example
red 'Importing categories'
green 'Importing tags'


connection = ICWS::Connection.new 'SalesforceProvisionService', 'http://Aeolus:8018'
#connection = ICWS::Connection.new 'SalesforceProvisionService', 'http://morbo.dev2000.com:8018'

puts connection.version.inspect
puts connection.features.inspect

userId = 'aeolus_user'
#userId = 'kevin.glinski'

begin
connection.connect userId, '1234'

puts connection.version
rescue => e
  puts e.inspect
end


users = ICWS::Configuration::Users.new (connection)

puts users.get userId, 'defaultWorkStation'


def status_test(connection, userId)
  status = ICWS::Status.new connection
  statuses = status.all_system_statuses
  puts status.get_user_status userId
  status.set_user_status userId, statuses[3].statusId
  puts status.get_user_status userId
  status.set_user_status userId, statuses[4].statusId

  puts status.allowable_statuses userId
end

def configuration_test (connection)
    workgroups = ICWS::Configuration::Workgroups.new(connection)
    puts workgroups.get_all
    workgroup = {}
    workgroup[:configurationId] = {}
    workgroup[:configurationId][:id] = 'KPG'
    workgroup[:configurationId][:displayName] = 'KPG'
    workgroups.create_new workgroup
    puts workgroups.get 'KPG', 'configurationId'
    workgroup[:notes] = 'test notes'
    workgroups.update 'KPG', workgroup
    puts workgroups.get 'KPG', 'notes'

    workgroups.delete 'KPG'
    puts workgroups.get_all
end

#status_test(connection,userId)

queue = ICWS::MessageQueue.new(connection)
challangeHandler = ICWS::ChallangeMessageHandler.new(connection, queue)

stats = ICWS::Statistics.new(connection, queue)
stats.statistic_catalog

#configuration_test connection
puts 'hit enter to exit'

gets
