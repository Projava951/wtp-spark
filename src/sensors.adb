package body Sensors is
   
   procedure Write_Sensors(Value_1, Value_2, Value_3: in Sensor_Type)
   is
   begin
      State(1) := Value_1;
      State(2) := Value_2;
      State(3) := Value_3;
   end Write_Sensors;

   function Read_Sensor(Sensor_Index: in Sensor_Index_Type) return Sensor_Type
   is
   begin
      return State(Sensor_Index);
   end Read_Sensor;

   function Read_Sensor_Majority return Sensor_Type
   is
      Count: array (Sensor_Type) of Integer := (others => 0);
      Max_Count: Integer := 0;
      Max_Value: Sensor_Type := Undef_Value;
   begin
      for I in Sensor_Index_Type loop
         if State(I) /= Undef_Value then
            Count(State(I)) := Count(State(I)) + 1;
            if Count(State(I)) > Max_Count then
               Max_Count := Count(State(I));
               Max_Value := State(I);
            end if;
         end if;
      end loop;
      return Max_Value;
   end Read_Sensor_Majority;

end Sensors;
