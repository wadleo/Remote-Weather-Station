-- this code is for the esp client to send data to the server
-- by raoul and wadleo


--wifi.setmode(wifi.STATIONAP)
wifi.setmode(wifi.STATION)
if (wifi.sta.getip() == nil) then
wifi.sta.config("gear_up","gear_up2016")
end

-- setup baudrate
uart.setup(0,9600,8,0,1)

-- the address of the server is set here
HOST = "192.168.8.100" 
-- the path to the web platform on the server is set here 
URI = "/RemoteWeatherStation/weather_data.php"

datar = ''

function display(sck,response)
     print(response)
end

-- this method builds the post request   
function build_post_request(host, uri)
     
   local data = {
      station_id = array[1],
      humidity = array[2],
      temperature = array[3],
      heat_index = array[4],
      amt_of_rain = array[7],
      wind_speed = array[5],
      wind_direction = array[6],
      datetime = array[13].."-"..array[12].."-"..array[11].. " "..array[8]..":"..array[9]..":"..array[10],
    }

-- this loop takes the name of a value and equates that name to its value
     for param,value in pairs(data) do
          datar = datar .. param .. "=" .. value .. "&"
     end

-- then the data in the datar variable is added to this request variable
     request = "POST "..uri.." HTTP/1.1\r\n"..
     "Host: "..host.."\r\n"..
     "Connection: keep-alive\r\nkeep-alive: 1\r\nPragma: no-cache\r\n"..
     "Cache-Control: no-cache\r\nContent-Type: application/x-www-form-urlencoded\r\n"..
     "Content-Length: "..string.len(datar)..
     "\r\nAccept: */*\r\n\r\n"..datar
     
-- the request variable is now return
     return request
end

-- a socket is initialised 
socket = net.createConnection(net.TCP, false)
socket:connect(80, HOST)
-- this section sets the method to be called after a post request has been
-- sent and data is received 
socket:on("receive", display)

-- this section sets what should happen on connection to the server
-- first the post request is built 
-- then the post request is send
socket:on("connection",function(socket) 
    post_request = build_post_request(HOST, URI) 
    socket:send(post_request)
end) 

--10s delay before starting with the program, sufficient break execution if needed
tmr.alarm(0, 6000, 0, function() dofile("init.lua") end)
