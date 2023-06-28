package body Drain is

   procedure Open
   is
   begin
      State := True;
   end Open;

   procedure Close
   is
   begin
      State := False;
   end Close;
   
   function Openned return Boolean
   is
   begin
      return State;
   end Openned;

end Drain;
