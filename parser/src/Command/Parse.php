<?php
declare(strict_types=1);
namespace Bodhi\Command;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Input\InputOption;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Formatter\OutputFormatter;
use Bodhi\Util\Parser;

class Parse extends Command
{
    protected function configure()
    {
        $this
        ->setName('parse')
        ->setDescription('Parse a git repository')
        ->setHelp('This command parses a git repository for historic data');
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $output->setFormatter(new OutputFormatter(true));
        $parser = new Parser();
        $curdir = getcwd();
        chdir('../repo');
        $parser->parse($output);
        $parser->save();
        chdir($curdir);
        $output->writeln('<info>Done</info>');
    }
}
