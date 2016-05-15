#include <SD.h>
#include <SPI.h>
#include <Wire.h>
#include "RTClib.h"
#include "DHT.h"
#define DHTPIN A0
#define DHTTYPE DHT11

DHT dht(DHTPIN,DHTTYPE);
RTC_DS3231 rtc;

File weatherlog;
const int chipSelect = 4;
const int stationId = 1;

const byte WSPEED = 3;
volatile long lastWindCheck = 0;
int windspeedmph=0;
volatile long lastWindIRQ = 0;
byte windClicks = 0;
float windSpeed;



const byte WDIR = A1;
int winddir ; // [0-360 instantaneous wind direction]

const byte RAIN = 2;
volatile float dailyrainin; // [rain inches so far today in local time]
volatile unsigned long raintime, rainlast, raininterval, rain;
float h;
float t;
float hic;
int datetime;
void rainIRQ()
             // Count rain gauge bucket tips as they occur
             // Activated by the magnet and reed switch in the rain gauge, attached to input D2
            {
              raintime = millis(); // grab current time
              raininterval = raintime - rainlast; // calculate interval between this and last event           
              if (raininterval > 10) // ignore switch-bounce glitches less than 10mS after initial edge
                {
                  dailyrainin += 0.011; //Each dump is 0.011" of water                        
                }           
            }

void wspeedIRQ()
             // Activated by the magnet in the anemometer (2 ticks per rotation), attached to input D3
            {
              if (millis() - lastWindIRQ > 10) // Ignore switch-bounce glitches less than 10ms (142MPH max reading) after the reed switch closes
              {
                 lastWindIRQ = millis(); //Grab the current time
                windClicks++; //There is 1.492MPH for each click per second.
              }
            }

void error(char *str)
            {
            Serial.print("error: ");
            Serial.println(str);
            while(1);
            }

void setup() 
          {             
              Serial.begin(9600);
              pinMode(4,OUTPUT);
              pinMode(WDIR, INPUT);
              pinMode(WSPEED, INPUT_PULLUP); // input from wind meters windspeed sensor
              pinMode(RAIN, INPUT_PULLUP); // input from wind meters rain gauge sensor
              attachInterrupt(0, rainIRQ, FALLING);
              attachInterrupt(1, wspeedIRQ, FALLING);
              interrupts();
              dht.begin(); 
             // Serial.println();
              //Serial.println("initializing sd card...");
              
              
              if(!SD.begin(chipSelect))
                 {
                   error("card failed,or not present");
                 }
              char filename[]="logger00.txt";
              
              for (uint8_t i=0; i<100;i++){
                filename[6]=i/10 + '0';
                filename[7]=i%10 + '0';
                if(!SD.exists(filename)){
               
                // only open a new file if it doesn't exist
               weatherlog=SD.open(filename,FILE_WRITE);
              if (weatherlog) 
                 {
             //  Serial.print("file created with name");
             //  Serial.print("  ");
             //  Serial.println(filename);
                 }
              // if the file isn't open, pop up an error:
              else
                 {
                Serial.println("error creating file");
                 }
                break; // leave the loop!
            
                }
               }    
             // Serial.println("card initialised"); 
              Wire.begin();
               rtc.begin();
              DateTime now = rtc.now();
              DateTime compiled = DateTime(__DATE__, __TIME__);
              if (now.unixtime() < compiled.unixtime()) {
              // following line sets the RTC to the date & time this sketch was compiled
              rtc.adjust(DateTime(__DATE__, __TIME__));
            }
        
              if(!rtc.begin())
                  {
                    Serial.println("RTC failed");
                  }
              else
                 {  
                       weatherlog.println("    Datetime         Humidity      Temperature    HeatIndex     Windspeed     Winddirection     AmtOfRain");
                        // Serial.println("    datetime         humidity      temperature    windspeed     winddirection     AmtOfRain");
                 }  
            }
  
