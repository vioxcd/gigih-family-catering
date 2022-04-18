# quickstart.rb

require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '5s' do
  Order.find_each do |order|
    if order.NEW?
      puts order.id + " " + order.status
    end
  end
end

# scheduler.in '10s' do
#   puts 'Hello... Rufus'
# end

scheduler.cron '0 17 * * *' do
  Order.find_each do |order|
    if order.NEW?
      puts order.id + " " + order.status
    end
  end
  # do something every day, five minutes after midnight
  # (see "man 5 crontab" in your terminal)
end


scheduler.join
  #
  # let the current thread join the scheduler thread
  #
  # (please note that this join should be removed when scheduling
  # in a web application (Rails and friends) initializer)