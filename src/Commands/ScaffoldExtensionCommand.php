<?php
/**
 * terminus scaffold-extension
 *
 * This command allows specific scaffold_extension UJR jobs to be run from Terminus.
 */

namespace Pantheon\TerminusScaffoldExtension\Commands;

use Pantheon\Terminus\Commands\TerminusCommand;
use Pantheon\TerminusScaffoldExtension\Helpers;

class ScaffoldExtensionCommand extends TerminusCommand
{
    /**
     * Run a scaffold_extension UJR job.
     *
     *
     * @command scaffold-extension
     * @aliases scaffold
     */
    public function scaffoldExtension()
    {
        return Helpers\UtilityFunctions::usage();
    }

    /**
     * Run the scaffold_extension UJR job.
     *
     * @command scaffold-extension:help
     * @aliases scaffold:help
     */
    public function scaffoldExtensionHelp()
    {
        return $this->scaffoldExtension();
    }

    /**
     * Run the scaffold_extension UJR job.
     *
     * @command scaffold-extension:run
     * @aliases scaffold:run
     *
     * @param string $site_env
     * @param string $job_name
     */
    public function runExtension(string $site_env = '', $job_name = '')
    {
        if (empty($site_env)) {
            $this->log()->error('Please provide site information.');
            Helpers\UtilityFunctions::usage();
            return;
        }

        $site = Helpers\UtilityFunctions::decypherSiteInfo($site_env);
        $site_id = $site['id'];
        $env = $site['env'];


        if (empty($job_name)) {
            $this->log()->error('Please provide a job ID.');
            return;
        }

        $this->log()->notice(sprintf('Attempting to run the %1$s job on %2$s.%3$s...', $job_name, $site_id, $env));
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
        $site = Helpers\UtilityFunctions::decypherSiteInfo($site_env);
        $site_id = $site['id'];
        $env = $site['env'];

        $this->log()->notice(sprintf('Attempting to list jobs on %1$s.%2$s...', $site_id, $env));
    }
}
