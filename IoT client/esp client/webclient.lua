--custom application init
uart.setup(0,9600,8,0,1)

HOST = "192.168.8.102" 
URI = "/RemoteWeatherStation/weather_data.php"
datar = ''

--tmr.alarm(0, 6000, 0, function() dofile("webserver.lua") end)

--define the variable received from arduino
array = {0,0,0,0,0,0,0,0,0,0,0,0,0,0}

data = {
      station_id = array[1],
      humidity = array[2],
      temperature = array[3],
      heat_index = array[4],
      amt_of_rain = array[7],
      wind_speed = array[5],
      wind_direction = array[6],
      datetime = array[13].."-"..array[12].."-"..array[11].. " "..array[8]..":"..array[9]..":"..array[10],
    }

function display(sck,response)
     print(response)
end
   
function build_post_request(host, uri, data)
     
     for param,value in pairs(data) do
          datar = datar .. param .. "=" .. value .. "&"
     end
 
     request = "POST "..uri.." HTTP/1.1\r\n"..
     "Host: "..host.."\r\n"..
     "Connection: keep-alive\r\nkeep-alive: 1\r\nPragma: no-cache\r\n"..
     "Cache-Control: no-cache\r\nContent-Type: application/x-www-form-urlencoded\r\n"..
     "Content-Length: "..string.len(datar)..
     "\r\nAccept: */*\r\n\r\n"..datar
     
     return request
end

socket = net.createConnection(net.TCP, false)
socket:on("receive", display)
socket:connect(80, HOST)
socket:on("connection",function(socket) 
    print("\n")
    print("array: ")
    for key,value in ipairs(array) do print(key,value) end
    print("\n")
    --print("data: ")
    --for key,value in ipairs(data) do print(key,value) end
    --print("\n")    
    --print("datar: ")
    --for key,value in ipairs(t) do print(key,value) end
    --print("\n")    
    post_request = build_post_request(HOST, URI, data) 
    print("\n")    
    print(post_request)
    socket:send(post_request)
end) 

