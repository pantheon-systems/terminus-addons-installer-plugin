<?php
/**
 * terminus scaffold-extension
 *
 * This command allows specific scaffold_extension UJR jobs to be run from Terminus.
 */

namespace Pantheon\TerminusScaffoldExtension\Commands;

use Pantheon\Terminus\Site\SiteAwareTrait;
use Pantheon\Terminus\Site\SiteAwareInterface;
use Pantheon\Terminus\Commands\TerminusCommand;
use Pantheon\TerminusScaffoldExtension\Helpers;

class ScaffoldExtensionCommand extends TerminusCommand implements SiteAwareInterface
{
    use SiteAwareTrait;

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
     * @param string $site_info
     * @param string $job_name
     */
    public function runExtension(string $site_info = '', $job_name = '')
    {
        if (empty($site_info)) {
            $this->log()->error('Please provide site information.');
            Helpers\UtilityFunctions::usage();
            return 1;
        }

        $site_arr = Helpers\UtilityFunctions::decypherSiteInfo($site_info);
        $site_id = $site_arr['id'];
        $site_env = $site_arr['env'];
        $site = $this->getSite($site_id);
        $env = $site->getEnvironments()->get($site_env);

        if (empty($job_name)) {
            $this->log()->error('Please provide a job ID.');
            return 1;
        }

        if (!Helpers\UtilityFunctions::jobExists($job_name)) {
            $this->log()->error(sprintf('The %1$s job does not exist.', $job_name));
            return 1;
        }

        $params = [
            'job_name' => $job_name,
            'with_db' => false, // Todo: This will be a flag in a later iteration.
        ];

        $this->log()->notice(sprintf('Attempting to run the %1$s job on %2$s.%3$s...', $job_name, $site_id, $site_env));

        return $env->getWorkflows()->create('scaffold_extensions', compact('params'));
    }

    /**
     * List the available scaffold_extension UJR jobs.
     *
     * @command scaffold-extension:list
     * @aliases scaffold:list
     */
    public function listJobs()
    {
        $this->log()->notice('Listing available jobs...');
        return Helpers\UtilityFunctions::availableJobs();
    }
}
