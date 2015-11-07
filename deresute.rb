# coding: utf-8
require 'twitter'

last_d = '15-10-27-21:00:00 '
last = Time.local(2015, 10, 27, 21, 00, 00)
now = Time.now
d = last - now
d = d /60
d = d /15

tan = []
max = []
y = []

user_id = 'deresute_border'
since_id = 0

client = Twitter::REST::Client.new(
  consumer_key: 'zQwok9eRhbIXYawPFPCna2OUG',
  consumer_secret: '9jsRw9bY5IMS6EtMbtByUjuGUhF4juQI4g3LwdE2WvnIka702P',
)

tweet = client.user_timeline(user_id, count: 1000)
count = 0

begin
  File.open('deresute_border.txt', 'w') do |io|
    tweet.reverse_each do |tw|
      count += 1
      since_id = "#{tw.id}"
      text = "#{tw.text}"
      time = Time.at(((Integer(since_id)>>22) + 1288834974657 ) / 1000.0 )
      border = text.split("\n")
      time = time.strftime("%y-%m-%d-%H:%M:%S ")

      io.print time
      for n in 1..5 do
        border[n].gsub!(/^[0-9千万位]+./, '')
        border[n].gsub!(/.[0-9\+]+.$/, '')
        io.print border[n]
        io.print " "
        if y[n-1].to_i < border[n].to_i
          y[n-1] = border[n]
        end
      end
      io.puts ""

      for n in 1..5 do
        if count > 1
          if (max[n-1].to_i < border[n].to_i - tan[n-1].to_i)
            max[n-1] = border[n].to_i - tan[n-1].to_i
          end
        end
        tan[n-1] = border[n]
      end
    end
    io.print last_d
    for n in 1..5 do
      temp = max[n-1].to_i * d.to_i
      temp += y[n-1].to_i
      p temp
      io.print temp.to_s
      io.print " "
    end
    io.puts ""
  end
end

