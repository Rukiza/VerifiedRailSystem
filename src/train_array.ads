--pragma SPARK_Mode;
with Train; use Train;
with Ada.Containers.Vectors; use Ada.Containers;

package Train_Array
is new Vectors (Positive, Train_Record);
