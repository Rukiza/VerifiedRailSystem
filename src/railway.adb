with Track; use Track;
with Station; use Station;
WITH Train; use Train;

package body Railway
--with SPARK_Mode => On
is

   function Verifiy (r: in Railway_Array_Record) return Boolean
     with SPARK_Mode
   is
   begin
      for N of r.STA loop
         if not Connected(r.TKA, r.STA, N) then
            return False;
         end if;
         pragma Assert (Connected(r.TKA, r.STA, N));
      end loop;
      if (for all i in r.TNA'Range =>
            (for all j in r.TNA'Range =>
               (if r.TNA(i).Current = R.TNA(j).Current then i = j))) then
         return True;
      end if;
      return False;
   end Verifiy;

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
   begin
      if STA'Length > 0 then
         Marked(M_P) := Node; --(STA'Range)'Next()
         M_P := M_P + 1;
         M_Size := M_Size + 1;
         Stack(S_P) := Node;
         S_P := S_P + 1;
         S_Size := S_Size + 1;
         pragma Assert (S_P = S_Size + 1);
         while S_Size > 0 and S_P > 1 and
           S_Size < Natural'Last and S_P < Positive'Last and
           M_Size < Natural'Last and M_P < Positive'Last and
           S_P in Stack'Range and
           M_P in Marked'Range
         loop
            --pragma Assert (S_P = S_Size + 1);
            Temp := Stack(S_P);
            S_P := S_P - 1;
            S_Size := S_Size - 1;
            --pragma Assert (S_P = S_Size + 1);
            for N of TKA loop
               if N.Origin = Temp and
                 (for all i in Marked'Range => Marked(i) /= N.Destination) and
                 S_Size < Natural'Last and S_P < Positive'Last and
                 M_Size < Natural'Last and M_P < Positive'Last and
                 S_P in Stack'Range and
                 M_P in Marked'Range
               then
                  Stack(S_P) := N.Destination;
                  S_P := S_P + 1;
                  S_Size := S_Size + 1;
                  --pragma Assert (Natural(S_P - 1) = S_Size);
                  Marked(M_P) := N.Destination;
                  M_P := M_P + 1;
                  M_Size := M_Size + 1;
               end if;
            end loop;
         end loop;
         return (for all i in STA'Range =>
                   (for some j in Marked'Range =>
                      STA(i) = Marked(j) and Marked(j) /= Defualt_Station));
      end if;
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

   procedure Connect (r: in out Railway_Record;
                      s1: in Station.Station_Record;
                      s2: in Station.Station_Record) is
   begin
      Tracks_Array.Append(r.TKA, Track.Init_Track_Record(s1, s2));
      Tracks_Array.Append(r.TKA, Track.Init_Track_Record(s2, s1));
   end Connect;

   function Init return Railway_Record
   is ((Init_Track_Array, Init_Station_Array, Init_Train_Array));

   --Converts the creation fromat to a provable format.
   function Init (r: Railway_Record) return Railway_Array_Record is
      TKA: Tracks_A( 1..Positive(Tracks_Array.Length(r.TKA)));
      I_TKA: Positive := 1;
      C_TKA: Tracks_Array.Cursor;
      STA: Station_A( 1..Positive(Station_Array.Length(r.STA)));
      I_STA: Positive := 1;
      C_STA: Station_Array.Cursor;
      TNA: Train_A(1..Positive(Train_Array.Length(r.TNA)));
      I_TNA: Positive := 1;
      C_TNA: Train_Array.Cursor;
   begin
      C_TKA := Tracks_Array.First(r.TKA);
      C_STA := Station_Array.First(r.STA);
      C_TNA := Train_Array.First(r.TNA);

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

      return (TKA'Length, STA'Length, TNA'Length, TKA, STA, TNA);
   end Init;

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
