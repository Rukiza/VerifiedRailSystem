package Id_Handler
with SPARK_Mode => On
is

   type ID is new Positive;

   function Get_ID return ID;

   function Has_ID return Boolean;

end Id_Handler;
