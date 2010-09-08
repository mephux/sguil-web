module Sguil
  class Parse
    
    def initialize(data)
      @data = data
    end
    
    def strip_brackets(data=nil)
      data = data ? @data : data.nil?
      (data[/\{(\S.+)\}/,1]).to_s
    end
    
    def new_snort_stats
      raw_data = strip_brackets
      split_data = strip_brackets(raw_data)
  
      split_data.to_s.split(/\} \{/).each do |insert|
        push('sensor', build_sensor_data(insert))
      end
    end
    
    def sensors
      @sensors = @data.to_s.gsub("SensorList", '').gsub(/\{|\}/, '').split(' ')
    end
    
  end
end


# def login(options={})
#   username = options[:username] || 'guest'
#   password = options[:password] || 'guest'
#   @socket.puts "ValidateUser #{username} #{password}"
# end
# 
# def sensor(sensors=nil)
#   @socket.puts "MonitorSensors {#{sensors}}" if sensors
# end
# 
# def sendmsg(msg)
#   @socket.puts("UserMessage {#{msg.strip}}")
# end
# 
# def connected?
#   @socket.puts 'PING'
#   return true if @socket.gets == 'PONG'
#   false
# end
# 
# def sensor_list
#   @socket.puts("SendSensorList")
# end
# 
# def kill!
#   @socket.close
#   exit -1
# end
# 
# def format_event
#   raw_event = data[/\{(\S.+)\}/,1]
#   datetime = raw_event[/\{(.+?)\}/,1]
#   sig_name = raw_data[/.+\{(.+?)\}/,1]
# end
# 
# def push(path,data,event_data=true)
#   RestClient.post("http://#{@client}/#{path}", data)
#   # Example
#   # UserMessage dwebber test
#   # InsertSystemInfoMsg sguild {User dwebber logged in from 3.60.32.96}
# end
# 
# def format_system_message(data)
#   sysmsg = data.to_s.gsub("InsertSystemInfoMsg", '').gsub(/\{|\}/, '').split(' ')
#   system_object = sysmsg.first
#   msg = []
#   sysmsg.each do |word|
#     next if system_object == word
#     msg << word
#   end
# 
#   system_message_hash = {:object => system_object,:msg => msg.join(' ')}
#   push('system_message',system_message_hash)
# end
# 
# def format_user_message(data)
#   usermsg = data.to_s.gsub("UserMessage", '').gsub(/\{|\}/, '').split(' ')
#   username = usermsg.first
#   msg = []
#   usermsg.each do |word|
#     next if username == word
#     msg << word
#   end
# 
#   user_msg = {:username => username,:msg => msg.join(' ')}
#   push('usermsg',user_msg)
# end
# 
# def format_snort_stats(data)
#   raw_data = (data[/\{(\S.+)\}/,1]).to_s
#   split_data = raw_data[/\{(\S.+)\}/,1]
# 
#   split_data.to_s.split(/\} \{/).each do |insert|
#     push('sensor', build_sensor_data(insert))
#   end
# 
# end
# 
# # UpdateSnortStats {586 CRPdgEUKlond020-edsc0 0.146 7.123 0.000 1.090 817 5.242 4.721 4.665 6667 {2010-08-27 19:35:37}}
# 
# def format_update_data(data)
#   insert_update = Hash.new
#   raw_data = data[/\{(\S.+)\}/,1]
#   datetime = raw_data[/\{(.+?)\}/,1]
#   data = raw_data.gsub(/\{(.+?)\}/, '').gsub('  ', ' ').split(' ')
# 
#   insert_update.merge!({
#                          :id => data[0],
#                          :name => data[1],
#                          :packet_loss => "#{data[2]}%",
#                          :avg_bw => "#{data[3]}MB/s",
#                          :alerts => "#{data[4]}/sec",
#                          :packets => "#{data[5]}/sec",
#                          :bytes => "#{data[6]}/pckt",
#                          :match => "#{data[7]}%",
#                          :new_ssns => "#{data[8]}/sec",
#                          :ttl_ssns => "#{data[9]}",
#                          :max_ssns => "#{data[10]}",
#                          :updated_at => datetime
#   })
#   insert_update if @verbose
#   insert_update
# end
# 
# def build_sensor_data(data)
#   sensor_data = Hash.new
#   datetime = data[/\{(.+?)\}/,1]
#   sig_name = data[/.+\{(.+?)\}/,1]
#   data = data.gsub(/\{(.+?)\}/, '').gsub('  ', ' ').split(' ')
# 
#   sensor_data.merge!({
#                        :id => data[0],
#                        :name => data[1],
#                        :packet_loss => "#{data[2]}%",
#                        :avg_bw => "#{data[3]}MB/s",
#                        :alerts => "#{data[4]}/sec",
#                        :packets => "#{data[5]}/sec",
#                        :bytes => "#{data[6]}/pckt",
#                        :match => "#{data[7]}%",
#                        :new_ssns => "#{data[8]}/sec",
#                        :ttl_ssns => "#{data[9]}",
#                        :max_ssns => "#{data[10]}",
#                        :updated_at => datetime
#   })
#   sensor_data
# end
# 
# def format_event_data(data)
#   insert_event = Hash.new
#   raw_data = data[/\{(\S.+)\}/,1]
#   datetime = raw_data[/\{(.+?)\}/,1]
#   sig_name = raw_data[/.+\{(.+?)\}/,1]
#   data = raw_data.gsub(/\{(.+?)\}/, '').gsub('  ', ' ').split(' ')
# 
#   insert_event.merge!({
#                         :priority => data[1],
#                         :sensor => data[3],
#                         :sensor_id => data[4],
#                         :event_id => data[5],
#                         :signature => sig_name,
#                         :source_ip => data[6],
#                         :source_port => data[9],
#                         :destination_ip => data[7],
#                         :destination_port => data[10],
#                         :generator_id => data[13],
#                         :signature_id => data[11],
#                         :signature_reference => data[15],
#                         :created_at => datetime,
#   })
#   pp insert_event
#   insert_event
# end
# 
# end
# 
# INSERTDATA = %{
# InsertEvent {0 1 unknown demo {2010-09-07 20:47:24} 1 1 {SHELLCODE sparc NOOP} 61.219.90.180 192.168.100.28 6 56711 6112 1 645 5 1 1 1}
# InsertEvent {0 3 unknown demo {2010-09-07 20:58:08} 1 2 {ICMP Destination Unreachable Port Unreachable} 148.244.153.69 192.168.100.28 1 {} {} 1 402 7 2 2 2}
# InsertEvent {0 3 unknown demo {2010-09-07 21:04:57} 1 4 {FTP format string attempt} 192.168.100.28 192.18.99.122 6 32791 21 1 2417 2 4 4 2}
# InsertEvent {0 2 unknown demo {2010-09-07 21:10:54} 1 6 {DDOS Stacheldraht agent->handler skillz} 192.168.100.28 217.116.38.10 1 {} {} 1 1855 7 8 8 20}
# InsertEvent {0 3 unknown demo {2010-09-07 21:10:54} 1 7 {ICMP Echo Reply} 192.168.100.28 217.116.38.10 1 {} {} 1 408 5 9 9 20}
# InsertEvent {0 2 unknown demo {2010-09-07 21:30:50} 1 46 {WEB-MISC robots.txt access} 207.46.13.51 10.1.1.4 6 34251 80 1 1852 3 48 48 1}
# InsertEvent {0 2 unknown demo {2010-09-07 21:32:59} 1 47 {WEB-MISC robots.txt access} 207.46.199.185 10.1.1.4 6 43963 80 1 1852 3 49 49 1}
# InsertEvent {0 2 unknown demo {2010-09-07 21:51:59} 1 48 {WEB-MISC /doc/ access} 207.46.13.51 10.1.1.4 6 47780 80 1 1560 6 50 50 1}
# InsertEvent {0 2 unknown demo {2010-09-08 00:34:27} 1 49 {ATTACK-RESPONSES 403 Forbidden} 10.1.1.4 216.118.158.184 6 80 52851 1 1201 7 51 51 1}
# }
# 
# EXAMPLEDATA = "NewSnortStats {{519 CRPdgEPLgdan002-bridge1 0.000 0.001 0.000 0.001 78 19.537 0.004 0.003 49 {2010-08-30 13:05:46}} {9 CRPdgSCNshang10-bridge0 0.076 3.270 0.000 0.760 537 96.820 9.059 8.848 6576 {2010-08-30 13:26:39}} {11 CRPdgSCNshang11-bridge0 0.003 3.275 0.000 0.780 524 20.750 8.936 9.341 4634 {2010-08-30 13:25:45}} {115 CRPdgSSGsinga10-bridge0 0.000 5.465 0.007 1.505 454 67.586 28.996 26.190 5961 {2010-08-30 13:28:09}} {13 CRPdgSCNshang12-bridge0 0.004 5.544 0.000 1.398 495 55.607 18.197 17.681 5466 {2010-08-30 13:23:29}} {447 CRPdgECZchod001-bridge0 0.383 15.796 0.743 3.842 513 18.358 115.342 115.555 7645 {2010-08-30 13:25:34}} {118 CRPdgSSGsinga11-bridge0 0.027 22.158 0.000 5.617 493 74.139 20.100 20.027 6601 {2010-08-30 13:26:56}} {218 CRPdgSCNshang13-bridge0 0.019 3.328 0.000 0.700 594 34.122 10.305 10.563 6565 {2010-08-30 13:28:12}} {450 CRPdgECZchod001-bridge1 0.057 7.270 0.000 1.710 531 23.913 39.863 39.713 7174 {2010-08-30 13:26:42}} {556 CRPdgMUSbever01-bridge0 0.006 8.216 0.000 1.618 634 22.933 13.860 13.915 5662 {2010-08-30 13:23:34}} {42 CRPdgMUSstamf20-bridge0 0.000 0.010 0.000 0.010 124 60.570 0.262 0.238 6780 {2009-11-08 20:31:45}} {401 CRPdgMUSminde01-bridge0 0.000 0.148 0.000 0.052 352 45.052 1.965 1.962 6762 {2010-08-30 13:26:38}} {248 CRPdgMUSlvldc01-bridge0 0.000 0.387 0.000 0.096 504 24.814 3.373 3.364 8132 {2010-08-30 13:26:05}} {45 CRPdgMUSstamf21-bridge0 0.150 0.324 0.000 0.106 384 14.699 1.617 1.773 6881 {2010-08-30 13:26:34}} {3 CRPdgMUSniska01-bridge0 0.141 23.909 0.000 5.244 569 15.845 110.086 110.162 6985 {2010-08-30 13:27:41}} {562 CRPdgSSGsinga12-edsc0 0.018 3.547 0.000 0.870 509 56.703 14.605 14.118 6232 {2010-08-30 13:27:54}} {250 CRPdgMUSlvldc02-bridge0 1.903 58.584 0.003 15.094 485 19.489 524.618 527.259 3288 {2010-08-30 13:27:45}} {559 CRPdgMUSbever01-edsc0 0.665 9.516 0.000 1.633 728 126.690 9.368 9.431 3432 {2010-08-30 13:28:29}} {336 CRPdgSAUsydne10-bridge0 0.000 2.980 0.000 0.858 434 84.409 0.776 0.780 4996 {2010-08-30 13:24:55}} {372 CRPdgMUSniska02-bridge0 0.000 0.008 0.000 0.013 76 37.799 0.000 0.000 3297 {2010-08-30 13:21:07}} {260 CRPdgMUSniska01-bridge1 0.613 23.273 0.000 4.460 652 22.610 65.761 65.370 6474 {2010-08-30 13:26:41}} {549 CRPdgMUSnorwa01-bridge0 0.088 2.181 0.000 0.445 613 26.532 3.656 3.864 4913 {2010-08-30 13:24:03}} {426 CRPdgMUSatlan01-bridge0 15.016 116.919 0.003 29.306 498 49.590 226.420 226.417 8188 {2010-08-30 13:27:25}} {182 CRPdgMUSburba03-edsc0 0.000 0.933 0.000 0.334 349 28.761 4.270 4.512 5923 {2010-08-30 13:25:44}} {332 CRPdgSAUsydne10-bridge1 0.000 0.252 0.000 0.085 369 27.394 0.678 0.680 5339 {2010-08-30 13:22:57}} {375 CRPdgMUSniska02-bridge1 0.000 0.001 0.000 0.002 67 19.978 0.000 0.000 42 {2010-08-30 12:33:07}} {453 CRPdgMUSnorwa01-bridge1 0.000 2.043 0.000 0.378 676 25.348 6.468 6.647 4765 {2010-08-30 13:24:39}} {423 CRPdgMUSatlan02-bridge0 26.357 97.343 0.053 23.183 524 24.443 301.659 299.476 6104 {2010-08-30 13:26:22}} {196 CRPdgMUSburba03-edsc1 0.000 5.014 0.000 1.016 617 73.972 8.288 8.218 4697 {2010-08-30 13:27:10}} {354 CRPdgEUKwatf001-bridge0 0.000 6.026 0.000 1.070 703 28.316 11.770 11.557 7132 {2010-08-30 13:23:35}} {381 CRPdgEITmondo01-bridge0 0.028 3.394 0.000 1.119 379 28.255 11.224 11.162 5349 {2010-08-30 13:27:33}} {476 CRPdgMUSlvldc04-edsc0 0.010 62.596 0.000 14.824 527 91.997 0.297 0.290 8112 {2010-08-30 13:25:56}} {408 CRPdgSSGsinga20-bridge0 0.003 3.057 0.003 0.816 468 34.586 8.312 8.303 6953 {2010-08-30 13:26:12}} {404 CRPdgEUKcardi01-bridge0 0.082 0.876 0.000 0.223 491 43.975 3.158 3.163 7175 {2010-08-30 13:28:08}} {350 CRPdgEUKwatf001-bridge1 0.000 1.872 0.000 0.469 498 20.453 6.552 6.468 6941 {2010-08-30 13:26:55}} {536 CRPdgERUmosco02-edsc0 N/A N/A N/A N/A N/A N/A N/A N/A N/A N/A} {379 CRPdgEITmondo01-bridge1 0.007 1.759 0.000 0.426 516 27.337 7.596 7.663 6626 {2010-08-30 13:23:39}} {411 CRPdgSSGsinga20-bridge1 0.000 13.714 0.000 1.129 1518 21.144 8.047 8.002 6131 {2010-08-30 13:27:22}} {431 CRPdgEUKcardi01-bridge1 0.000 1.563 0.000 0.129 1518 18.223 0.517 0.542 3508 {2010-08-30 13:27:22}} {565 CRPdgMUSwayne01-bridge0 0.002 6.909 0.000 1.490 579 55.625 6.567 6.531 5334 {2010-08-30 13:24:49}} {108 CRPdgMUSmkedc01-bridge0 6.352 66.854 0.000 14.080 593 21.068 203.936 203.675 8162 {2010-08-30 13:27:55}} {600 CRPdgEITflore01-bridge0 1.263 40.744 0.000 9.193 554 36.469 81.656 81.712 7950 {2010-08-30 13:28:12}} {574 CRPdgMUSwayne02-bridge0 0.000 1.060 0.000 0.270 490 23.770 10.468 10.746 6179 {2010-08-30 13:28:10}} {103 CRPdgMUSmkedc02-bridge0 43.660 77.546 0.013 18.183 533 60.444 203.407 203.340 8169 {2010-08-30 13:25:05}} {568 CRPdgMUSwayne01-edsc0 1.083 7.186 0.000 1.368 656 13.727 6.734 6.803 6591 {2010-08-30 13:27:20}} {500 CRPdgMUStrevo01-bridge0 0.000 0.075 0.000 0.029 328 14.190 0.745 0.768 7738 {2010-08-30 13:26:51}} {71 CRPdgMUSfoxbo01-bge1 0.334 9.419 0.000 1.876 627 32.368 23.959 23.166 6637 {2010-08-30 13:26:29}} {465 CRPdgEFRbelfo01-bridge0 N/A N/A N/A N/A N/A N/A N/A N/A N/A N/A} {504 CRPdgMUStrevo01-bridge1 0.067 1.721 0.000 0.353 609 12.141 5.471 5.418 6470 {2010-08-30 13:25:22}} {467 CRPdgEFRbelfo01-bridge1 N/A N/A N/A N/A N/A N/A N/A N/A N/A N/A} {471 CRPdgEFRbelfo02-bridge0 N/A N/A N/A N/A N/A N/A N/A N/A N/A N/A} {474 CRPdgEFRbelfo02-bridge1 N/A N/A N/A N/A N/A N/A N/A N/A N/A N/A} {348 CRPdgEUKharr001-bridge0 0.000 0.870 0.000 0.435 250 42.559 2.288 2.263 6171 {2010-08-30 13:23:53}} {237 CRPdgSTHbangk01-bridge0 0.006 0.926 0.000 0.430 269 67.505 41.884 40.979 8168 {2010-08-30 13:26:15}} {521 CRPdgEDEmunic01-bridge0 0.060 1.479 0.000 0.338 547 23.782 2.785 2.822 6657 {2010-08-30 13:27:19}} {258 CRPdgEUKharr001-bridge1 0.000 0.081 0.000 0.026 391 22.643 0.264 0.259 6527 {2010-08-30 13:19:02}} {246 CRPdgSTHbangk01-bridge1 0.009 7.155 0.000 1.419 630 39.703 16.866 16.895 7793 {2010-08-30 13:23:27}} {524 CRPdgEDEmunic01-bridge1 0.000 4.608 0.000 0.379 1518 14.632 5.075 4.756 4674 {2010-08-30 13:24:09}} {180 CRPdgMUSburba02-edsc0 0.106 5.107 0.000 1.403 455 30.120 22.467 22.356 5874 {2010-08-30 13:26:23}} {441 CRPdgECZprag001-bridge0 0.373 11.459 0.000 2.848 503 16.907 90.022 89.976 7524 {2010-08-30 13:25:35}} {528 CRPdgEDEmunic01-bridge2 0.016 3.827 0.000 1.946 245 74.091 7.429 7.242 6322 {2010-08-30 13:27:34}} {194 CRPdgMUSburba02-edsc1 0.227 7.595 0.000 1.824 520 25.552 33.644 33.529 4876 {2010-08-30 13:28:25}} {444 CRPdgECZprag001-bridge1 0.120 6.334 0.000 1.384 571 21.545 29.990 29.960 7186 {2010-08-30 13:28:11}} {533 CRPdgERUmosco01-bridge1 0.000 0.008 0.000 0.011 85 35.878 0.022 0.006 3790 {2010-08-30 13:15:22}} {287 CRPdgEHUbuda001-bridge0 3.241 64.348 0.000 10.973 733 21.446 130.841 130.975 7286 {2010-08-30 13:26:00}} {254 CRPdgMUSlvldc03-edsc0 0.001 1.600 0.000 1.210 165 51.962 3.578 3.578 8129 {2010-08-30 13:24:07}} {539 CRPdgERUmosco02-bridge1 2.166 33.511 0.000 7.061 593 35.020 37.030 36.390 5669 {2010-08-30 13:28:07}} {531 CRPdgERUmosco01-edsc0 0.419 9.056 0.000 2.539 445 19.217 46.404 46.175 6551 {2010-08-30 13:25:54}} {293 CRPdgEHUbuda002-bridge0 0.000 0.021 0.000 0.015 178 68.728 0.031 0.009 1110 {2010-08-30 13:24:08}} {290 CRPdgEHUbuda001-bridge1 0.387 26.521 0.000 5.314 623 15.030 142.561 142.934 7461 {2010-08-30 13:26:19}} {396 CRPdgEFRbuc001-bridge0 55.899 88.340 0.003 16.308 677 74.788 97.624 97.204 6443 {2010-08-30 13:26:22}} {412 CRPdgMUShamil01-bridge0 28.355 112.083 0.000 27.584 507 37.045 220.891 220.887 8189 {2010-08-30 13:23:47}} {366 CRPdgERObuch001-bridge0 0.005 16.788 0.000 2.719 771 66.947 15.060 14.729 6842 {2010-08-30 13:28:30}} {398 CRPdgEFRbuc002-bridge0 2.543 57.421 0.000 10.252 700 11.574 101.480 101.544 7230 {2010-08-30 13:25:03}} {69 CRPdgMUSfoxbo01-em0 0.000 0.119 0.138 0.036 417 21.678 0.547 0.580 6252 {2010-08-30 13:27:29}} {512 CRPdgEHUbuda003-bridge0 0.000 1.049 0.006 0.240 547 23.116 3.555 3.501 7620 {2010-08-30 13:28:20}} {417 CRPdgMUShamil02-bridge0 57.371 129.967 0.010 26.807 606 20.913 289.289 289.719 3813 {2010-08-30 13:23:58}} {369 CRPdgERObuch001-bridge1 0.138 11.745 0.000 2.104 697 15.860 21.476 20.845 6657 {2010-08-30 13:28:15}} {594 CRPdgEFRbuc003-bridge0 0.172 41.078 0.231 9.471 542 75.840 98.832 99.547 6765 {2010-08-30 13:24:32}} {66 CRPdgMUSfoxbo01-em1 0.000 0.000 0.000 0.000 88 45.087 0.000 0.000 706 {2010-08-30 09:49:52}} {456 CRPdgEHUbuda004-bridge0 0.016 27.155 0.007 5.659 599 35.514 63.440 63.680 6588 {2010-08-30 13:26:20}} {80 CRPdgMUSalpdc10-bridge0 3.422 38.392 0.017 8.174 587 50.645 89.524 92.053 6122 {2010-08-30 13:27:40}} {602 CRPdgEHUbudap05-bridge0 0.000 5.793 0.020 1.376 526 75.990 14.843 14.859 8159 {2010-08-30 13:26:42}} {498 CRPdgELVriga001-bridge0 0.000 3.381 0.000 0.945 447 33.563 36.393 36.350 8050 {2010-08-30 13:25:02}} {315 CRPdgEPTlisbo01-bridge0 0.000 2.005 0.000 0.384 652 51.541 4.513 4.811 5906 {2010-08-30 13:23:44}} {321 CRPdgENLamshb10-bridge0 4.033 41.490 0.000 8.476 611 49.639 77.707 75.985 3553 {2010-08-30 13:26:29}} {459 CRPdgEHUbuda004-bridge1 0.715 54.871 2.209 11.724 585 14.640 105.583 104.895 6437 {2010-08-30 13:26:25}} {75 CRPdgMUSalpdc11-bridge0 0.364 18.883 0.000 4.042 583 29.073 91.029 91.205 7517 {2010-08-30 13:24:50}} {516 CRPdgELVriga001-bridge1 0.000 0.123 0.000 0.030 512 90.415 0.169 0.157 6879 {2010-08-30 13:25:31}} {317 CRPdgEPTlisbo01-bridge1 0.324 5.338 0.000 0.988 675 20.851 10.171 10.509 5875 {2010-08-30 13:28:13}} {324 CRPdgENLamshb11-bridge0 5.603 96.399 0.000 21.898 550 68.412 233.415 233.465 8079 {2010-08-30 13:25:47}} {269 CRPdgSJPhino001-bridge0 3.313 12.276 0.007 2.384 643 84.618 20.532 21.968 5081 {2010-08-30 13:27:56}} {77 CRPdgMUSalpdc12-bridge0 0.009 10.412 0.000 2.304 564 69.442 30.984 31.030 6192 {2010-08-30 13:25:35}} {216 CRPdgMUSengle03-edsc0 3.601 15.350 0.000 4.352 440 31.898 38.813 39.121 5027 {2010-08-30 13:24:34}} {273 CRPdgSJPhino001-bridge1 0.247 18.328 0.000 4.519 506 67.529 26.592 26.871 6116 {2010-08-30 13:26:47}} {212 CRPdgMUSengle03-edsc1 2.004 15.879 0.053 3.960 501 32.644 59.166 59.272 4524 {2010-08-30 13:27:25}} {326 CRPdgMBRsaopa01-bridge0 0.160 12.593 0.033 2.941 535 26.751 67.039 67.328 6581 {2010-08-30 13:27:02}} {91 CRPdgMUSalpdc14-bridge0 2.137 45.563 0.033 8.843 644 37.426 69.534 68.990 5676 {2010-08-30 13:24:34}} {552 CRPdgMUSschen01-bridge0 7.496 85.901 0.000 17.532 612 35.147 148.546 148.243 8146 {2010-08-30 13:26:28}} {330 CRPdgMBRsaopa01-bridge1 0.055 16.847 0.000 3.470 606 21.528 20.244 20.576 5459 {2010-08-30 13:25:31}} {389 CRPdgEHUbuda010-bridge0 2.692 59.088 0.000 9.783 755 13.996 74.665 74.475 7270 {2010-08-30 13:25:01}} {53 CRPdgMUScingh10-bridge0 0.000 65.835 0.067 13.266 620 31.657 125.330 125.139 7799 {2010-08-30 13:24:22}} {94 CRPdgMUSalpdc15-bridge0 1.712 41.472 0.000 7.997 648 28.557 76.456 76.659 6585 {2010-08-30 13:28:20}} {461 CRPdgMUSschen01-bridge1 16.885 74.691 0.013 15.749 592 21.802 151.886 151.000 6287 {2010-08-30 13:26:21}} {393 CRPdgEHUbuda011-bridge0 0.464 0.165 0.000 0.041 498 86.137 0.393 0.535 6408 {2010-08-30 13:24:14}} {56 CRPdgMUScingh11-bridge0 0.000 24.282 0.040 4.706 645 61.971 56.531 56.710 5357 {2010-08-30 13:25:21}} {60 CRPdgMUScingh12-bridge0 0.766 75.936 0.023 18.412 515 25.706 748.898 748.955 8171 {2010-08-30 13:25:56}} {276 CRPdgMUSalpdc20-bridge0 0.018 15.336 0.000 2.801 684 27.103 23.015 23.934 4247 {2010-08-30 13:23:39}} {48 CRPdgMUSwsthv20-bridge0 0.000 0.105 0.000 0.032 408 68.456 0.153 0.163 5511 {2010-08-30 13:20:42}} {179 CRPdgMUSburba01-edsc0 0.168 1.466 0.000 0.424 432 25.200 5.998 5.953 4448 {2010-08-30 13:26:10}} {278 CRPdgMUSalpdc21-bridge0 0.000 1.088 0.000 0.628 216 78.750 0.000 0.000 4 {2010-08-30 13:26:45}} {49 CRPdgMUSwsthv21-bridge0 1.314 0.020 0.000 0.005 545 28.212 0.036 0.019 383 {2010-08-30 13:05:35}} {191 CRPdgMUSburba01-edsc1 0.050 1.481 0.000 0.402 459 23.181 10.943 10.577 4838 {2010-08-30 13:23:43}} {383 CRPdgMUSalpdc22-bridge0 0.000 0.055 0.000 0.025 273 74.667 0.046 0.046 7013 {2010-08-30 13:28:18}} {282 CRPdgMUSalpdc21-bridge1 0.153 20.068 0.000 6.397 392 29.669 82.926 82.677 7401 {2010-08-30 13:27:14}} {142 CRPdgSINmumba01-bridge0 0.036 8.499 0.000 2.310 459 33.383 22.106 22.574 5736 {2010-08-30 13:27:16}} {420 CRPdgMUScinw701-bridge0 25.917 105.817 0.123 32.048 412 49.799 331.416 331.416 8189 {2010-08-30 13:23:56}} {586 CRPdgEUKlond020-edsc0 2.865 32.359 0.013 5.018 806 21.164 28.711 28.818 6685 {2010-08-30 13:23:44}} {284 CRPdgMUSalpdc21-bridge2 0.023 10.770 0.000 1.840 731 11.726 35.877 35.914 5499 {2010-08-30 13:28:13}} {166 CRPdgMUSpisca10-bridge0 0.000 0.014 0.000 0.011 160 68.905 0.630 0.649 7865 {2010-08-30 13:25:01}} {140 CRPdgSINmumba02-bridge0 0.000 0.003 0.000 0.005 76 33.959 0.202 0.120 6398 {2010-05-15 06:33:16}} {429 CRPdgMUScinw702-bridge0 0.000 0.092 0.000 0.092 124 40.025 10.011 10.014 8187 {2010-08-30 13:24:14}} {588 CRPdgEUKlond020-edsc1 1.824 31.135 0.000 4.704 827 29.062 42.832 42.364 6047 {2010-08-30 13:25:38}} {165 CRPdgMUSpisca10-bridge1 0.000 0.705 0.000 0.091 971 0.316 0.062 0.067 8123 {2010-08-30 12:53:18}} {264 CRPdgMUSroche01-bridge0 0.000 0.004 0.000 0.006 74 22.264 0.000 0.000 6129 {2010-08-30 13:26:48}} {97 CRPdgMUScingh18-bridge0 6.035 60.160 0.020 11.902 631 28.216 98.829 98.696 6448 {2010-08-30 13:28:30}} {543 CRPdgMUScingh20-bridge0 1.141 71.446 0.000 11.977 745 45.044 70.727 71.250 5724 {2010-08-30 13:26:26}} {267 CRPdgMUSroche01-bridge1 0.000 1.420 0.006 0.366 484 20.821 25.480 25.167 7798 {2010-08-30 13:27:47}} {234 CRPdgMUScingh18-bridge1 1.004 3.789 0.010 0.724 653 7.950 14.996 14.925 7452 {2010-08-28 01:15:36}} {101 CRPdgMUScingh19-bridge0 4.123 56.868 0.000 11.211 634 18.469 109.648 109.641 6633 {2010-08-30 13:28:25}} {546 CRPdgMUScingh20-bridge1 2.722 56.503 0.023 9.973 708 54.587 56.657 56.690 6004 {2010-08-30 13:26:53}} {160 CRPdgMUSwaudc01-bridge0 37.749 87.467 0.000 20.661 529 65.283 259.047 259.047 8184 {2010-08-30 13:26:12}} {162 CRPdgMUSwaudc02-bridge0 0.000 12.852 0.000 6.608 243 57.987 257.371 257.361 8191 {2010-08-30 13:24:54}} {210 CRPdgMUSengle02-edsc0 1.679 12.684 0.000 3.634 436 35.882 59.453 63.526 5696 {2010-08-30 13:26:24}} {592 CRPdgMUSwaudc03-bridge0 0.000 0.433 0.000 0.194 278 88.071 13.325 13.328 8190 {2010-07-31 22:10:24}} {221 CRPdgSJPtokyo10-bridge0 0.015 10.988 0.000 3.447 398 58.710 5.481 5.670 5125 {2010-08-30 13:27:55}} {206 CRPdgMUSengle02-edsc1 1.469 13.179 0.000 3.187 516 26.285 68.788 69.545 4635 {2010-08-30 13:25:26}} {386 CRPdgENLamst001-bridge0 0.000 0.186 0.000 0.087 267 58.008 0.316 0.374 5677 {2010-08-30 13:23:26}} {224 CRPdgSJPtokyo11-bridge0 0.177 3.935 0.000 0.711 692 92.862 9.940 9.931 5259 {2010-08-30 13:26:44}} {579 CRPdgMUSchica01-bridge0 0.109 2.150 0.006 0.548 490 19.795 5.623 6.007 5656 {2010-08-30 13:27:12}} {583 CRPdgMUSchica01-bridge1 0.003 2.912 0.003 0.661 550 24.809 11.441 11.294 6060 {2010-08-30 13:28:21}} {571 CRPdgSJPhino002-edsc0 0.026 10.968 0.000 2.864 478 81.210 25.884 25.441 5266 {2010-08-30 13:27:42}} {341 CRPdgSAUstlen01-bridge0 0.000 0.172 0.000 0.119 181 34.711 0.440 0.437 6204 {2010-08-30 13:23:49}} {309 CRPdgMUScingp20-bridge0 0.000 0.009 0.000 0.015 79 22.084 3.325 3.317 7987 {2010-08-30 13:19:56}} {356 CRPdgMUScingp21-bridge0 0.000 0.200 0.000 0.163 153 61.443 3.995 3.995 8040 {2010-08-30 13:23:26}} {310 CRPdgMUScingp20-bridge1 0.000 0.033 0.000 0.044 95 38.787 0.239 0.241 7870 {2010-05-13 05:30:30}} {297 CRPdgEUKlonhb10-bridge0 1.928 36.979 0.003 7.252 637 65.152 95.748 95.888 6438 {2010-08-30 13:26:50}} {492 CRPdgESEstock01-bridge0 0.077 4.029 0.000 1.838 273 55.721 50.700 50.661 7284 {2010-08-30 13:27:00}} {300 CRPdgEUKlonhb11-bridge0 0.008 69.736 0.000 13.473 647 89.217 100.333 100.283 7712 {2010-08-30 13:27:40}} {495 CRPdgESEstock01-bridge1 2.872 21.661 0.000 4.228 640 6.760 87.791 87.884 8039 {2010-08-30 13:24:12}} {359 CRPdgEUKlond001-bridge0 0.653 36.393 0.000 5.632 807 9.028 67.853 67.515 7201 {2010-08-30 13:25:04}} {435 CRPdgEPLkrak001-bridge0 1.485 53.283 0.000 11.668 570 15.896 198.682 198.572 8167 {2010-08-30 13:23:37}} {363 CRPdgEUKlond001-bridge1 0.420 17.572 0.000 2.615 839 8.408 42.099 41.894 7063 {2010-08-30 13:25:59}} {485 CRPdgEPLkrak002-bridge0 0.000 6.878 0.000 1.049 819 10.692 6.923 6.932 7908 {2010-08-30 13:27:37}} {438 CRPdgEPLkrak001-bridge1 1.090 23.510 0.000 5.124 573 90.639 116.841 114.435 6798 {2010-08-30 13:25:26}} {489 CRPdgEPLkrak002-bridge1 0.681 0.127 0.000 0.037 431 133.533 0.679 0.711 8032 {2010-08-30 13:22:45}} {15 CRPdgSINbanga02-bridge0 0.000 40.309 0.020 11.036 456 65.910 601.659 601.652 8191 {2010-08-30 13:28:15}} {122 CRPdgMCAcanhq10-bridge0 0.747 19.514 0.000 3.687 661 20.625 40.192 40.202 6613 {2010-08-30 13:25:00}} {227 CRPdgMUScharl01-igb1 0.193 18.538 0.176 4.016 577 48.942 42.163 41.963 6352 {2010-08-30 13:27:46}} {146 CRPdgSINbanga03-bridge0 0.007 14.926 0.003 3.621 515 37.407 33.802 35.563 5799 {2010-08-30 13:25:17}} {125 CRPdgMCAcanhq11-bridge0 0.000 0.010 0.000 0.003 391 23.111 0.388 0.266 4996 {2009-06-06 02:16:59}} {38 CRPdgMUSfairf10-bridge0 12.382 125.036 0.007 20.947 746 53.127 75.010 75.967 5811 {2010-08-30 13:27:21}} {597 CRPdgESWzuric01-edsc0 5.259 15.054 0.000 2.744 685 28.712 28.156 28.054 5346 {2010-08-30 14:23:40}} {229 CRPdgMUScharl01-igb2 0.000 0.001 0.000 0.001 68 1.091 0.000 0.000 0 {2010-08-30 12:45:31}} {129 CRPdgMUSfairf11-bridge0 0.781 35.510 0.000 5.457 813 15.065 38.607 37.936 5072 {2010-08-30 13:27:29}} {148 CRPdgSINbanga04-bridge0 0.021 24.835 0.000 5.995 517 64.105 37.403 37.509 5483 {2010-08-30 13:27:22}} {303 CRPdgSSGsinga01-bridge0 0.000 2.255 0.000 0.848 332 51.116 22.846 22.598 7736 {2010-08-30 13:24:47}} {130 CRPdgMUSfairf12-bridge0 2.527 30.863 0.003 5.091 757 38.278 25.340 25.081 5853 {2010-08-30 13:25:18}} {306 CRPdgSSGsinga01-bridge1 0.000 0.487 0.000 0.192 317 23.330 0.501 0.529 7552 {2010-08-30 13:28:13}} {151 CRPdgMUSstamf10-bridge0 3.571 36.002 0.003 6.125 734 21.339 57.575 54.157 6223 {2010-08-30 13:23:59}} {134 CRPdgMUSfairf13-bridge0 0.000 0.470 0.000 0.090 653 9.009 0.660 0.684 7418 {2010-08-30 13:28:17}} {339 CRPdgSAUmelb001-bridge0 0.000 0.537 0.000 0.301 223 28.932 3.498 3.631 7182 {2010-08-30 13:27:01}} {156 CRPdgMUSstamf11-bridge0 0.222 20.856 0.000 3.429 760 53.435 33.054 31.654 5603 {2010-08-30 13:25:00}} {240 CRPdgMUSedenp01-bridge0 0.709 19.657 0.000 3.824 642 22.182 82.038 82.353 6916 {2010-08-30 13:25:09}} {136 CRPdgMUSfairf14-bridge0 0.000 0.721 0.000 0.112 804 6.488 1.527 1.532 2141 {2010-08-30 13:26:35}} {204 CRPdgMUSengle01-edsc0 1.628 13.569 0.000 4.042 419 32.073 49.128 49.211 5255 {2010-08-30 13:27:26}} {157 CRPdgMUSstamf12-bridge0 0.110 13.988 0.000 2.592 674 23.116 38.815 37.482 5689 {2010-08-30 13:26:17}} {243 CRPdgMUSedenp01-bridge1 0.034 13.125 0.000 2.856 574 38.690 81.108 81.140 7024 {2010-08-30 13:24:31}} {201 CRPdgMUSengle01-edsc1 1.485 16.012 0.000 3.986 502 23.754 64.512 65.335 4493 {2010-08-30 13:28:30}} {483 CRPdgEPLgdan001-bridge0 0.375 51.029 0.000 11.720 544 79.288 89.869 89.359 5831 {2010-08-30 13:27:57}} {577 CRPdgMUSwayne02-edsc0 1.774 5.007 0.000 1.201 521 19.060 17.673 17.606 6350 {2010-08-30 13:24:14}} {505 CRPdgEPLgdan002-bridge0 0.001 7.957 0.000 2.390 416 63.499 7.740 7.780 7000 {2010-08-30 13:26:49}} {479 CRPdgEPLgdan001-bridge1 15.497 78.107 0.017 20.082 486 46.806 165.022 164.878 7505 {2010-08-30 13:23:58}}}"
