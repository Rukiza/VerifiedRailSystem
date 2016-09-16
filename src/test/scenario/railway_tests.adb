with Railway;
with Station;
with Train;
with Track;
with Id_Handler; use Id_Handler;
with Ada.Text_IO; use Ada.Text_IO;
with AUnit.Assertions; use AUnit.Assertions;


package body Railway_Tests is

   procedure Set_Up_Case (T: in out TC) is
      pragma Unreferenced (T);
   begin
      null;
   end Set_Up_Case;


   procedure Set_Up (T : in out TC) is
   begin
      null;
   end;

   procedure Tear_Down (T : in out TC) is
   begin
      null;
   end;

   procedure Tear_Down_Case (T : in out TC) is
   begin
      null;
   end;

   --==========================================================
   --               Helper Methods.
   --==========================================================

   --     procedure Helper_After_Nozzle_Lifted (p: Fuel_Type) is
   --     begin
   --        Pump_Unit.Lift_Nozzle(Input_1, p);
   --     end Helper_After_Nozzle_Lifted;
   --
   --     procedure Helper_After_Start_Pumping (a: Litre) is
   --     begin
   --        Pump_Unit.Start_Pumping(Input_1, a, Input_2);
   --     end Helper_After_Start_Pumping;

   -- ===========================================================
   --                 TEST CASES/SCENARIOS
   -- ===========================================================

   procedure Verify_1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s2,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     s2.Station_ID,
                                     s2.Station_ID,
                                     s2.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin
         Assert (Condition => (Railway.Verifiy(l)),
                 Message => "Input should be verifyable");
      end ;


   end Verify_1;

   procedure Verify_2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s2,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     s2.Station_ID,
                                     s2.Station_ID,
                                     s2.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TNA, t1);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin
         Assert (Condition => (not Railway.Verifiy(l)),
                 Message => "Input should not be verifyable");
      end ;


   end Verify_2;

   procedure Verify_3 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      t2 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     tr3.Track_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      t2 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     tr3.Track_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      Railway.Add_To_Array(m.TNA, t2);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin

         Assert (Condition => (not Railway.Verifiy(l)),
                 Message => "Input should verifyable and Tick");

      end ;
   end Verify_3;

   procedure Verify_4 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     tr3.Track_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin

         Assert (Condition => (Railway.Verifiy(l)),
                 Message => "Input should verifyable and Tick");

      end ;
   end Verify_4;

   procedure Verify_5 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      tr4 := Track.Init_Track_Record(s3,s3);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     tr3.Track_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin

         Assert (Condition => (not Railway.Verifiy(l)),
                 Message => "Input should verifyable and Tick");

      end ;
   end Verify_5;

   procedure Verify_6 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     s3.Station_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin

         Assert (Condition => (not Railway.Verifiy(l)),
                 Message => "Input should verifyable and Tick");

      end ;
   end Verify_6;

   procedure Pathed_1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (tr1.Track_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     s3.Station_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin

         Assert (Condition => (not Railway.Verifiy(l)),
                 Message => "Input should verifyable and Tick");

      end ;
   end Pathed_1;

   procedure Pathed_2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     tr4.Track_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin

         Assert (Condition => (not Railway.Verifiy(l)),
                 Message => "Input should verifyable and Tick");

      end ;
   end Pathed_2;

   procedure Pathed_3 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     ID'Last,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin

         Assert (Condition => (not Railway.Verifiy(l)),
                 Message => "Input should verifyable and Tick");

      end ;
   end Pathed_3;

   procedure Tick_1 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     tr3.Track_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin
         if Railway.Verifiy(l) then
            Assert (Condition => ( l.TNA(1).Current = s1.Station_ID ),
                 Message => "Input should not have moved yet.");
            Railway.Tick(l);
            Assert (Condition => ( l.TNA(1).Current = tr1.Track_ID),
                 Message => "Input should have moved after Tick");
         else
            Assert (Condition => ( false ),
                 Message => "Input should verifyable and Tick");
         end if;

      end ;


   end Tick_1;

   procedure Tick_2 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     tr3.Track_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin
         if Railway.Verifiy(l) then
            Assert (Condition => ( l.TNA(1).Current = s1.Station_ID ),
                 Message => "Input should not have moved yet.");
            Railway.Tick(l);
            Assert (Condition => ( l.TNA(1).Current = tr1.Track_ID ),
                    Message => "Input should have moved after Tick");
            Railway.Tick(l);
            Assert (Condition => ( l.TNA(1).Current = s2.Station_ID ),
                    Message => "Input should have moved after Tick");
            Railway.Tick(l);
            Assert (Condition => ( l.TNA(1).Current = tr3.Track_ID ),
                    Message => "Input should have moved after Tick");
            Railway.Tick(l);
            Assert (Condition => ( l.TNA(1).Current = s3.Station_ID ),
                    Message => "Input should have moved after Tick");
            Railway.Tick(l);
            Assert (Condition => ( l.TNA(1).Current = s3.Station_ID ),
                    Message => "Input should have moved after Tick");
         else
            Assert (Condition => ( false ),
                 Message => "Input should verifyable and Tick");
         end if;

      end ;
   end Tick_2;

   procedure Tick_3 (CWTC : in out AUnit.Test_Cases.Test_Case'Class) is
      m : Railway.Railway_Record := Railway.Init;
      s1 : Station.Station_Record;
      s2 : Station.Station_Record;
      s3 : Station.Station_Record;
      t1 : Train.Train_Record;
      t2 : Train.Train_Record;
      tr1 : Track.Track_Record;
      tr2 : Track.Track_Record;
      tr3 : Track.Track_Record;
      tr4 : Track.Track_Record;
   begin
      s1 := Station.Init_Station_Record;
      s2 := Station.Init_Station_Record;
      s3 := Station.Init_Station_Record;
      tr1 := Track.Init_Track_Record(s1,s2);
      tr2 := Track.Init_Track_Record(s2,s1);
      tr3 := Track.Init_Track_Record(s2,s3);
      tr4 := Track.Init_Track_Record(s3,s2);
      t1 := Train.Init_Train_Record(s1,
                                    s1,
                                    s3,
                                    (s1.Station_ID,
                                     tr1.Track_ID,
                                     s2.Station_ID,
                                     tr3.Track_ID,
                                     s3.Station_ID,
                                     s3.Station_ID),
                                    true);
      t2 := Train.Init_Train_Record(s2,
                                    s2,
                                    s2,
                                    (s2.Station_ID,
                                     s2.Station_ID,
                                     s2.Station_ID,
                                     s2.Station_ID,
                                     s2.Station_ID,
                                     s2.Station_ID),
                                    true);
      Railway.Add_To_Array(m.STA,s1);
      Railway.Add_To_Array(m.STA,s2);
      Railway.Add_To_Array(m.STA,s3);
      Railway.Add_To_Array(m.TKA, tr1);
      Railway.Add_To_Array(m.TKA, tr2);
      Railway.Add_To_Array(m.TKA, tr3);
      Railway.Add_To_Array(m.TKA, tr4);
      Railway.Add_To_Array(m.TNA, t1);
      Railway.Add_To_Array(m.TNA, t2);
      --Railway.Init(m);
      declare
         l : Railway.Railway_Array_Record := Railway.Init_Record(m);
      begin
         if Railway.Verifiy(l) then
            Assert (Condition => ( l.TNA(1).Current = s1.Station_ID ),
                 Message => "Input should not have moved yet.");
            Railway.Tick(l);
            Assert (Condition => ( l.TNA(1).Current = tr1.Track_ID ),
                    Message => "Input should not have moved after Tick");
            Railway.Tick(l);
            Assert (Condition => ( l.TNA(1).Current = tr1.Track_ID ),
                    Message => "Input should not have moved after Tick");
         else
            Assert (Condition => ( false ),
                 Message => "Input should verifyable and Tick");
         end if;

      end ;
   end Tick_3;

   --==========================================================
   --               REGISTRATION/NAMING
   --==========================================================

   procedure Register_Tests (T: in out TC) is
      use AUnit.Test_Cases.Registration;
   begin
      Register_Routine (Test => T,
                        Routine => Verify_1'Access,
                        Name => "Verify 1");
      Register_Routine (Test => T,
                        Routine => Verify_2'Access,
                        Name => "Verify 2");
      Register_Routine (Test => T,
                        Routine => Verify_3'Access,
                        Name => "Verify 3");
      Register_Routine (Test => T,
                        Routine => Verify_4'Access,
                        Name => "Verify 4");
      Register_Routine (Test => T,
                        Routine => Verify_5'Access,
                        Name => "Verify 5");
      Register_Routine (Test => T,
                        Routine => Verify_6'Access,
                        Name => "Verify 6");
      Register_Routine (Test => T,
                        Routine => Pathed_1'Access,
                        Name => "Pathed 1");
      Register_Routine (Test => T,
                        Routine => Pathed_2'Access,
                        Name => "Pathed 2");
      Register_Routine (Test => T,
                        Routine => Pathed_3'Access,
                        Name => "Pathed 3");
      Register_Routine (Test => T,
                        Routine => Tick_1'Access,
                        Name => "Tick_1");
      Register_Routine (Test => T,
                        Routine => Tick_2'Access,
                        Name => "Tick_2");
      Register_Routine (Test => T,
                        Routine => Tick_3'Access,
                        Name => "Tick_3");

   end Register_Tests;

   function Name (T: TC) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("Tests: Standard Tests");
   end Name;

end Railway_Tests;
