//kOS Test 1

CD("0:/LOGS").
LIST FILES IN filelist.
FOR logfile IN filelist{
  IF logfile:NAME = "testlog.csv" {
    IF filelist:LENGTH > 99 {
      COPYPATH("0:/logs/testlog.csv", ("0:/logs/testlog_backup_" + (filelist:LENGTH) + ".csv")).
    }
    ELSE IF filelist:LENGTH <= 99 AND filelist:LENGTH > 9 {
      COPYPATH("0:/logs/testlog.csv", ("0:/logs/testlog_backup_0" + (filelist:LENGTH) + ".csv")).
    }
    ELSE IF filelist:LENGTH <= 9 {
      COPYPATH("0:/logs/testlog.csv", ("0:/logs/testlog_backup_00" + (filelist:LENGTH) + ".csv")).
    }
    logfile:CLEAR().}
}
PRINT filelist.
LOG "MISSION TIME,ALTITUDE,THROTTLLE %" TO "testlog.csv".
SWITCH TO 1.
  SET ST TO TIME:SECONDS.

UNTIL FALSE {
  SWITCH TO 0.
  SET MONVEL TO SHIP:VELOCITY:SURFACE.
  SET SHIP_ALT TO SHIP:ALTITUDE.
  SET SHIP_THROTTLE TO (THROTTLE * 100).
  LOG (TIME:SECONDS - ST) + "," + SHIP_ALT + "," + SHIP_THROTTLE TO "logs/testlog.csv".
  CLEARSCREEN.
  PRINT "TIME:     " + (TIME:SECONDS - ST).
  PRINT "ALTITUDE: " + SHIP_ALT.
  PRINT "THROTTLE: " + (SHIP_THROTTLE) + "%".
  SWITCH TO 1.
  WAIT 0.001.
}
