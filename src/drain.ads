
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
-- Filename:            drain.ads
--
-- Description:         Models the emergency drainage valve associated with the 
--                      water tank.

pragma SPARK_Mode (On);
package Drain

is
   pragma Elaborate_Body;
   
   State: Boolean:= False;
   
   procedure Open
   with
   Global => (Output => State),
   Depends => (State => null);

   procedure Close
   with
   Global => (Output => State),
   Depends => (State => null);

   function Openned return Boolean
   with
   Global => (Input => State),
   Depends => (Openned'Result => State);

end Drain;
