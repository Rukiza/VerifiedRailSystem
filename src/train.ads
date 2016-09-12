with Id_Handler;
use Id_Handler;
with Station;
use Station;
with Track;
use Track;

package Train
with SPARK_Mode => On
is

   type Path_Array is array (Positive range <>) of ID;

   type Train_Record is
      record
         Current: ID;
         Origin: Station_Record;
         Destination: Station_Record;
         Path: Path_Array(1..6);
         Marker: Positive;
      end record;

   function Init_Train_Record (s: Station_Record;
                               origin: Station_Record;
                               destination: Station_Record;
                               path: Train.Path_Array) return Train_Record;

   function Init_Train_Record (t: Track_Record;
                               origin: Station_Record;
                               destination: Station_Record;
                               path: Train.Path_Array) return Train_Record;

end Train;
