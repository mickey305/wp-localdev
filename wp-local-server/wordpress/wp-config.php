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



define('AUTH_KEY',         'D+C$rbBtk7Jt5tG-*Xcl,-OVhT$,>Y82N)00fC>m5M`]MbJ{-wOAp{jTTli !v*U935a753e6915f6e8c8f2089dd33d4c25a78492d1');
define('SECURE_AUTH_KEY',  'N4Ms,uI;t~y/&EQGI#iGCj6puqy(H?p^=;6}%=?.qpd[o.n|uPfLlf T[7}yQgBo8a0b9ebb9d36ca574b353539da8a54cdf52e5ae1');
define('LOGGED_IN_KEY',    'YMe]mql!(;U{K:JP^ZcPp3HR15`Z]WdIi241U*(x_WRBYU`oTGc!Dt{vzH?YwuzW1df920fb333a0ad7cc962392c3d842c6af3cf689');
define('NONCE_KEY',        'da^6nXNF%R{Q-J_:ZhE*@}.Km5MvX0=}K!sesIwpnE(iqg1}~EVSHIOg*3]|*T?g9055336adcf880416b0eaabbcbc996916efc89a4');
define('AUTH_SALT',        'BoH5axqr@Dcv21b[ Es`uwy/l#bqcw0c!e&KY VI_1(b(XemWADf;DdaqEBpTVQ97fb2ea88c01206a8874acc19a3ed60cff12f3aeb');
define('SECURE_AUTH_SALT', 'gLK:[``90kFHodcGbYx[3^5C~6/O5ZL{Ozw=(>?X-&Y}(F_v4;gIYk0>.T+}jI(Z1272887a070d3ebafb757df23208712187e797c4');
define('LOGGED_IN_SALT',   'JUnv)b.-vDAr=|0YYvZbui2:g$C8G|t%mK*_Fo&Gz]@{keJ(&UH=`2~`L7IFzl(q0f9bc904fa04952752a4ee827b39229f195610c0');
define('NONCE_SALT',       '4g}Pi@[Ok@u_zRSbVOoyyvXuk`I.AF;v&q}2RfLu0W}0p0A.t=O@@l|e2:Zv9h&Q712ad59f8e129dcb44bcc5f021c51cd5fc57a91f');



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
