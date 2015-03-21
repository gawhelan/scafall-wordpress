<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, and ABSPATH. You can find more information by visiting
 * {@link http://codex.wordpress.org/Editing_wp-config.php Editing wp-config.php}
 * Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', '{{wpDbName}}');

/** MySQL database username */
define('DB_USER', '{{wpDbUser}}');

/** MySQL database password */
define('DB_PASSWORD', '{{wpDbPassword}}');

/** MySQL hostname */
define('DB_HOST', 'localhost');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
  define('ABSPATH', dirname(__FILE__) . '/wordpress/');

define('WP_HOME', 'http://' . $_SERVER['HTTP_HOST']);
define('WP_SITEURL', WP_HOME . '/wordpress');

define('WP_CONTENT_DIR', realpath($_SERVER['DOCUMENT_ROOT']) . '/wp-content');
define('WP_CONTENT_URL', WP_HOME . '/wp-content');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */

define('AUTH_KEY',         'rl3_H!l#^./6v?!x&+o96x=(=@?k*)yNQ`{q#<4emwaTmlsC?e(}8s]*#_B?))je');
define('SECURE_AUTH_KEY',  '`+Np4k}oUHB#sC>|EJ-+}.WB[N@UI`HevUN(B7W_kdIggkWnZbjpid +0i#%([K2');
define('LOGGED_IN_KEY',    '$8YVY54h{A;~G&nB^a%%(hcuYfkgThY/TgC_Ao~UV(:4Bm=^UBfFGnKUTt#|BRBX');
define('NONCE_KEY',        'F!huEk|h$.]Df!9yeDzD6w-.s Aw[#G[!bSb!ed{S_K|#X#gt/Q)A3*~H. ;]`bs');
define('AUTH_SALT',        '*l2#no0A{|aa8b8 4=yz1 gH*cqf-aY{KD+IA_O0P10JWH35lfd wQ[]qS(1KZI{');
define('SECURE_AUTH_SALT', '8|7/!KJ>%ZvVz /;O$j!a<rLCkqD_-}@I1KDul][`v+cw]w|>@`lm#7`>&Xu/8p7');
define('LOGGED_IN_SALT',   'SZF8n>M]7G7;xGHgpJh{Ss+?`m-=~(!%vMu$ $BTOv1@)LU;klMZzEQU6LB*C5VD');
define('NONCE_SALT',       'l_+G<;}1!}g9)k`R)EKN3a(t4+s3AZEY5jwvB}gVoG|MG<?2bq&D!l2G!!(^&p!;');
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
