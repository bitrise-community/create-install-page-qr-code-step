#!/bin/bash

THIS_SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${THIS_SCRIPTDIR}/_bash_utils/utils.sh"
source "${THIS_SCRIPTDIR}/_bash_utils/formatted_output.sh"

# init / cleanup the formatted output
echo "" > "${formatted_output_file_path}"

if [ -z "${public_install_page_url}" ] ; then
	write_section_to_formatted_output "# Error"
	write_section_start_to_formatted_output '* Required input `$public_install_page_url` not provided!'
	exit 1
fi

if [ -z "${qr_code_size}" ] ; then
	write_section_to_formatted_output "# Error"
	write_section_start_to_formatted_output '* Required input `$qr_code_size` not provided!'
	exit 1
fi

resp=$(php "${THIS_SCRIPTDIR}/step.php")
ex_code=$?

if [ ${ex_code} -eq 0 ] ; then
	echo "${resp}"
	write_section_to_formatted_output "# Success"
	echo_string_to_formatted_output "QR code successfully created."
	exit 0
fi

write_section_to_formatted_output "# Error"
write_section_to_formatted_output "Creation of the QR code failed with the following error:"
echo_string_to_formatted_output "${resp}"
exit 1
