--pragma SPARK_Mode;
with Track; use Track;
with Ada.Containers.Vectors; use Ada.Containers;


package Tracks_Array
is new Vectors (Positive, Track_Record);
