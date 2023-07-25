<?php
/**
 * terminus scaffold-extension
 *
 * This command allows specific scaffold_extensions UJR jobs to be run from Terminus.
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
     * Run a specified job.
     *
     * @command addons-install
     * @aliases install
     */
    public function addonsInstall()
    {
        return Helpers\UtilityFunctions::usage();
    }

    /**
     * Display command usage.
     *
     * @command addons-install:help
     * @aliases install:help
     */
    public function addonsInstallHelp()
    {
        return $this->addonsInstall();
    }

    /**
     * Run the specified job.
     *
     * @command addons-install:run
     * @aliases install:run
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

        $job_name = $this->validateJobName($job_name);
        if (!Helpers\UtilityFunctions::jobExists($job_name)) {
            $this->log()->error(sprintf('The %1$s job does not exist.', $job_name));
            return 1;
        }

        // Fail if there's uncommitted code in SFTP mode.
        if ($env->get('connection_mode') === 'sftp') {
            // Check if there is uncommitted code.
            $change_count = count((array)$env->diffstat());
            if ($change_count > 0) {
                $this->log()->error(sprintf('There are %1$s uncommitted code changes on %2$s.%3$s. Please commit or revert them before running this job.', $change_count, $site_id, $site_env));
                return 1;
            }
        }

        $params = [
            'job_name' => $job_name,
            'with_db' => false, // Todo: This will be a flag in a later iteration.
        ];

        $this->log()->notice(sprintf('Attempting to run the %1$s job on %2$s.%3$s...', str_replace('_', '-', $job_name), $site_id, $site_env));

        return $env->getWorkflows()->create('scaffold_extensions', compact('params'));
    }

    /**
     * List the available jobs.
     *
     * @command addons-install:list
     * @aliases install:list
     */
    public function listJobs()
    {
        $this->log()->notice('Listing available jobs...');
        return Helpers\UtilityFunctions::availableJobs();
    }

    /**
     * Check job name. Allow underscores or dashes. Return only underscores.
     *
     * @param string $job_name
     * @return string
     */
    public function validateJobName(string $job_name) : string
    {
        $job_name = str_replace('-', '_', $job_name);
        return $job_name;
    }
}
