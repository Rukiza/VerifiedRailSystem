with Id_Handler;
with Track;

package Station
with SPARK_Mode => On
is

   type Station_Record is
      record
         Id: ID;
      end record;

begin

   function Init_Station_Record () return Station_Record;


end Station;
