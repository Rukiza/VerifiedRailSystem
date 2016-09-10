with Id_Handler; use Id_Handler;

package body Track
is

function Init_Track_Record (O: in Station_Record;
                            D: in Station_Record) return Track_Record is
      ((Track_ID => Get_ID,
        Origin => O,
        Destination => D));

end Track;
