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
     *
     * @dataProvider jobExistsDataProvider
     */
    public function testJobExists($expected)
    {
        $job_id = $expected['id'];
        $job_description = $expected['description'];
        if (array_key_exists('failure', $expected)) {
            $this->assertFalse(UtilityFunctions::jobExists($job_id));
            return;
        }
        $this->assertTrue(UtilityFunctions::jobExists($job_id));
        $this->assertIsString($job_id);
        $this->assertIsString($job_description);
    }

    /**
     * Data provider for testJobExists().
     *
     */
    public function jobExistsDataProvider()
    {
        $available_jobs = UtilityFunctions::availableJobs();
        return array_merge( $available_jobs, [
                'failure' => [
                    'id' => 'not-a-job',
                    'description' => '',
                ],
            ],
        );
    }
}
