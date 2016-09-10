with Id_Handler; use Id_Handler;

package body Station
with SPARK_Mode => On
is
   function Init_Station_Record return Station_Record is
     ((Station_ID => Get_ID));

end Station;
