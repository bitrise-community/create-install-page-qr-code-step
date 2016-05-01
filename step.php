<?php

$query = [
    'size' => $_SERVER['qr_code_size'],
    'data' => $_SERVER['public_install_page_url'],
];

$qrCodeImageURL = 'https://api.qrserver.com/v1/create-qr-code/?'.http_build_query($query);

// Set environment variable
$out = $returnValue = null;
exec('envman add --key BITRISE_PUBLIC_INSTALL_PAGE_QR_CODE_IMAGE_URL --value "'.$qrCodeImageURL.'"', $out, $returnValue);

if ($returnValue != 0) {
    echo "Could not set the environment variable";
    exit(1);
}
