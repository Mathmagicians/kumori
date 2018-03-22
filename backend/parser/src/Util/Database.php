<?php
declare(strict_types=1);

namespace Bodhi\Util;

class Database
{
    public static $db;
    public static $table = 'files';

    public static function connect()
    {
        try {
          self::$db = new \PDO('pgsql:dbname=calculated;host=postgres', 'parser', 'parser');
          self::$db->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
          print "Error!: " . $e->getMessage() . "\n";
          exit();
        }
    }

    public static function truncate()
    {
        $sql ="TRUNCATE TABLE ".self::$table.";";
        self::$db->exec($sql);
    }

    public static function insert(string $name, string $modified, int $count) : bool
    {
        $sql = "INSERT INTO ".self::$table." (filename, last_modified, modified_count)
                VALUES (:filename, :last_modified, :modified_count)";
        $statement = self::$db->prepare($sql);
        $statement->bindValue(':filename', $name);
        $statement->bindValue(':last_modified', $modified);
        $statement->bindValue(':modified_count', $count);
        $inserted = $statement->execute();
        if ($inserted) {
            return true;
        }
        return false;
    }
}
