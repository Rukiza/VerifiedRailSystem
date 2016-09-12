package body Train
with SPARK_Mode => On
is
   function Init_Train_Record (s: Station_Record;
                               origin: Station_Record;
                               destination: Station_Record;
                               path: Train.Path_Array) return Train_Record
   is
     ((Current => s.Station_ID,
       Origin => origin,
       Destination => destination,
       Path => path,
       Marker => 1));

   function Init_Train_Record (t: Track_Record;
                               origin: Station_Record;
                               destination: Station_Record;
                               path: Train.Path_Array) return Train_Record
   is
     ((Current => t.Track_ID,
       Origin => origin,
       Destination => destination,
       Path => path,
       Marker => 1));


end Train;
