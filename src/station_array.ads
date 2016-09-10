--pragma SPARK_Mode;
with Station; use Station;
with Ada.Containers.Vectors; use Ada.Containers;

package Station_Array is new Vectors (Positive, Station_Record);
