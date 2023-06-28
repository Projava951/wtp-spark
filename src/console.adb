package body Console is

   procedure Enable_Reset
   is
   begin
      Reset_Status := True;
   end Enable_Reset;

   procedure Disable_Reset
   is
   begin
      Reset_Status := False;
   end Disable_Reset;
   
   function Reset_Enabled return Boolean
   is 
   begin
      return Reset_Status;
   end Reset_Enabled;

end Console;
