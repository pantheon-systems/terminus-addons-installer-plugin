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
     * @param string $job_id
     */
    public function runScaffoldExtensionsJob(string $site_info = '', string $job_id = '')
    {
        if (empty($site_info)) {
            $this->log()->error('Please provide site information.');
            Helpers\UtilityFunctions::usage();
            return 1;
        }

        $with_db = true; // Todo: In the future, this will be the opposite of the --skip-db flag, if passed.
        $site_arr = Helpers\UtilityFunctions::decypherSiteInfo($site_info);
        $site_id = $site_arr['id'];
        $site_env = $site_arr['env'];
        $site = $this->getSite($site_id);
        $env = $site->getEnvironments()->get($site_env);
        $dashboard_url = $this->getSiteById($site_id)->dashboardUrl();

        if (in_array($site_env, ['test', 'live'])) {
            $this->log()->error(sprintf('You cannot run the %1$s workflow in a %2$s environment. You must use dev or a multidev environment.', $job_name, $site_env));
            return 1;
        }

        if (empty($job_id)) {
            $this->log()->error('Please provide a job ID.');
            return 1;
        }

        $job_name = $this->validateJobName($job_id);
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
            'with_db' => $with_db, // Todo: This will be a flag in a later iteration.
        ];

        $this->log()->notice(sprintf('Attempting to run the %1$s job on %2$s.%3$s...', str_replace('_', '-', $job_name), $site_id, $site_env));

        // Run the workflow and trigger a success message if it triggered successfully.
        if ($env->getWorkflows()->create('scaffold_extensions', compact('params'))) {
            $success_message = sprintf("The %s workflow has been started on %s.%s.\n You can see the workflow running on your dashboard: %s", str_replace('_', '-', $job_name), $site_id, $site_env, $dashboard_url);
            $this->log()->notice($success_message);
            return;
        }

        // We should never get to this path, but if we do, that means the workflow failed to trigger. We'll link the user to the dashboard and instruct them to just try it again since we don't really know what happened.
        $this->log()->error(sprintf('There was an error running the %1$s job on %2$s.%3$s. If you are seeing this message, you can check the workflows log in your Pantheon dashboard and try again: %4$s.', str_replace('_', '-', $job_name), $site_id, $site_env, $dashboard_url));
        return 1;
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
        return Helpers\UtilityFunctions::listJobs();
    }

    /**
     * Check job name. Allow underscores or dashes. Return only underscores.
     *
     * @param string $job_id
     * @return string
     */
    public function validateJobName(string $job_id) : string
    {
        $jobs = Helpers\UtilityFunctions::availableJobs();
        // Check if availableJobs contains the $job_id as an 'id' within the array.
        // If it does, return the index.
        foreach ($jobs as $index => $job) {
            if ($job['id'] === $job_id) {
                return $index;
            }
        }

        return $job_id;
    }
}
