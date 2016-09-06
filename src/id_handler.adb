package body Id_Handler
with SPARK_Mode => On
is

   A_ID: ID := 1;

   function Get_ID return ID is
      Temp : ID := A_ID;
   begin
      A_ID := A_ID + 1;
      return Temp;
   end Get_ID;

   function Has_ID return Boolean is
   begin
      return not (A_ID = ID'Last);
   end Has_ID;

end Id_Handler;
