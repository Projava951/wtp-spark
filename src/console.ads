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
-- Filename:            console.ads
--
-- Description:         Models the console associated with the WTP system, i.e. 
--                      the reset mechanism that is required to close the 
--                      emergency drainage valve.


pragma SPARK_Mode (On); 
package  Console

is
   pragma Elaborate_Body;
   
   Reset_Status: Boolean:= False;
   
   procedure Enable_Reset
   with
   Global => (Output => Reset_Status),
   Depends => (Reset_Status => null);

   procedure Disable_Reset
   with
   Global => (Output => Reset_Status),
   Depends => (Reset_Status => null);

   function Reset_Enabled return Boolean
   with
   Global => (Input => Reset_Status),
   Depends => (Reset_Enabled'Result => Reset_Status);  
   
  
   
end Console;
