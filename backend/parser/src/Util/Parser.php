<?php
declare(strict_types=1);

namespace Bodhi\Util;

use Bodhi\Util\Database;
use Symfony\Component\Console\Output\ConsoleOutput;
use Symfony\Component\Stopwatch\Stopwatch;

class Parser
{
    private $files = [];
    const CHANGE_COUNT = 'changeCount';
    const CHANGE_DATE = 'changeDate';

    private static function commits() : array
    {
        $command = "git log --reverse --pretty=format:\"%h\"";
        $commits = shell_exec($command);
        if ($commits != null && strlen($commits) > 0) {
            return preg_split('/$\R?^/m', $commits);
        } else {
            throw new RuntimeException("No commits found", 1);
        }
    }

    private static function files(string $commit) : array
    {
        $command = "git diff-tree --no-commit-id --name-status --root -r $commit";
        $commitFiles = shell_exec($command);
        if (is_string($commitFiles)) {
            return preg_split('/$\R?^/m', $commitFiles);
        } else {
            return [];
        }
    }

    private static function date(string $commit) : string
    {
        $command = "git show --date=short $commit | grep Date -m 1 | awk '{print $2}'";
        $date = shell_exec($command);
        if ($date != null) {
            return $date;
        }
        return null;
    }

    private static function action(string $file) : array
    {
        $arr = explode("\t", $file);
        return ['action' => $arr[0], 'file' => $arr[1]];
    }

    public function parse(ConsoleOutput $output)
    {
        $stopwatch = new Stopwatch();
        $stopwatch->start('parse', 'Parser');
        $output->writeln('<info>Starting</info>');
        $commits = self::commits();
        foreach ($commits as $commit) {
            $fileList = self::files($commit);
            $date = self::date($commit);

            if (is_array($fileList) && count($fileList) > 0) {
                foreach ($fileList as $file) {
                    $action = self::action(trim($file))['action'];
                    $file = self::action(trim($file))['file'];
                    $format = "%' -10s: %s\n";

                    switch ($action) {
                        case 'A':
                            echo sprintf($format, "Adding", $file);
                            $this->files[$file][self::CHANGE_COUNT] = 1;
                            $this->files[$file][self::CHANGE_DATE] = trim($date);
                            break;
                        case 'M':
                            echo sprintf($format, "Modifying", $file);
                            $this->files[$file][self::CHANGE_COUNT] = $this->files[$file][self::CHANGE_COUNT] + 1;
                            $this->files[$file][self::CHANGE_DATE] = trim($date);
                            break;
                        case 'D':
                            echo sprintf($format, "Deleting", $file);
                            unset($this->files[$file]);
                            break;
                        default:
                            echo "Nothing\n";
                    }
                }
            }
        }
        $event = $stopwatch->stop('parse');
        $output->writeln('<info>'.$event.'</info>');
    }

    public function save()
    {
        Database::connect();
        Database::truncate();
        foreach ($this->files as $key => $value) {
            if ($value[self::CHANGE_COUNT] != '') {
                echo sprintf("%' -35s: %s / %s\n", $key, $value[self::CHANGE_COUNT], $value[self::CHANGE_DATE]);
                Database::insert($key, $value[self::CHANGE_DATE], $value[self::CHANGE_COUNT]);
            }
        }
    }
}
