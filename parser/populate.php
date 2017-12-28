#!/usr/bin/env php
<?php
require __DIR__.'/vendor/autoload.php';
use Bodhi\Application\Bodhi;
use Bodhi\Command\Parse;

$app = new Bodhi();
$app->add(new Parse());
$app->run();
