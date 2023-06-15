<?php
/**
 * terminus scaffold-extension
 *
 * This command allows specific scaffold_extension UJR jobs to be run from Terminus.
 */

namespace Pantheon\TerminusScaffoldExtension\Commands;

use Pantheon\Terminus\Commands\TerminusCommand;

class ScaffoldExtensionCommand extends TerminusCommand
{
    public const UPDATE_VARS_COLOR = "\e[38;5;3m";
    public const DEFAULT_COLOR = "\e[0m";

    /**
     * Run a scaffold_extension UJR job.
     *
     *
     * @command scaffold-extension
     * @aliases scaffold
     */
    public function scaffoldExtension()
    {
        $this->log()->notice("Attempting to run scaffold_extension job...");
    }

    /**
     * Run the scaffold_extension UJR job.
     *
     * @command scaffold-extension:run
     * @aliases scaffold:run
     *
     * @param string $site_env
     * @param string $job_id
     */
    public function runExtension(string $site_env, $job_id = '')
    {
        $site = $this->decypherSiteInfo($site_env);
        $site_id = $site['id'];
        $env = $site['env'];

        if (empty($job_id)) {
            $this->log()->error('Please provide a job ID.');
            return;
        }

        $this->log()->notice(sprintf('Attempting to run the %1$s job on %2$s.%3$s...', $job_id, $site_id, $env));
    }

    /**
     * List the available scaffold_extension UJR jobs.
     *
     * @command scaffold-extension:list
     * @aliases scaffold:list
     *
     * @param string $site_env
     */
    public function listJobs(string $site_env)
    {
        $site = $this->decypherSiteInfo($site_env);
        $site_id = $site['id'];
        $env = $site['env'];

        $this->log()->notice(sprintf('Attempting to list jobs on %1$s.%2$s...', $site_id, $env));
    }

    /**
     * Given a $site_env which might be in site_id.dev or just site_id format, return an array with the site_id and env.
     *
     * The default environment is dev.
     *
     * @param string $site_env
     *
     * @return array
     */
    private function decypherSiteInfo(string $site_env) : array
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
}
