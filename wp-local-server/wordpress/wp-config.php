<?php
/**
 * WordPress の基本設定
 *
 * このファイルは、MySQL、テーブル接頭辞、秘密鍵、言語、ABSPATH の設定を含みます。
 * より詳しい情報は {@link http://wpdocs.sourceforge.jp/wp-config.php_%E3%81%AE%E7%B7%A8%E9%9B%86 
 * wp-config.php の編集} を参照してください。MySQL の設定情報はホスティング先より入手できます。
 *
 * このファイルはインストール時に wp-config.php 作成ウィザードが利用します。
 * ウィザードを介さず、このファイルを "wp-config.php" という名前でコピーして直接編集し値を
 * 入力してもかまいません。
 *
 * @package WordPress
 */

// 注意: 
// Windows の "メモ帳" でこのファイルを編集しないでください !
// 問題なく使えるテキストエディタ
// (http://wpdocs.sourceforge.jp/Codex:%E8%AB%87%E8%A9%B1%E5%AE%A4 参照)
// を使用し、必ず UTF-8 の BOM なし (UTF-8N) で保存してください。

// ** MySQL 設定 - この情報はホスティング先から入手してください。 ** //
/** WordPress のためのデータベース名 */
define('DB_NAME', 'wordpress_db');

/** MySQL データベースのユーザー名 */
define('DB_USER', 'wp_user');

/** MySQL データベースのパスワード */
define('DB_PASSWORD', 'HFt33uZa80A');

/** MySQL のホスト名 */
define('DB_HOST', 'localhost');

/** データベースのテーブルを作成する際のデータベースの文字セット */
define('DB_CHARSET', 'utf8');

/** データベースの照合順序 (ほとんどの場合変更する必要はありません) */
define('DB_COLLATE', '');

/**#@+
 * 認証用ユニークキー
 *
 * それぞれを異なるユニーク (一意) な文字列に変更してください。
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org の秘密鍵サービス} で自動生成することもできます。
 * 後でいつでも変更して、既存のすべての cookie を無効にできます。これにより、すべてのユーザーを強制的に再ログインさせることになります。
 *
 * @since 2.6.0
 */



define('AUTH_KEY',         '.GZq>v4o%HVf_T{}q 0{d~R]n1$H8HZxO>fKwsd4?SUDs*w{MaI^^~|ri,T3vTnC8115ffc241226a0a5f1a4f74faf6099532a549c1');
define('SECURE_AUTH_KEY',  ',tD}X>= F9?:5#9a>MJS2VnFjf)r-!,v/i`}moBZ]<Rbl#ZrLZTia~s/DBdC4QE105d736471107a5e3f3fdda9403650baddf6df926');
define('LOGGED_IN_KEY',    '2O[RUAFFMNAI9_1c#-}eCJs3ZW:JH$i3!<7+e/_bCv9APO_4vAF Dc1wujIM{kA1737deaf50c1b290dd5c7162e1d26c7d4ef761205');
define('NONCE_KEY',        'tS28Ny}knwIG@ez-|V%)kn=_+*lxU{z.&-L{,5k=mvSuqE+6JPMI$biL;H):$.!X735adce0f79eaf87285c431f6438613588f8eabf');
define('AUTH_SALT',        ':I]Z;:2!BU(egj50KZa4w:9^/z5h+]IbZ4dyk4ek_kyb@)?,$$L9k|R6~AsM9wil701b548c23b6d56b8d088c5b06aa1e3820571b9a');
define('SECURE_AUTH_SALT', 'mVZ`@}__{6hg.K_CIQo0:AA^mfLi4u2_~f945$A/bR=LoU)SD?]]uJ@pn{:ft+8-ff584d84b6bedbf6175e50ff44c5afd2071db0da');
define('LOGGED_IN_SALT',   'YJfw1(`Um!{iTH%9WZAR2meRz9=xl_M_zhPcjBboNQkFqo%fxs:gs{0[_p-!**2A431058a5e0bf00d1278692f7b44c630608bcb337');
define('NONCE_SALT',       '3M6Q1%L8/X1:%}SzM$gFmE$`jK%vA1r~vzO-@6,^[r8t1k=[ lJE3hh6:UJsqx|x4776ac5a4405d5d1758b9f6e052b12cec869c6ff');



/**#@-*/

/**
 * WordPress データベーステーブルの接頭辞
 *
 * それぞれにユニーク (一意) な接頭辞を与えることで一つのデータベースに複数の WordPress を
 * インストールすることができます。半角英数字と下線のみを使用してください。
 */
$table_prefix  = 'wp_';

/**
 * ローカル言語 - このパッケージでは初期値として 'ja' (日本語 UTF-8) が設定されています。
 *
 * WordPress のローカル言語を設定します。設定した言語に対応する MO ファイルが
 * wp-content/languages にインストールされている必要があります。たとえば de_DE.mo を
 * wp-content/languages にインストールし WPLANG を 'de_DE' に設定すると、ドイツ語がサポートされます。
 */
define('WPLANG', 'ja');

/**
 * 開発者へ: WordPress デバッグモード
 *
 * この値を true にすると、開発中に注意 (notice) を表示します。
 * テーマおよびプラグインの開発者には、その開発環境においてこの WP_DEBUG を使用することを強く推奨します。
 */
define('WP_DEBUG', false);


// このサイトのURLを設定します
// 手動で設定する場合にはこの命令をコメントアウトするか削除する
//-------------------------------------------------------------------------------
define('WP_HOME', 'http://10.0.22.25/wordpress/');
define('WP_SITEURL', 'http://10.0.22.25/wordpress/');
// 上記の内容でDataBaseを変更します
define('RELOCATE', true);
//-------------------------------------------------------------------------------


/* 編集が必要なのはここまでです ! WordPress でブログをお楽しみください。 */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