void loop() 
          {
              logData();
              
              windspeedmph = get_wind_speed();
              winddir=get_wind_direction();
              if (raininterval>=20000)
               {
                  dailyrainin=0;
               }
              rainlast = raintime; // set up for next event
             //Read humidity in percentage
               h = dht.readHumidity();
             // Read temperature as Celsius (the default)
               t = dht.readTemperature();
             // Check if any reads failed and exit early (to try again).
             // Compute heat index in Celsius (isFahreheit = false)
              hic = dht.computeHeatIndex(t, h,false);
             if (isnan(h) || isnan(t)) 
             {
                Serial.println("Failed to read from DHT sensor!");
                return;
             }


             
             unsigned int adc;
             char vanedir;
             adc = analogRead(WDIR); // get the current reading from the sensor
             //sending value in an array to the wifi module
             

            
             //Stores values to sd card
               
               delay(15000);
               weatherlog.print("   ");
               weatherlog.print(h);
               weatherlog.print("         ");
               weatherlog.print(t);
               weatherlog.print("          ");
               weatherlog.print(hic);
               weatherlog.print("          ");
               weatherlog.print(windSpeed);
               weatherlog.print("          ");
               if(winddir==23){
                  weatherlog.print("ENE");
                  }
               else if(winddir==45){
                  weatherlog.print("NE");
                  }
                  else if(winddir==68){
                  weatherlog.print("NNE");
                  }
                  else if(winddir==90){
                  weatherlog.print("NORTH");
                  }
                   else if(winddir==113){
                  weatherlog.print("NNW");
                  }
                   else if(winddir==135){
                  weatherlog.print("NW");
                  }
                   else if(winddir==158){
                  weatherlog.print("WNW");
                  }
                   else if(winddir==180){
                  weatherlog.print("WEST");
                  }
                   else if(winddir==203){
                  weatherlog.print("WSW");
                  }
                   else if(winddir==225){
                  weatherlog.print("SW");
                  }
                   else if(winddir==248){
                  weatherlog.print("SSW");
                  }
                   else if(winddir==270){
                  weatherlog.print("SOUTH");
                  }
                   else if(winddir==293){
                  weatherlog.print("SSE");
                  }
                   else if(winddir==315){
                  weatherlog.print("SE");
                  }
                   else if(winddir==338){
                  weatherlog.print("ESE");
                  }
                   else if(winddir==0){
                  weatherlog.print("EAST");
                  }
                  else{
                    weatherlog.print("ERROR");
                    }
               weatherlog.print("               ");
               weatherlog.println(dailyrainin);
               weatherlog.flush();
               senddelay(15); 
        }
    void senddelay(unsigned long ms)
    {
      DateTime now = rtc.now();
      int i=0;
      float readings[13]={stationId,h,t,hic,windSpeed,winddir,dailyrainin,now.hour(), now.minute(), now.second(), now.day(), now.month(), now.year()};
      unsigned long start = millis();
      do{
         Serial.print("");
              for(char i=0;i<13;i++){
                Serial.print(reading[i]);
                Serial.print(" ");
              }
              Serial.println("0");}
              while (millis() - start < ms+1);
    }
int logData()
        {
              DateTime now;
              now = rtc.now();
              weatherlog.print('"');
              weatherlog.print(now.day(), DEC);
              weatherlog.print("/");
              weatherlog.print(now.month(), DEC);
              weatherlog.print("/");
              weatherlog.print(now.year(), DEC);
              weatherlog.print(" ");
              weatherlog.print(now.hour(), DEC);
              weatherlog.print(":");
              weatherlog.print(now.minute(), DEC);
              weatherlog.print(":");
              weatherlog.print(now.second(), DEC);
              weatherlog.print('"');
              
           
         }
float get_wind_speed()
                    {
                      float deltaTime = millis() - lastWindCheck; //750ms
                    
                      deltaTime /= 1000.0; //Covert to seconds
                    
                      windSpeed = (float)windClicks / deltaTime; //3 / 0.750s = 4
                    
                      windClicks = 0; //Reset and start watching for new wind
                      lastWindCheck = millis();
                    
                      windSpeed *= 2.4; //4 * 2.4 = 9.6km/h
                      return(windSpeed);
                    }

 int get_wind_direction() 
                        // read the wind direction sensor, return heading in degrees
                    {
                      unsigned int adc;
                      adc = analogRead(WDIR); // get the current reading from the sensor
                    
                      // The following table is ADC readings for the wind direction sensor output, sorted from low to high.
                      // Each threshold is the midpoint between adjacent headings. The output is degrees for that ADC reading.
                      // Note that these are not in compass degree order! See Weather Meters datasheet for more information.
                    
                      if (adc <66 ) return (113);
                      if (adc < 84) return (68);
                      if (adc < 92) return (90);
                      if (adc <127 ) return (158);
                      if (adc <184) return (135);
                      if (adc < 244) return (203);
                      if (adc < 287) return (180);
                      if (adc < 406) return (23);
                      if (adc < 461) return (45);
                      if (adc < 600) return (248);
                      if (adc < 630) return (225);
                      if (adc < 702) return (338);
                      if (adc < 786) return (0);
                      if (adc < 827) return (293);
                      if (adc < 946) return (270);
                      if (adc < 979) return (315);
                      return (-1); // error, disconnected?
                    }

