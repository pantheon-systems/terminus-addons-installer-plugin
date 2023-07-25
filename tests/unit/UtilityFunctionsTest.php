<?php

namespace Pantheon\TerminusScaffoldExtension\Helpers;

use PHPUnit\Framework\TestCase;

class UtilityFunctionsTest extends TestCase
{
    /**
     * Test the base addons-install command.
     *
     * @dataProvider baseCommandDataProvider
     */
    public function testBaseCommand($expected)
    {
        $this->assertTrue(str_contains(UtilityFunctions::usage(), $expected));
    }

    /**
     * Data provider for testBaseCommand.
     *
     * @return array
     */
    public function baseCommandDataProvider()
    {
        return [
            ['terminus addons-install  (aliases: install, addons-install:help, install:help)'],
            ['terminus addons-install:list (aliases: install:list)'],
            ['terminus addons-install:run (aliases: install:run)'],
        ];
    }

    /**
     * Test the decypherSiteInfo function.
     */
    public function testDecypherSiteInfo()
    {
        $result = UtilityFunctions::decypherSiteInfo('site_id.dev');
        $this->assertIsArray($result);
        $this->assertEquals('site_id', $result['id']);
        $this->assertEquals('dev', $result['env']);
    }

    /**
     * Test the availableJobs function.
     */
    public function testAvailableJobs()
    {
        $result = UtilityFunctions::availableJobs();
        $this->assertIsArray($result);
        $this->assertArrayHasKey('install_ocp', $result);
    }

    /**
     * Test the jobExists function.
     */
    public function testJobExists()
    {
        $available_jobs = UtilityFunctions::availableJobs();
        foreach ($available_jobs as $job_name => $job_description) {
            $this->assertTrue(UtilityFunctions::jobExists($job_name));
        }
        $this->assertFalse(UtilityFunctions::jobExists('not-a-job'));
    }
}
