with Track;

package Station
with SPARK_Mode => On
is

   type Tracks_Array is array (Positive range <>) of Track.Track_Record;

   type Station_Record
     (Amount_Incomming: Positive;
      Amount_Outgoing: Positive) is
      record
         Incomming: Tracks_Array (1 .. Amount_Incomming);
         Outgoing: Tracks_Array (1 .. Amount_Outgoing);
      end record;

begin

   function Init_Station_Record (In: Track_Array;
                                 Out: Track_Array) return Station_Record;


end Station;
