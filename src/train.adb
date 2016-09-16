package body Train
with SPARK_Mode => On
is
   function Init_Train_Record (s: Station_Record;
                               origin: Station_Record;
                               destination: Station_Record;
                               path: Train.Path_Array;
                               on_track: Boolean) return Train_Record
   is
     ((Current => s.Station_ID,
       Origin => origin,
       Destination => destination,
       Path => path,
       Marker => 1,
       On_Track => on_track));


end Train;
