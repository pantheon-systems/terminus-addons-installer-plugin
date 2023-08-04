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
        foreach ( $expected as $test => $data ) {
            if ( $test === 'failure' ) {
                $this->assertFalse(UtilityFunctions::jobExists($data['id']));
            } else {
                $this->assertTrue(UtilityFunctions::jobExists($test));
                $this->assertIsString($data['id']);
                $this->assertIsString($data['description']);
            }
        }
    }

    /**
     * Data provider for testJobExists().
     *
     */
    public function jobExistsDataProvider()
    {
        $available_jobs = UtilityFunctions::availableJobs();
        return [
            [ array_merge( $available_jobs, [
                'failure' => [
                    'id' => 'not-a-job',
                    'description' => '',
                ],
            ] ) ],
        ];
    }

    /**
     * Test the listJobs function.
     *
     * @dataProvider listJobsDataProvider
     */
    public function testListJobs($expected)
    {
        $result = UtilityFunctions::listJobs();
        $this->assertIsArray($result);
        $this->assertContains($expected, $result);

    }

    /**
     * Data provider for testListJobs().
     */
    public function listJobsDataProvider()
    {
        return [
            ['ocp: Installs Object Cache Pro'],
        ];
    }
}
