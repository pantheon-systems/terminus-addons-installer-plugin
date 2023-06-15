<?php
/**
 * terminus scaffold-extension
 *
 * This command allows specific scaffold_extension UJR jobs to be run from Terminus.
 */

namespace Pantheon\TerminusScaffoldExtension\Commands;

use Pantheon\Terminus\Commands\TerminusCommand;

class ScaffoldExtensionCommand extends TerminusCommand {

	/**
	 * Run the scaffold_extension UJR job.
	 *
	 * @command scaffold-extension
	 * @aliases se
	 * @aliases scaffold
	 */
	public function scaffoldExtension() {
		$this->log()->notice("Attempting to run scaffold_extension job...");

	}

	/**
	 * Run the scaffold_extension UJR job.
	 *
	 * @command scaffold-extension:run
	 * @aliases se:run
	 * @aliases scaffold:run
	 */
	public function runExtension( string $site_env, $job_id = '' ) {
		$env = 'dev';
		$site_id = $site_env;

		/**
		 * If the first parameter has a period (.) in it, then it is a $site_id.$env combination.
		 * Otherwise, we default to dev.
		 */
		if ( strpos( $site_env, '.' ) !== false ) {
			$site = explode( '.', $site_env );
			$env = $site[1];
			$site_id = $site[0];
		}

		if ( empty( $job_id ) ) {
			$this->log()->error( 'Please provide a job ID.' );
			return;
		}

		$this->log()->notice(sprintf( 'Attempting to run the %1$s job on %2$s.%3$s...', $job_id, $site_id, $env ));
	}
}