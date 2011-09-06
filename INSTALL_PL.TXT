Instalacja systemu jHelpDesk przebiega stosunkowo prosto. Postępując według
poniższych wskazówek, uda się to zrobić w kilka minut.

Krok 1.
Przygotowujemy bazę danych dla systemu. Do wyboru mamy kilka możliwości:
 * PostgreSQL 8.3 lub nowszą (domyślny wybór developerów)
 * MySQL
 * Firebird 2.x lub nowszy
 * MS SQL
W zależności od dokonanego wyboru będziemy musieli dostarczyć właściwe biblioteki
do aplikacji (wszystkie znajdują się domyślnie w katalogu WEB-INF/lib/) i odpowiednio
skonfigurować informacje o źródle danych w aplikacji.
Przypadek 1 - wybraliśmy system PostgreSQL, baza danych nazywa się 'jhd', użytkownik i hasło także,
 serwer, na którym znajduje się baza danych to 192.168.1.110
 * odszukujemy plik db.properties i upewniamy się, że jego zawartość
   ma następującą postać (^ to znak początku linii):

   ^dataSource.driverClassName=org.postgresql.Driver
   ^dataSource.url=jdbc:postgresql://192.168.1.110:5432/jhd
   ^dataSource.username=jhd
   ^dataSource.password=jhd
   ^dataSource.defaultAutoCommit=false

Przypadek 2 - wybraliśmy system Firebird, baza do jhd, użytkownik i hasło także,
 serwer to 192.168.0.121
 * zawartość pliku db.properties tym razem powinna wyglądać następująco (^ to znak początku linii):

   ^dataSource.driverClassName=***************
   ^dataSource.url=jdbc:****://*************/jhd
   ^dataSource.username=jhd
   ^dataSource.password=jhd
   ^dataSource.defaultAutoCommit=false

Przypadek 3 - nasz baza danych to MySQL, dane podobnie jak w przypadku bazy PostgreSQL, i tym razem
sięgamy do pliku db.properties nadając mu poniższą postać:

   ^dataSource.driverClassName=org.mysql????.Driver
   ^dataSource.url=jdbc:mysql://192.168.1.110/jhd
   ^dataSource.username=jhd
   ^dataSource.password=jhd
   ^dataSource.defaultAutoCommit=false

Przypadek 4 - do dyspozycj mamy bazę MS SQL Server 2000 lub nowszą.

D*****************
D*****************
D*****************
D*****************
D*****************

Krok 2.

ustawiena z pliku application.properties