<?php
/**
 * Scaffold Extension Utility Functions
 */

namespace Pantheon\TerminusScaffoldExtension\Utils;

class Helpers {
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
	 * Returns the full usage and information for the scaffold-extension command.
	 *
	 * @return string
	 */
	public static function usage() : string {
		$bold = "\e[1m";

		$output = $bold . "terminus scaffold-extension  (aliases: scaffold, scaffold-extension:help, scaffold:help)\n" . self::DEFAULT_COLOR;
		$output .= self::UPDATE_VARS_COLOR . "Description:\n" . self::DEFAULT_COLOR;
		$output .= "\tDisplays this help message.\n";
		$output .= self::UPDATE_VARS_COLOR . "Usage:\n" . self::DEFAULT_COLOR;
		$output .= "\tterminus scaffold-extension\n\n";
		$output .= $bold . "terminus scaffold-extension:list (aliases: scaffold:list)\n" . self::DEFAULT_COLOR;
		$output .= self::UPDATE_VARS_COLOR . "Description:\n" . self::DEFAULT_COLOR;
		$output .= "\tLists available scaffold_extension UJR jobs.\n";
		$output .= self::UPDATE_VARS_COLOR . "Usage:\n" . self::DEFAULT_COLOR;
		$output .= "\tterminus scaffold-extension:list <site_id>.<env>\n\n";
		$output .= $bold . "terminus scaffold-extension:run (aliases: scaffold:run)\n" . self::DEFAULT_COLOR;
		$output .= self::UPDATE_VARS_COLOR . "Description:\n" . self::DEFAULT_COLOR;
		$output .= "\tRuns the specified scaffold_extension UJR job.\n";
		$output .= self::UPDATE_VARS_COLOR . "Usage:\n" . self::DEFAULT_COLOR;
		$output .= "\tterminus scaffold-extension:run <site_id>.<env> <job> [--with-db]\n\n";
		$output .= "For more information, run terminus help scaffold-extension:<command>.";

		return $output;
	}
}