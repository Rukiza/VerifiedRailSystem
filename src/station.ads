with Id_Handler;
use Id_Handler;

package Station
with SPARK_Mode => On
is

   type Station_Record is
      record
         Station_ID : ID;
      end record;

   function Init_Station_Record return Station_Record;


end Station;
