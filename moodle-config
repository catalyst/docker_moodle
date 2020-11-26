<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype    = 'mysqli';
$CFG->dblibrary = 'native';
$CFG->dbhost    = 'db';
$CFG->dbname    = 'moodle';
$CFG->dbuser    = 'moodle_user';
$CFG->dbpass    = 'password';
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array (
  'dbpersist' => 0,
  'dbport' => '',
  'dbsocket' => '',
);

$CFG->dbtype            = 'mysqli';
$CFG->phpunit_dblibrary = 'native';
$CFG->phpunit_dbhost    = 'test-db';
$CFG->phpunit_dbname    = 'moodle';
$CFG->phpunit_dbuser    = 'moodle_user';
$CFG->phpunit_dbpass    = 'password';
$CFG->phpunit_prefix    = 'phpu_';
$CFG->phpunit_dataroot = '/var/lib/testsitedata';

$CFG->wwwroot   = 'http://localhost';

$CFG->dataroot  = '/var/lib/sitedata';

$CFG->admin     = 'admin';

//Force a debugging mode regardless the settings in the site administration
@error_reporting(E_ALL | E_STRICT); // NOT FOR PRODUCTION SERVERS!
$CFG->debug = (E_ALL | E_STRICT);   // === DEBUG_DEVELOPER - NOT FOR PRODUCTION SERVERS!

$CFG->noemailever = true;

$CFG->directorypermissions = 0777;

require_once(dirname(__FILE__) . '/lib/setup.php');

// There is no php closing tag in this file,
// it is intentional because it prevents trailing whitespace problems!