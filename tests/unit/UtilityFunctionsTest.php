<?php

namespace Pantheon\TerminusScaffoldExtension\Helpers;

use PHPUnit\Framework\TestCase;

class UtilityFunctionsTest extends TestCase
{
    /**
     * Test the base scaffold-extension command.
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
            ['terminus scaffold-extension  (aliases: scaffold, scaffold-extension:help, scaffold:help)'],
            ['terminus scaffold-extension:list (aliases: scaffold:list)'],
            ['terminus scaffold-extension:run (aliases: scaffold:run)'],
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
}
