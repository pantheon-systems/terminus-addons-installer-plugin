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

	/**
	 * Given a $site_env which might be in site_id.dev or just site_id format, return an array with the site_id and env.
	 *
	 * The default environment is dev.
	 *
	 * @param string $site_env
	 *
	 * @return array
	 */
	private function decypherSiteInfo( string $site_env ) : array {
		$env = 'dev';
		$site_id = $site_env;

		/**
		 * If the first parameter has a period (.) in it, then it is a $site_id.$env combination.
		 * Otherwise, we default to dev.
		 */
		if ( strpos( $site_env, '.' ) !== false ) {
			$site_props = explode( '.', $site_env );
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