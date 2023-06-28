pragma SPARK_Mode (On);
With Handler, WTP, Text_IO; use Handler;

procedure Wtp_Test
is

begin
   if not Text_IO.Is_Open(Env_File) and not Text_IO.Is_Open(Log_File) then
      Handler.Open_Env_File;
      Handler.Open_Log_File;
      loop
         exit when Handler.At_End;
         Handler.Update_Env;
         Handler.Update_Log;
         WTP.Control;
         Handler.Update_Log;
      end loop;
      Handler.Close_Env_File;
      Handler.Close_Log_File;
   end if;
end Wtp_Test;
