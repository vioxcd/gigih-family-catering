require 'rufus-scheduler'

# Prevent scheduler to run when running in rails console
return if defined?(Rails::Console) || Rails.env.test? || File.split($PROGRAM_NAME).last == 'rake'

s = Rufus::Scheduler.singleton

# Change NEW status to CANCELED every 5pm
s.cron '0 17 * * *' do
  orders = Order.where(status: :NEW)  
  puts orders.size.to_s + " orders cancelled"
  
  orders.update_all(status: :CANCELED)
end

# Testing
# s.in '1s' do
#   orders = Order.where(status: :NEW) 
#   puts orders.size.to_s + " orders cancelled"
  
#   orders.update_all(status: :CANCELED)
# end

# Comment or Delete this function if you dont wanna print time in console 
# s.every '10s' do
#   Rails.logger.info "hello, it's #{Time.now}"
#   Rails.logger.flush
# end

# s.cron '57 16 * * *' do
#   orders = Order.where(status: :CANCELED)
#   orders.update_all(status: :NEW)
#   puts "#{orders.size} orders was canceled at #{Time.now}"
# end