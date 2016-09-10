with Id_Handler;
use Id_Handler;
with Station;
use Station;

package Track
with SPARK_Mode => On
is

   type Track_Record is
      record
         Track_ID: ID;
         Origin: Station_Record;
         Destination: Station_Record;
      end record;


   function Init_Track_Record (O: in Station_Record;
                               D: in Station_Record) return Track_Record;

end Track;
