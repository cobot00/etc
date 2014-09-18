SQLite覚書

[シェル実行方法]
・起動
sqlite3 (database_faile_path)

※パス指定しない場合はコマンド実行ディレクトリ下にDBファイルが作成される

・終了
.quit

[各種コマンド]
・テーブル一覧
.table

[列型]
INTEGER: 符号付整数。1、2、3、4、6 or 8 バイトで格納。
REAL: 浮動小数点数。8バイトで格納。
TEXT: UTF-8、 UTF-16BE or UTF-16-LEのいずれかで格納。
BLOB : Binary Large OBject。入力データをそのまま格納。
NULL: NULL値

[DDL]
CREATE TABLE data_types(
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    explanation TEXT,
    value REAL NOT NULL DEFAULT 0,
    create_at TIMESTAMP  DEFAULT (DATETIME('now','localtime'))
);

[組込関数]
SELECT current_date;
SELECT current_time;
SELECT current_timestamp;

・タイムゾーンを考慮
SELECT datetime(datetime(), "localtime");
SELECT datetime(current_timestamp, "localtime");
