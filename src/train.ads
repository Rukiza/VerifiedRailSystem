with Id_Handler;
with Station;

package Train
with SPARK_Mode => On
is

type Train_Record is
      record
         Current: ID;
         Origin: Station_Record;
         Destination: Station_Record;
      end record;


end Train;
