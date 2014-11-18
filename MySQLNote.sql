[DB基本設定]
・サーバー起動
mysql.server start
mysqld start

※起動確認
ps ax | grep mysql

・サーバー停止
mysql.server stop
mysqld stop

・データベース作成
create database [database_name];

・データベース一覧
show databases;

・ユーザー作成
grant all on develop.* to 'cobot00'@'localhost';

・ユーザー確認
select host, user from mysql.user;

・パスワード変更
SET PASSWORD FOR cobot00@localhost=PASSWORD('pswd');

.権限確認
show grants;


[ユーティリティ]
・MySQLのバージョン確認
SELECT version()

・現在時刻取得
SELECT now(), current_date, current_time

・DDL
CREATE TABLE data_types(
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(32) NOT NULL,
    explanation VARCHAR(128),
    value DOUBLE(5, 2) NOT NULL DEFAULT 0,
    modified_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE multi_keys(
    id INT(11) DEFAULT 0 NOT NULL,
    id2 INT(11) DEFAULT 0 NOT NULL,
    unique_id INT(11) DEFAULT 0 NOT NULL,
    name VARCHAR(32) NOT NULL,
    explanation VARCHAR(128),
    modified_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

ALTER TABLE multi_keys ADD CONSTRAINT PRIMARY KEY(id, id2);
CREATE UNIQUE INDEX multi_keys_idx ON multi_keys (unique_id);
CREATE INDEX multi_keys_idx2 ON multi_keys (name);

ALTER TABLE multi_keys DROP PRIMARY KEY;

CREATE TABLE hoge_log(
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(32) NOT NULL,
    explanation VARCHAR(128),
    modified_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

・データディクショナリ
SELECT * FROM INFORMATION_SCHEMA.TABLES
ORDER BY table_schema, table_name

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY table_schema, table_name, column_name

SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
ORDER BY table_schema, table_name, constraint_name, ordinal_position

SELECT table_name, constraint_name, constraint_type
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE constraint_type IN ('PRIMARY KEY', 'UNIQUE')
ORDER BY table_name, constraint_name


・実践的なデータディクショナリ利用
SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE table_schema = 'develop'
AND   table_name like '%log%'
ORDER BY table_name

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE EXTRA = 'auto_increment'
ORDER BY table_schema, table_name, column_name

SELECT
  table_name, ordinal_position, column_name, data_type,
  column_default, is_nullable, character_maximum_length,
  numeric_precision, numeric_scale
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_schema = 'develop'
ORDER BY table_name, ordinal_position

SELECT table_name, constraint_name, ordinal_position, column_name
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE table_schema = 'develop'
ORDER BY table_name, constraint_name, ordinal_position

SELECT constraint_name, ordinal_position, column_name
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE table_name = 'data_types'
ORDER BY constraint_name, ordinal_position

SELECT kc.table_name, kc.constraint_name, kc.ordinal_position, kc.column_name, tc.constraint_type
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE KC
     INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS TC
             ON kc.table_name = tc.table_name AND kc.constraint_name = tc.constraint_name
WHERE kc.table_schema = 'develop'
ORDER BY kc.table_name, kc.constraint_name, kc.ordinal_position


SELECT table_name, constraint_name, constraint_type
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE constraint_type IN ('PRIMARY KEY', 'UNIQUE')
ORDER BY table_name, constraint_name


[MySQL Workbench]
・データベース作成
CREATE NEW [schma_name];
