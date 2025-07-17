<?php
define('DB_NAME', 'banana');
define('DB_USER', 'banana');
define('DB_PASSWORD', 'banana123');
define('DB_HOST', '192.168.54.20');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
$table_prefix = 'wp_';
define('WP_DEBUG', false);
if (!defined('ABSPATH')) define('ABSPATH', __DIR__ . '/');
require_once ABSPATH . 'wp-settings.php';