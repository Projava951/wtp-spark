
-- Author:              A. Ireland
--
-- Address:             School Mathematical & Computer Sciences
--                      Heriot-Watt University
--                      Edinburgh, EH14 4AS
--
-- E-mail:              a.ireland@hw.ac.uk
--
-- Last modified:       19.11.2020
--
-- Filename:            alarm.ads
--
-- Description:         Models the alarm device associated with
--                      the WTP controller and the alarm count.

pragma SPARK_Mode (On);
package Alarm 

is
   pragma Elaborate_Body;
   
   Alarm_State: Boolean:= False;
   Alarm_Cnt: Integer:= 0;
   
   procedure Enable
   with 
     Global  => (Output => Alarm_State,
		 In_Out => Alarm_Cnt),
     Depends => (Alarm_State  => null,
		 Alarm_Cnt => Alarm_Cnt);

   procedure Disable
   with
   Global  => (Output => Alarm_State),
   Depends => (Alarm_State  => null);

   function Enabled return Boolean
   with 
   Global => (Input => Alarm_State),
   Depends => (Enabled'Result => Alarm_State);
   
   function Alarm_Cnt_Value return Integer
   with
   Global => (Input => Alarm_Cnt),
       Depends => (Alarm_Cnt_Value'Result => Alarm_Cnt); 
   
   function Add_Alarm_Cnt return Integer
   with
   Global => (Input => Alarm_Cnt),
   Depends => (Add_Alarm_Cnt'Result => Alarm_Cnt);

end Alarm;
