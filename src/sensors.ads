
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
-- Filename:            sensors.ads
--
-- Description:         Models the 3 pressure sensors associated with the WTP system. Note that
--                      a single sensor reading is calculated using a majority vote
--                      algorithm.

pragma SPARK_Mode (On); 
package Sensors

is
   pragma Elaborate_Body;
   
   Init_Value:  constant Integer := 0;
   Undef_Value: constant Integer := 2100; -- range of valid pressure readings is 0..2099. A value of 2100 denotes an undefined reading.
   
   subtype Sensor_Type is Integer range 0..2100;
   subtype Sensor_Index_Type is Integer range 1..3;
   type Sensors_Type is array (Sensor_Index_Type) of Sensor_Type;
   
   State: Sensors_Type := (others => Undef_Value);

   procedure Write_Sensors(Value_1, Value_2, Value_3: in Sensor_Type)
   with 
   Global => (In_Out => State),
       Depends => (State => (State, Value_1, Value_2, Value_3));
   
   function Read_Sensor(Sensor_Index: in Sensor_Index_Type) return Sensor_Type
   with
   Global  => (Input => State),
   Depends => (Read_Sensor'Result => (State, Sensor_Index));

   function Read_Sensor_Majority return Sensor_Type
   with
   Global => (Input => State),
   Depends => (Read_Sensor_Majority'Result => State);
   
end Sensors;
