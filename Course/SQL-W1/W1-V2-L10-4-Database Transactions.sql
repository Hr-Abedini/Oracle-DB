--============================================================
-- **********  Database Transactions
--============================================================
/*
A database transaction consists of one of the following:
    • DML statements that constitute one consistent change to the data
    • One DDL statement
    • One data control language (DCL) statement

Transaction Types:
Type                               Description
----------------------------------------------------------------------------------------------
Data manipulation language 	(DML)   Consists of any number of DML statements that the Oracle
                                   	server treats as a single entity or a logical unit of work

Data definition language 	(DDL)   Consists of only one DDL statement

Data control language		(DCL)   Consists of only one DCL statement 


Database Transactions: Start and End
    • Begin when the first DML SQL statement is executed.
    • End with one of the following events:
            – A COMMIT or ROLLBACK statement is issued.
            – A DDL or DCL statement executes (automatic commit).
            – The user exits SQL Developer or SQL*Plus.
            – The system crashes.

------------------------------------------------ Explicit Transaction Control Statements

You can control the logic of transactions by using the 
    COMMIT, SAVEPOINT, and ROLLBACK
statements.

------------------------------------------------ Rolling Back Changes to a Marker
UPDATE...
SAVEPOINT update_done;


INSERT...
ROLLBACK TO update_done;

------------------------------------------------ Implicit Transaction Processing
    • An automatic commit occurs in the following circumstances:
        – A DDL statement issued
        – A DCL statement issued
        – Normal exit from SQL Developer or SQL*Plus, 
            without explicitly issuing COMMIT or ROLLBACK statements
            
    • An automatic rollback occurs when there is an abnormal
        termination of SQL Developer or SQL*Plus or a system failure.

------------------------------------------------ State of Data Before COMMIT or ROLLBACK
    • The previous state of the data can be recovered.
    • The current session can review the results of the DML operations by using the SELECT statement.
    • Other sessions cannot view the results of the DML   statements issued by the current session.
    • The affected rows are locked; other session cannot change the data in the affected rows.

------------------------------------------------ State of Data After COMMIT
    • Data changes are saved in the database.
    • The previous state of the data is overwritten.
    • All sessions can view the results.
    • Locks on the affected rows are released; those rows are available for other sessions to manipulate.
    • All savepoints are erased.

*/
------------------------------------------------ Committing Data
DELETE FROM Employees
WHERE Employee_id = 113;

INSERT INTO Departments
VALUES
   (
     290,
     'Corporate Tax',
     NULL,
     1700
   );

COMMIT;
------------------------------------------------ State of Data After ROLLBACK
/*
Discard all pending changes by using the ROLLBACK statement:
    • Data changes are undone.
    • Previous state of the data is restored.
    • Locks on the affected rows are released.
*/
DELETE FROM Copy_emp;
ROLLBACK;

------------------
DELETE FROM Test; -- 4 rows deleted.
ROLLBACK; --Rollback complete.
------------------
DELETE FROM Test
WHERE Id = 100; -- 1 ROW deleted.

SELECT *
FROM Test
WHERE Id = 100; -- No rows selected. 
COMMIT; --COMMIT complete.

------------------------------------------------ Statement-Level Rollback
/*
• If a single DML statement fails during execution, only that statement is rolled back.
• The Oracle server implements an implicit savepoint.
• All other changes are retained.
• The user should terminate transactions explicitly by executing a COMMIT or ROLLBACK statement.
*/

