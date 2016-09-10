package body Railway
with SPARK_Mode => On
is

   function Verifiy (r: in Railway_Array_Record) return Boolean
   is
   begin
      return false;
   end Verifiy;

   procedure Tick (r: in out Railway_Array_Record) is
   begin
      null;
   end Tick;

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
