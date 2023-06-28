with Text_IO, Handler; use Text_IO, Handler;
package body WTP is

   function Sensor_2_Water_Level_Cat(Sensor_Value: in Sensors.Sensor_Type) return Water_Level_Cat
   is 
      WLC: Water_Level_Cat;
   begin
      if (Sensor_Value >= 100) and (Sensor_Value < 2000) then
         WLC := Normal;
      elsif (Sensor_Value >= 0) and (Sensor_Value < 100) then
         WLC := Low;
      elsif (Sensor_Value >= 2000) and (Sensor_Value < 2100) then
         WLC := High;
      else
         WLC := Undef;
      end if;
      return WLC;
   end Sensor_2_Water_Level_Cat;
   
   procedure Control
   is
   begin
      if Sensor_2_Water_Level_Cat(Sensors.Read_Sensor_Majority) = High then
         if Alarm.Enabled then
            Drain.Open;
         end if;
         if not Alarm.Enabled then
            Alarm.Alarm_Cnt := Alarm.Add_Alarm_Cnt;
         end if;
         Alarm.Enable;
      elsif Sensor_2_Water_Level_Cat(Sensors.Read_Sensor_Majority) = Low then
         if not Alarm.Enabled then
            Alarm.Alarm_Cnt := Alarm.Add_Alarm_Cnt;
         end if;
         Alarm.Enable;
      else
         if Console.Reset_Enabled and Drain.Openned then
            Drain.Close;
         end if;        
         Alarm.Disable;
      end if;
        
   end;

end WTP;
