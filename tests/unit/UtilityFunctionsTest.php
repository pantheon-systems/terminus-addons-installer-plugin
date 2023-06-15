<?php

namespace Pantheon\TerminusScaffoldExtension\Utils;

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
        $this->assertTrue(str_contains(Helpers::usage(), $expected));
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
}
