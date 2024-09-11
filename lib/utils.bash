#!/usr/bin/env bash

set -euo pipefail

# Default version of PHP in https://github.com/shivammathur/homebrew-php - change this if the default version changes
DEFAULT_VERSION="8.3"

# Print error message and exit
fail() {
	echo -e "asdf-php-brew: $*"
	exit 1
}

# Print help overview
help_overview() {
	echo "PHP plugin which uses Homebrew for PHP installation instead of compiling PHP."
}

# List dependencies
list_dependencies() {
	echo "curl"
	echo "Homebrew"
}

# Check dependencies
check_dependencies() {
	# Check if curl is installed
  	if ! command -v curl >/dev/null; then
    	fail "curl is required but not installed. Please install curl first."
  	fi

	# Check if Homebrew is installed
  	if ! command -v brew >/dev/null; then
    	fail "Homebrew is required but not installed. Please install Homebrew first."
  	fi

	# Add shivammathur/php tap if not already added
	brew tap shivammathur/php
}

# Get all available versions of PHP
get_all_versions() {
	# Get all versions of PHP available in the tap
	mapfile -t tmp < <(brew search "/shivammathur/php/php" | sed 's/shivammathur\/php\///g')

	# Now add the default version to the ones without an '@' symbol
	versions=()
	for version in "${tmp[@]}"; do
		if [[ $version == *@* ]]; then
			versions+=("$version")
		else
			versions+=("$(echo $version | sed "s/php/php@$DEFAULT_VERSION/")")
		fi
	done

	# Now strip the 'php@' part from the versions
	versions=("${versions[@]//php@/}")

	# Sort the array
	IFS=$'\n' versions=($(sort <<<"${versions[*]}"))

	# Print versions line by line
	printf '%s\n' "${versions[@]}"
}

# Check if a version of PHP exists
check_version_exists() {
	local version="$1"

	mapfile -t versions < <(get_all_versions)

	for item in "${versions[@]}"; do
		if [[ "$item" == "$version" ]]; then
			return
		fi
	done

	fail "PHP ${version} is not available."
}

# Check if a version of PHP is installed
check_version_installed() {
	local version="$1"

	if brew list --full-name | grep -q "^shivammathur/php/php@${version}$"; then
		return
	else
		fail "PHP ${version} is not installed."
	fi
}

# List all available versions of PHP
list_all_versions() {
	mapfile -t versions < <(get_all_versions)
	printf '%s ' "${versions[@]}"
}

# Install a version of PHP
install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if brew install "shivammathur/php/php@${version}"; then
		mkdir -p "${install_path}"

		for bin in php pecl; do
			ln -s "$(brew --prefix)/opt/php@${version}/bin/${bin}" "${install_path}/${bin}"
			test -x "$install_path/$bin" || fail "Expected $install_path/$bin to be executable."
		done

		echo "PHP ${version} has been installed successfully."
	else
		fail "Failed to install PHP ${version}."
	fi
}

# Install Composer for a version of PHP
install_composer() {
	local version="$1"
	local install_path="${2%/bin}/bin"

	# Determine the correct checksum command
	if command -v sha256sum > /dev/null 2>&1; then
		checksum_cmd="sha256sum"
	elif command -v shasum > /dev/null 2>&1; then
		checksum_cmd="shasum -a 256"
	else
		fail "Neither sha256sum nor shasum found. Exiting."
	fi

	# Create a temporary directory
	temp_dir=$(mktemp -d)

	# Change to the temporary directory
	cd "$temp_dir" || exit 1

	# Download the file
	if ! curl -sO "https://getcomposer.org/download/latest-stable/composer.phar"; then
		cd - && rm -rf "$temp_dir"
		fail "Downloading Composer failed."
	fi

	# Download the checksum file
	echo "Downloading checksum..."
	if ! curl -sO "https://getcomposer.org/download/latest-stable/composer.phar.sha256sum"; then
		cd - && rm -rf "$temp_dir"
		fail "Checksum checksum for Composer failed."
	fi

	# Verify the checksum
	echo "Verifying checksum..."
	if $checksum_cmd -c *.sha256sum; then
		mv composer.phar "$install_path/composer"
	else
		cd - && rm -rf "$temp_dir"
		fail "Checksum verification failed. The file may be corrupted or tampered with."
	fi

	# Clean up: remove temporary directory
	cd - && rm -rf "$temp_dir"

	echo "Composer has has been installed successfully for PHP ${version}."
}

# Uninstall a version of PHP
uninstall_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if brew uninstall "shivammathur/php/php@${version}"; then
		rm -rf "${install_path}"

		echo "PHP ${version} has been uninstalled successfully."
	else
		fail "Failed to uninstall PHP ${version}."
	fi
}
