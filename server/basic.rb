# basic.rb
require 'sinatra'
require 'timezone'


get '/' do
    erb:textField
end
post '/city' do
	timezones = Timezone::Zone.names
	input_timezone = ""
	input_city = params[:message].split.map(&:capitalize).join('_')
	timezones.each do |s|
		if s.include? input_city
			input_timezone = s
		end
	end
	
	begin
		timezone = Timezone::Zone.new :zone => input_timezone
		t =timezone.time Time.now
		time = t.to_s.split[1]
		hour = time[0..1]
		hour_med = am_pm(time)
		display_time = "<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp"+hour_med
		output = "The current time in #{params[:message].split.map(&:capitalize).join(' ')} is :"+display_time
		"#{output}"
	rescue
		"Can not find the city \"#{params[:message].split.map(&:capitalize).join(' ')}\""
	end
	

end

def am_pm(input_time)
	hour = input_time.split(':')[0].to_i
	min = input_time.split(':')[1]
  	meridian = (hour >= 12) ? 'PM' : 'AM'
 	hour = case hour
 		when 0
 			12
      	when 13 .. 23
        	hour - 12
       	else
       	   	hour
       	end

 	 "#{ hour }:#{ min } #{ meridian }"
end
not_found do
  halt 404, 'Page Not Found'
end