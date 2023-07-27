# Terminus Addons Installer Plugin

[![Build Status](https://github.com/pantheon-systems/terminus-addons-installer-plugin/actions/workflows/test.yml/badge.svg)](https://github.com/pantheon-systems/terminus-addons-installer-plugin/actions/workflows/test.yml)
[![Actively Maintained](https://img.shields.io/badge/Pantheon-Actively_Maintained-yellow?logo=pantheon&color=FFDC28)](https://pantheon.io/docs/oss-support-levels#actively-maintained-support)

[![Terminus v3.x Compatible](https://img.shields.io/badge/terminus-3.x-green.svg)](https://github.com/pantheon-systems/terminus-addons-installer-plugin/tree/3.x)

Adds the `addons-install` command and sub-commands `addons-install:list` and `addons-install:run <job>` to Terminus. Use this Terminus Plugin to run workflows that configure themes & plugins.

Learn more about Terminus Plugins in the
[Terminus Plugins documentation](https://pantheon.io/docs/terminus/plugins)

## Configuration

These commands require no configuration

## Commands

### `addons-install` (alias `install`)

This is the base command. This command without any sub-commands will simply print the usage information and documentation.

### `addons-install:list` (alias `install:list`)

Lists available  jobs.

### `addons-install:run <job>` (alias `install:run`)

Runs the specified job.

**Note:** Jobs will fail if a site is in SFTP mode _and_ there are outstanding changes that have not be committed to the Pantheon repository.

<!-- TODO: add the flag support in a future release
#### Flags

* `--skip-db`: If included, the job will be run without a database connection.
-->
## Usage
* `terminus addons-install:list`
* `terminus addons-install:run <site_id>.<env> <job> [--skip-db]`

## Installation

To install this plugin using Terminus 3:
```
terminus self:plugin:install terminus-addons-installer-plugin
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
Run `terminus help addons-install` for help.
