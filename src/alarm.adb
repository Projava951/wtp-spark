package body Alarm is

   procedure Enable
   is
   begin
      Alarm_State := True;
   end Enable;

   procedure Disable
   is
   begin
      Alarm_State := False;
   end Disable;
   
   function Enabled return Boolean
   is 
   begin
      return Alarm_State;
   end Enabled;
   
   function Alarm_Cnt_Value return Integer
   is
   begin
      return Alarm_Cnt;
   end Alarm_Cnt_Value;
   
   function Add_Alarm_Cnt return Integer
   is 
   begin
      Alarm_Cnt := Alarm_Cnt + 1;
      return Alarm_Cnt;
        
   end Add_Alarm_Cnt;

end Alarm;
