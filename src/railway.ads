with Track; use Track;
with Station; use Station;
with Train; use Train;
with Id_Handler; use Id_Handler;
with Ada.Containers.Vectors; use Ada.Containers;
with Tracks_Array;
with Station_Array;
with Train_Array;

package Railway
--with SPARK_Mode => On
is



   Defualt_Station: Station.Station_Record := (Station_ID => ID'Last);
   Defualt_Path_Array: Train.Path_Array := (ID'Last,
                                            ID'Last,
                                            ID'Last,
                                            ID'Last,
                                            ID'Last,
                                            ID'Last);
   Defualt_Train: Train.Train_Record := (ID'Last,
                                         Defualt_Station,
                                         Defualt_Station,
                                         Defualt_Path_Array,
                                         Defualt_Path_Array'Last,
                                         True);
   Defualt_Track: Track.Track_Record := (ID'Last,
                                         Defualt_Station,
                                         Defualt_Station);

   type Tracks_A is array (Positive range <>) of Track.Track_Record;
   type Station_A is array (Positive range <>) of Station.Station_Record;
   type Train_A is array (Positive range <>) of Train.Train_Record;

   type Railway_Array_Record
     (TKA_Max : Positive;
      STA_Max : Positive;
      TNA_Max : Positive)
   is
      record
         TKA: Tracks_A (1..TKA_Max);
         STA: Station_A (1..STA_Max);
         TNA: Train_A (1..TNA_Max);
      end record;

   type Railway_Record is
      record
         TKA: Tracks_Array.Vector;
         STA: Station_Array.Vector;
         TNA: Train_Array.Vector;
      end record;

   function Verifiy_Train (r: in Railway_Array_Record) return Boolean
     with
       SPARK_Mode,
       Depends => (Verifiy_Train'Result => (r)),
       Post => (if not Verifiy_Train'Result then
                  (for some i in r.TNA'Range =>
                     (r.TNA(i).Current /= r.TNA(i).Origin.Station_ID or
                          r.TNA(i).Current
                      /= r.TNA(i).Path(r.TNA(i).Path'First) or
                          r.TNA(i).Origin.Station_ID
                      /= r.TNA(i).Path(r.TNA(i).Path'First))));

   --Checks all nodes are connected.
   function Verifiy (r: in Railway_Array_Record) return Boolean
     with
       SPARK_Mode => On,
       Depends => (Verifiy'Result => (r,Defualt_Station, Defualt_Track)),
   --Pre => ( Assumes nothing it true ),
     Post => (if Verifiy'Result
        then (for all i in r.TNA'Range =>
                  (for all j in r.TNA'Range =>
                       (if r.TNA(i).Current = r.TNA(j).Current
                              then
                                i = j))) and
             (for all i in r.TKA'Range =>
                (r.TKA(i).Origin /= r.TKA(i).Destination)));

   function Pathed (TKA: Tracks_A;
                    STA: Station_A;
                    Path: Train.Path_Array) return Boolean
     with SPARK_Mode,
     Depends => (Pathed'Result => (TKA,
                                   STA,
                                   Path,
                                   Defualt_Station,
                                   Defualt_Track)),
     --Pre => (),
     Post => (if Pathed'Result then
                (for all i in Path'Range =>
                     (for some j in STA'Range =>
                          (Path(i) = STA(j).Station_ID) xor
                        (for some j in TKA'Range =>
                           (Path(i) = TKA(j).Track_ID)))));

   function Connected (TKA: Tracks_A;
                       STA: Station_A;
                       Node: Station.Station_Record) return Boolean
     with SPARK_Mode,
     Depends => (Connected'Result => (TKA, STA, Node, Defualt_Station)),
     Post => (if Connected'Result then
                (for some i in STA'Range =>
                     (for some j in TKA'Range =>
                          (TKA(j).Destination = STA(i) and
                                 TKA(j).Origin = Node))));
--  (if Connected'Result then
--                  (for all i in STA'Range =>
--                    (for some j in G_Marked'Range =>
--                         STA(i) = G_Marked(j) and G_Marked(j) /= Defualt_Station)));
--

     procedure Tick (r: in out Railway_Array_Record)
     with
       SPARK_Mode,
       Depends => (r => (r, Defualt_Train)),
       Pre => ( --Checks that current locations are unique.
                  for all i in r.TNA'Range =>
                    (for all j in r.TNA'Range =>
                       (if r.TNA(i).Current = r.TNA(j).Current
                            then
                              i = j))),
         Post => ( --Checks that current locations are unique.
                     for all i in r.TNA'Range =>
                       (for all j in r.TNA'Range =>
                          (if r.TNA(i).Current = r.TNA(j).Current
                               then
                                 i = j)));

   --INISILIZATION

   function Init return Railway_Record
     with
       Post => (Tracks_Array.Length(Init'Result.TKA) = 0 and
                      Station_Array.Length(Init'Result.STA) = 0 and
                      Train_Array.Length(Init'Result.TNA) = 0);

   function Init_Record (r: in Railway_Record) return Railway_Array_Record;

   function Init_Track_Array return Tracks_Array.Vector;

   function Init_Station_Array return Station_Array.Vector;

   function Init_Train_Array return Train_Array.Vector;

   --List Fucntions

   procedure Add_To_Array (TKA : in out Tracks_Array.Vector;
                           Item: in Track.Track_Record);

   procedure Add_To_Array(STA : in out Station_Array.Vector;
                          Item: in Station.Station_Record);

   procedure Add_To_Array (TNA : in out Train_Array.Vector;
                           Item: in Train.Train_Record);

end Railway;
