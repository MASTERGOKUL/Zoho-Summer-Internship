sudo mysqlslap --host=localhost --user=root --password=password --delimiter=";" --create="CREATE TABLE a (b int);INSERT INTO a VALUES (23);UPDATE a SET b = 42" --query="SELECT * FROM a" --concurrency=50 --iterations=200

#sudo mysqlslap --host=localhost --user=root --password=password --concurrency=500 --iterations=1 --number-int-cols=20 --number-char-cols=30 --auto-generate-sql
