pragma SPARK_Mode (On);
with Text_IO; use Text_IO;
package Handler is
   Env_File:Text_IO.File_Type;
   Log_File: Text_IO.File_Type;
  subtype Sensor_Range is Integer range 0..2100;
   
  type Water_Level_Cat is (Low, Normal, High, Undef);
   
  procedure Update_Env
  with 
      Pre => Text_IO.Is_Open (Env_File) and then Text_IO.Mode (Env_File) = Text_IO.In_File;
   

   function At_End return Boolean
   with 
      Pre => Text_IO.Is_Open (Env_File) and then Text_IO.Mode (Env_File) = Text_IO.In_File;

   procedure Open_Env_File
   with 
       Pre => not Text_IO.Is_Open (Env_File),
       Post => Text_IO.Is_Open (Env_File) and then Text_IO.Mode (Env_File) = Text_IO.In_File;

   procedure Close_Env_File
     with 
      Pre => Text_IO.Is_Open (Env_File) and then Text_IO.Mode (Env_File) = Text_IO.In_File;

   procedure Update_Log
   with 
      Pre => Text_IO.Is_Open (Log_File) and then Text_IO.Mode (Log_File) = Text_IO.Out_File;

   procedure Open_Log_File
   with 
      Pre => not Text_IO.Is_Open (Log_File),
       Post => Text_IO.Is_Open (Log_File) and then Text_IO.Mode (Log_File) = Text_IO.Out_File;

   procedure Close_Log_File
   with 
      Pre => Text_IO.Is_Open (Log_File) and then Text_IO.Mode (Log_File) = Text_IO.Out_File;

end Handler;
