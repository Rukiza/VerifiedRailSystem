with Track;
with Station;
with Train;

package Railway
with SPARK_Mode => On
is

   type Tracks_Array is array (Positive range <>) of Track.Track_Record;
   type Station_Array is array (Positive range <>) of Station.Station_Record;
   type Train_Array is array (Positive range <>) of Train.Train_Record;


end Railway;
