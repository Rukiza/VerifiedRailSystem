with Track;

package Station
with SPARK_Mode => On
is

   type Tracks_Array is array (Positive range <>) of Track.Track_Record;

   type Station_Record
     (Amount_Incomming: Positive;
      Amount_Outgoing: Positive) is
      record
         Incomming: Track.Tracks_Array (1 .. Amount_Incomming);
         Outgoing: Track.Tracks_Array (1 .. Amount_Outgoing);
      end record;

begin



end Station;
