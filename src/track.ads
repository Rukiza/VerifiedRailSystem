with Id_Handler;
with Station;

package Track
with SPARK_Mode => On
is

   type Track_Record is
      record
         Id: ID;
         Origin: Station_Record;
         Destination: Station_Record;
      end record;


end Track;
