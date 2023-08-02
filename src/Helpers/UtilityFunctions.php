<?php
/**
 * Scaffold Extension Utility Functions
 */

namespace Pantheon\TerminusScaffoldExtension\Helpers;

class UtilityFunctions
{
    public const UPDATE_VARS_COLOR = "\e[38;5;3m";
    public const DEFAULT_COLOR = "\e[0m";

    /**
     * Given a $site_env which might be in site_id.dev or just site_id format, return an array with the site_id and env.
     *
     * The default environment is dev.
     *
     * @param string $site_env
     *
     * @return array
     */
    public static function decypherSiteInfo(string $site_env) : array
    {
        $env = 'dev';
        $site_id = $site_env;

        /**
         * If the first parameter has a period (.) in it, then it is a $site_id.$env combination.
         * Otherwise, we default to dev.
         */
        if (strpos($site_env, '.') !== false) {
            $site_props = explode('.', $site_env);
            $site_id = $site_props[0];
            $env = $site_props[1];
        }

        $site = [
            'id' => $site_id,
            'env' => $env
        ];

        return $site;
    }

    /**
     * Returns the full usage and information for the addons-install command.
     *
     * @return string
     */
    public static function usage() : string
    {
        $bold = "\e[1m";

        $output = $bold . "terminus addons-install  (aliases: install, addons-install:help, install:help)\n" . self::DEFAULT_COLOR;
        $output .= self::UPDATE_VARS_COLOR . "Description:\n" . self::DEFAULT_COLOR;
        $output .= "\tDisplays this help message.\n";
        $output .= self::UPDATE_VARS_COLOR . "Usage:\n" . self::DEFAULT_COLOR;
        $output .= "\tterminus addons-install\n\n";
        $output .= $bold . "terminus addons-install:list (aliases: install:list)\n" . self::DEFAULT_COLOR;
        $output .= self::UPDATE_VARS_COLOR . "Description:\n" . self::DEFAULT_COLOR;
        $output .= "\tLists available jobs.\n";
        $output .= self::UPDATE_VARS_COLOR . "Usage:\n" . self::DEFAULT_COLOR;
        $output .= "\tterminus addons-install:list <site_id>.<env>\n\n";
        $output .= $bold . "terminus addons-install:run (aliases: install:run)\n" . self::DEFAULT_COLOR;
        $output .= self::UPDATE_VARS_COLOR . "Description:\n" . self::DEFAULT_COLOR;
        $output .= "\tRuns the specified job.\n";
        $output .= self::UPDATE_VARS_COLOR . "Usage:\n" . self::DEFAULT_COLOR;
        $output .= "\tterminus addons-install:run <site_id>.<env> <job> [--with-db]\n\n";
        $output .= "For more information, run terminus help addons-install:<command>.";

        return $output;
    }

    /**
     * Returns an array of available jobs.
     *
     * @return string
     */
    public static function availableJobs() : array
    {
        return [
            'install_ocp' => [
                'id' => 'ocp',
                'description' => 'ocp: Installs Object Cache Pro',
            ],
        ];
    }

    /**
     * Returns true if the specified job exists.
     *
     * @param string $job_name
     *
     * @return bool
     */
    public static function jobExists(string $job_name) : bool
    {
        $jobs = self::availableJobs();
        return array_key_exists($job_name, $jobs);
    }
}
