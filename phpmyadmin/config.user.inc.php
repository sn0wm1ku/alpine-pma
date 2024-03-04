<?php
for ($i = 1; isset($hosts[$i - 1]); $i++) {
  $aws_region = getenv('AWS_REGION');
  if (str_contains($cfg['Servers'][$i]['verbose'], 'RDS')) {
    $cfg['Servers'][$i]['ssl'] = true;
    // You need to have the region CA file and the authority CA file (2019 edition CA for example) in the PEM bundle for it to work
    $cfg['Servers'][$i]['ssl_ca'] = "/etc/ssl/{$aws_region}-bundle.pem";
    // Enable SSL verification
    $cfg['Servers'][$i]['ssl_verify'] = true;
  }
}
