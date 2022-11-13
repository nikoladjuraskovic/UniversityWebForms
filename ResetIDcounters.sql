
/* Ovim naredbama se resetuje brojac ID-a u bazi na navedenoj tabeli.
Posle RESEED ide novi pocetni ID
https://www.geeksforgeeks.org/how-to-reset-identity-column-values-in-sql/

Za proveru brojaca ID-a: DBCC CHECKIDENT('ime_tabele');
https://www.databasestar.com/reset-identity-column/
*/

/*postavlja da svaki sledeci ID bude 1*/
DBCC CHECKIDENT ('Students', RESEED, 0);
DBCC CHECKIDENT ('Courses', RESEED, 0);
DBCC CHECKIDENT ('Exams', RESEED, 0);