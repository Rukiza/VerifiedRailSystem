with Track; use Track;
with Station; use Station;
WITH Train; use Train;
with Ada.Text_IO; use Ada.Text_IO;
package body Railway
--with SPARK_Mode => On
is
   function Verifiy_Train (r: in Railway_Array_Record) return Boolean
     with
       SPARK_Mode
   is
   begin
      -- Ensures that current is appropreately places
      if (for some i in r.TNA'Range =>
            (r.TNA(i).Current /= r.TNA(i).Origin.Station_ID or
                 r.TNA(i).Current
             /= r.TNA(i).Path(r.TNA(i).Path'First) or
                 r.TNA(i).Origin.Station_ID
             /= r.TNA(i).Path(r.TNA(i).Path'First))) then
         return False;
      end if;
      return True;
   end Verifiy_Train;

   function Verifiy (r: in Railway_Array_Record) return Boolean
     with SPARK_Mode
   is
   begin

      -- Tracks are not alowed the same section.
      if (for some i in r.TKA'Range =>
            (r.TKA(i).Origin = r.TKA(i).Destination)) then
         return False;
      end if;

      -- Checks connectivity.
      for N of r.STA loop
         if not Connected(r.TKA, r.STA, N) then
            return False;
         end if;
         --Put_Line("");
         pragma Assert (Connected(r.TKA, r.STA, N));
      end loop;

      pragma Assert (for all i in r.TKA'Range =>
                       (r.TKA(i).Origin /= r.TKA(i).Destination));
      -- Checks no train is on the same track as another train.
      for T of r.TNA loop
         if not Pathed(r.TKA, r.STA, T.Path) then
            --Put_Line("Should not get here.");
            return False;
         end if;
      end loop;

      if (for all i in r.TNA'Range =>
            (for all j in r.TNA'Range =>
               (if r.TNA(i).Current = R.TNA(j).Current then i = j))) then

         return True;
      end if;

      return False;
   end Verifiy;

   function Pathed (TKA: Tracks_A;
                    STA: Station_A;
                    Path: Train.Path_Array) return Boolean
     with SPARK_Mode
   is
      s: Station.Station_Record := Defualt_Station;
      t: Track.Track_Record := Defualt_Track;
   begin
      -- First Path must be a station.
      if (for some i in STA'Range =>
            (Path(Path'First)) = STA(i).Station_ID) then
         for i of STA loop
            if Path(Path'First) = i.Station_ID then
               s := i;
            end if;
         end loop;
      else
         return False;
      end if;
      pragma Assert (for some i in STA'Range =>
            (Path(Path'First)) = STA(i).Station_ID);

      -- Second can be a station or a track.
      -- Put_Line("Path point to path");
      for p in Path'First+1..Path'Last loop
         if (for some i in TKA'Range =>
               (Path(p) = TKA(i).Track_ID)) then
            for i in TKA'Range loop
               if Path(p) = TKA(i).Track_ID then
                  t := TKA(i);
                  if t.Origin /= s then
                     return False;
                  end if;
               end if;
            end loop;
         elsif (for some i in STA'Range =>
                  (Path(p) = STA(i).Station_ID)) then
            for i of STA loop
               if Path(p) = i.Station_ID then
                  if i = s then
                     s := i;
                  elsif t.Destination = i then
                     s := i;
                  else
                     return False;
                  end if;
               end if;
         end loop;
         else
            return false;
         end if;
      end loop;
      return true;
   end Pathed;

   function Connected (TKA: Tracks_A;
                       STA: Station_A;
                       Node: Station.Station_Record) return Boolean
     with SPARK_Mode
   is
      Stack: Station_A(1..STA'Length) := (others => Defualt_Station);
      S_P: Positive := 1;
      S_Size: Natural := 0;
      Marked: Station_A(1..STA'Length) := (others => Defualt_Station);
      M_P: Positive := 1;
      M_Size: Natural := 0;
      Temp: Station.Station_Record;
      G_Marked: Station_A(1..STA'Length) with Ghost;
   begin
      if STA'Length > 0 then
         Marked(M_P) := Node; --(STA'Range)'Next()
         M_P := M_P + 1;
         M_Size := M_Size + 1;
         Stack(S_P) := Node;
         S_P := S_P + 1;
         S_Size := S_Size + 1;
         --pragma Loop_Invariant (S_P = S_Size + 1);
         pragma Assert (S_P -1 = S_Size);
         while S_Size > 0 and S_P > 1 and
           S_Size < Natural'Last and S_P < Positive'Last and
           M_Size < Natural'Last and M_P < Positive'Last and
           S_P in Stack'Range and
           M_P in Marked'Range
         loop

            pragma Loop_Invariant (S_P - 1= S_Size);
            Temp := Stack(S_P-1); -- Needs to be this way.
            S_P := S_P - 1;
            S_Size := S_Size - 1;
            for N of TKA loop
               --Put_Line(N.Origin.Station_ID'IMAGE);
               if N.Origin = Temp and
                 (for all i in Marked'Range => Marked(i) /= N.Destination) and
                 S_Size < Natural'Last and S_P < Positive'Last and
                 M_Size < Natural'Last and M_P < Positive'Last and
                 S_P in Stack'Range and
                 M_P in Marked'Range
               then
                  --Put_Line("Should be checking");
                  Stack(S_P) := N.Destination;
                  S_P := S_P + 1;
                  S_Size := S_Size + 1;
                  --pragma Loop_Invariant (S_P - 1= S_Size);
                  pragma Assert (Natural(S_P - 1) = S_Size);
                  Marked(M_P) := N.Destination;
                  M_P := M_P + 1;
                  M_Size := M_Size + 1;
                  --pragma Loop_Invariant (S_P - 1= S_Size);
                  pragma Assert (Natural(S_P - 1) = S_Size);
               end if;
               pragma Loop_Invariant (S_P - 1= S_Size);
            end loop;
         end loop;
         G_Marked := Marked;
         --Put_Line("Things should be connected");
         return (for all i in STA'Range =>
                   (for some j in Marked'Range =>
                      STA(i) = Marked(j) and Marked(j) /= Defualt_Station));
      end if;
      --pragma ;

      --Unreachable in the normal running.
      return false;
   end Connected;

   procedure Tick (r: in out Railway_Array_Record)
     with SPARK_Mode
   is
      Trans: Train_A(r.TNA'Range) := (others => Defualt_Train);
   begin
      pragma Assert (for all i in r.TNA'Range =>
                       (for all j in r.TNA'Range =>
                          (if r.TNA(i).Current = r.TNA(j).Current
                           then
                              i = j)));
      for i in r.TNA'Range loop
         Trans(i) := r.TNA(i);
         if Positive'Last > Trans(i).Marker and
         then (Trans(i).Marker + 1) in Trans(i).Path'Range then
            pragma Assert (Trans(i) = r.TNA(i));
            Trans(i).Marker := Trans(i).Marker + 1;
            Trans(i).Current := Trans(i).Path(Trans(i).Marker);
         end if;
      end loop;
      if (for all i in Trans'Range =>
            (for all j in Trans'Range =>
               (if Trans(i).Current = Trans(j).Current then i = j))) then
         r.TNA := Trans;
      end if;
      pragma Assert (for all i in r.TNA'Range =>
                       (for all j in r.TNA'Range =>
                          (if r.TNA(i).Current = r.TNA(j).Current
                           then
                              i = j)));
   end Tick;

   function Init return Railway_Record
   is ((Init_Track_Array, Init_Station_Array, Init_Train_Array));

   --Converts the creation fromat to a provable format.
   function Init_Record (r: Railway_Record) return Railway_Array_Record is
      TKA: Tracks_A( 1..Standard.Integer(Tracks_Array.Length(r.TKA)));
      I_TKA: Positive := 1;
      C_TKA: Tracks_Array.Cursor;
      STA: Station_A( 1..Standard.Integer(Station_Array.Length(r.STA)));
      I_STA: Positive := 1;
      C_STA: Station_Array.Cursor;
      TNA: Train_A(1..Standard.Integer(Train_Array.Length(r.TNA)));
      I_TNA: Positive := 1;
      C_TNA: Train_Array.Cursor;
   begin
      C_TKA := Tracks_Array.First(r.TKA);
      C_STA := Station_Array.First(r.STA);
      C_TNA := Train_Array.First(r.TNA);
      --Put_Line(Tracks_Array.Length(r.TKA)'Image);

      while Tracks_Array.Has_Element(C_TKA) and I_TKA in TKA'Range loop
         TKA(I_TKA) := Tracks_Array.Element(C_TKA);
         Tracks_Array.Next(C_TKA);
         I_TKA := I_TKA + 1;
      end loop;

      while Station_Array.Has_Element(C_STA) and I_STA in STA'Range loop
         STA(I_STA) := Station_Array.Element(C_STA);
         Station_Array.Next(C_STA);
         I_STA := I_STA + 1;
      end loop;

      while Train_Array.Has_Element(C_TNA) and I_TNA in TNA'Range loop
         TNA(I_TNA) := Train_Array.Element(C_TNA);
         Train_Array.Next(C_TNA);
         I_TNA := I_TNA + 1;
      end loop;
      --if TKA'Length /= 0 and STA'Length /= 0 and TNA'Length /= 0 then
      return (TKA'Length, STA'Length, TNA'Length, TKA, STA, TNA);
      --elsif

      --end if
   end Init_Record;

   function Init_Track_Array return Tracks_Array.Vector is
      r : Tracks_Array.Vector;
   begin
      return r;
   end Init_Track_Array;

   function Init_Station_Array return Station_Array.Vector is
      r : Station_Array.Vector;
   begin
      return r;
   end Init_Station_Array;

   function Init_Train_Array return Train_Array.Vector is
      r : Train_Array.Vector;
   begin
      return r;
   end Init_Train_Array;

   --List Fucntions

   procedure Add_To_Array (TKA : in out Tracks_Array.Vector;
                           Item: in Track.Track_Record) is
   begin
      Tracks_Array.Append(TKA, Item);
   end Add_To_Array;

   procedure Add_To_Array(STA : in out Station_Array.Vector;
                          Item: in Station.Station_Record) is
   begin
      Station_Array.Append(STA, Item);
   end Add_To_Array;

   procedure Add_To_Array (TNA : in out Train_Array.Vector;
                           Item: in Train.Train_Record) is
   begin
      Train_Array.Append(TNA, Item);
   end Add_To_Array;


end Railway;
