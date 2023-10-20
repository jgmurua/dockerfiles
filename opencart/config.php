<?php
// Ruta del sistema (debe definirse antes de ser utilizada)
define('DIR_SYSTEM', '/var/www/html/system/');

// Configuración de la base de datos
define('DB_DRIVER', 'sqlite3');
define('DB_DATABASE', DIR_SYSTEM . 'database/opencart.sqlite');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '');
define('DB_PORT', '3306');
define('DB_PREFIX', 'oc_');




// ... otras definiciones ...
?>
