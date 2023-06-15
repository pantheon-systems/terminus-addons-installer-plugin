# Terminus Scaffold Extension Plugin

[![Build Status](https://github.com/pantheon-systems/terminus-scaffold-extension-plugin/actions/workflows/test.yml/badge.svg)](https://github.com/pantheon-systems/terminus-scaffold-extension-plugin/actions/workflows/test.yml)
[![Actively Maintained](https://img.shields.io/badge/Pantheon-Actively_Maintained-yellow?logo=pantheon&color=FFDC28)](https://pantheon.io/docs/oss-support-levels#actively-maintained-support)

[![Terminus v2.x - v3.x Compatible](https://img.shields.io/badge/terminus-2.x%20--%203.x-green.svg)](https://github.com/pantheon-systems/terminus-scaffold-extension-plugin/tree/2.x)

Adds the `scaffold-extension` command and sub-commands `scaffold-extension:list` and `scaffold-extension:run <job>` to Terminus. 

Learn more about Terminus Plugins in the
[Terminus Plugins documentation](https://pantheon.io/docs/terminus/plugins)

## Configuration

These commands require no configuration

## Commands

### `scaffold-extension` (alias `scaffold`)

This is the base command. This command without any sub-commands will simply print the usage information and documentation.

### `scaffold-extension:list` (alias `scaffold:list`)

Lists available `scaffold_extension` jobs.

### `scaffold-extension:run <job>` (alias `scaffold:run`)

Runs the specified `scaffold_extension` job.

**Note:** Jobs will fail if a site is in SFTP mode _and_ there are outstanding changes that have not be committed to the Pantheon repository.

#### Flags

* `--with-db`: If included, the `scaffold_extension` job will be run with a database connection.

## Usage
* `terminus scaffold-extension:list <site_id>.<env>`
* `terminus scaffold-extension:run <site_id>.<env> <job> [--with-db]`

## Installation

To install this plugin using Terminus 3:
```
terminus self:plugin:install terminus-scaffold-extension-plugin
```

On older versions of Terminus:
```
mkdir -p ~/.terminus/plugins
curl https://github.com/pantheon-systems/terminus-scaffold-extension-plugin/archive/2.x.tar.gz -L | tar -C ~/.terminus/plugins -xvz
```

## Testing
This example project includes four testing targets:

* `composer lint`: Syntax-check all php source files.
* `composer cs`: Code-style check.
* `composer unit`: Run unit tests with phpunit
* `composer functional`: Run functional test with bats

To run all tests together, use `composer test:all`.

Note that prior to running the tests, you should first run:
* `composer install`
* `composer install-tools`

## Help
Run `terminus help scaffold-extension` for help.
