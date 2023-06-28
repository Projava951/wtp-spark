pragma SPARK_Mode (On);
with Text_IO, Sensors, Alarm, Drain, Console;
package body Handler is

   package Integer_INOUT is new Text_IO.Integer_IO(Integer);
   
   procedure Update_Env
   is
      
      Sensor_1: Integer;
      Sensor_2: Integer;
      Sensor_3: Integer;
      ResetSig: Integer;
   begin
      Integer_INOUT.Get(Env_File, Sensor_1);
      Integer_INOUT.Get(Env_File, Sensor_2);
      Integer_INOUT.Get(Env_File, Sensor_3);
      Integer_INOUT.Get(Env_File, ResetSig);
      if Sensor_1 in Sensor_Range'Range and Sensor_2 in Sensor_Range'Range and Sensor_3 in Sensor_Range'Range then
         Sensors.Write_Sensors(Sensor_1, Sensor_2, Sensor_3);
      end if;
      
      if ResetSig = 1 then
         Console.Enable_Reset;
      else
         Console.Disable_Reset;
      end if;
      Text_IO.Put('.');
   end Update_Env;
   
   function At_End return Boolean is
   begin
      return Text_IO.End_Of_File(Env_File);
   end At_End;
   
   procedure Open_Env_File 
   is
   begin
      Text_IO.Open(Env_File, Text_IO.In_File, "env.dat");
   end Open_Env_File;

   procedure Close_Env_File is
   begin
      Text_IO.Close(Env_File);
      Text_IO.Put_Line(" [ complete ]");
   end Close_Env_File;
   
   package Sensor_INOUT is new Text_IO.Enumeration_IO(Water_Level_Cat);
   
   
   
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
   
   procedure Update_Log is
   begin
      Sensor_INOUT.Put(Log_File, Sensor_2_Water_Level_Cat(Sensors.Read_Sensor(1)), 10);
      Sensor_INOUT.Put(Log_File, Sensor_2_Water_Level_Cat(Sensors.Read_Sensor(2)), 10);
      Sensor_INOUT.Put(Log_File, Sensor_2_Water_Level_Cat(Sensors.Read_Sensor(3)), 10);
      Sensor_INOUT.Put(Log_File, Sensor_2_Water_Level_Cat(Sensors.Read_Sensor_Majority), 10);
      if Alarm.Enabled then
         Text_IO.Put(Log_File, "ON   ");
      else
         Text_IO.Put(Log_File, "--   ");
      end if;
      if Drain.Openned then
         Text_IO.Put(Log_File, "  OPEN  ");
      else
         Text_IO.Put(Log_File, "  CLOSED");
      end if;
      if Console.Reset_Enabled then
         Text_IO.Put(Log_File, "   ON");
      else
         Text_IO.Put(Log_File, "   --");
      end if;
      Integer_INOUT.Put(Log_File, Alarm.Alarm_Cnt_Value, 6);
      Text_IO.New_Line(Log_File);
   end Update_Log;
   
   procedure Open_Log_File is
   begin
      Text_IO.Create(Log_File, Text_IO.Out_File, "log.dat");
      Text_IO.Put_Line(Log_File, "SENSOR-1  SENSOR-2  SENSOR-3  MAJORITY  ALARM  DRAIN    RESET  ALARM_CNT");
      Text_IO.Put_Line(Log_File,
               "--------  --------  --------  --------  -----  -------  -----  ---------");
   end Open_Log_File;
     
   procedure Close_Log_File is
   begin
      Text_IO.Close(Log_File);
   end Close_Log_File;
   
end Handler;
