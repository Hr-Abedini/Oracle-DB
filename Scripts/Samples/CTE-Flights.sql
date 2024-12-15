--Common Table Expressions

WITH
  Flights (Source, Destin, Flight_time)
  AS (SELECT 'San jose',
             'Los Angeles',
             1.3
      FROM Dual
        UNION
      SELECT 'New york',
             'boston',
             1.1
      FROM Dual
        UNION
      SELECT 'Los Angeles',
             'New york',
             5.8
      FROM Dual),
  Reachable_From (LVL, Source, Destin, Destin_Prev, TotalFlightTime)
  AS (SELECT 1,
             Source,
             Destin,
             NULL,
             Flight_time
      FROM Flights
        UNION ALL
      SELECT INCOMING.LVL + 1 AS LVL,
             INCOMING.Source,
             OUTGOING.Destin,
             INCOMING.Destin,
             INCOMING.Totalflighttime + OUTGOING.Flight_time
      FROM Reachable_From INCOMING,
           Flights OUTGOING
      WHERE INCOMING.Destin = OUTGOING.Source)


SELECT LVL,
       Source,
       Destin,
       Destin_Prev,
       TotalFlightTime
FROM Reachable_From
ORDER BY 1;