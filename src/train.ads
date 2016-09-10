with Id_Handler;
use Id_Handler;
with Station;
use Station;

package Train
with SPARK_Mode => On
is

type Train_Record is
      record
         Current: ID;
         Origin: Station_Record;
         Destination: Station_Record;
      end record;

   function Init_Train_Record return Train_Record;

end Train;
