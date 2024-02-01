<?php
for ($i = 1; isset($hosts[$i - 1]); $i++) {
  if (str_contains($cfg['Servers'][$i]['verbose'], 'RDS')) {
    $cfg['Servers'][$i]['host'] = 'databasestack-databaseb269d8bb-dkzvt2k0aooy.cxvccxzmjv3c.ap-northeast-1.rds.amazonaws.com';
    $cfg['Servers'][$i]['ssl'] = true;
    // You need to have the region CA file and the authority CA file (2019 edition CA for example) in the PEM bundle for it to work
    $cfg['Servers'][$i]['ssl_ca'] = '/etc/ssl/ap-northeast-1-bundle.pem';
    // Enable SSL verification
    $cfg['Servers'][$i]['ssl_verify'] = true;
  }
}
