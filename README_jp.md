wordpressローカル開発環境
=======================

CentOS(Red Hat系) + Apache + mySQL + wordpress

### 概要 ###
---
<font color="black">**このリポジトリは、互換性が全く無いものなので使用しないことをオススメします.**</font>  
ユーザーは、このシェフをローカル（テスト）開発環境下で扱うことができる: 仮想マシン環境（e.g. virtualbox + vagrant）.  

### 必要な環境(推奨されるもの) ###
---
* [virtualbox][vb] 4.3.x
* [vagrant][vagr] 1.4.x
	* centos6.4(minimal) x86_64(64ビット) box(for virtualbox)
	* centos6.4(minimal) i386(32ビット) box(for virtualbox)
* [chef][opscode] 11.10.x
	* knife
* ruby 1.9.4-pxxx or higher(e.g. for rbenv)
	* openssl
* ウェブブラウザ
	* webkit系(e.g. chrome, safari)
	* mozilla系(e.g. firefox)
	* ~~windows系(e.g. IE)~~
* [hoster(GUIホスティングツール)][hosterapp]

### ワークステーション(表示されているバージョンは推奨) ###
---
* Mac OS X 10.7.x or higher

### インストールされるパッケージ ###
---
* vim
* php
* php-xml
* php-common
* php-mbstring
* php-devel
* php-process
* php-cli
* php-pear
* php-mysql
* mysql
* mysql-server
* mysql-devel
* apache
* git
* zip
* unzip
* wordpress 3.8

### 準備 - 3通り ###
---
**1.** コマンド

	git clone git@github.com:mickey305/wp-localdev.git

**2.** コマンド

	git clone https://github.com/mickey305/wp-localdev.git

**3.** GUI  

<div style="margin-left:15px;">ダウンロードボタンからZIP形式で落とす</div>


### 方法 - 1###
---
* **初期化**  
	以下のコマンドを操作する前に必要に応じてJSONファイルを編集して下さい. 

		name$ cd wp-localdev/wp-local-server/
		name$ vagrant up
		name$ vagrant ssh-config --host wp-local-server >> ~/.ssh/config
		name$ cd ../chef_repo/
		name$ knife solo prepare wp-local-server
		name$ knife solo cook wp-local-server

* **移動, 起動, 再起動, 終了**

		name$ cd wp-localdev/wp-local-server/
		name$ vagrant up
		name$ vagrant reload
		name$ vagrant halt


* **スリープ, 復帰**

		name$ vagrant suspend
		name$ vagrant resume

### 方法 - 2###
---
* **初期化**  
	必要に応じてJSONファイルを編集して下さい.  
	`init.app`をクリックして下さい.  
	初期化が終了すれば、`init.app`は必要ないので削除しても構いません.


* **移動, 起動, 再起動, 終了**  
	同上


* **スリープ, 復帰**  
	同上

### 忘れないように - 自分にメモ ###
---

### 参考ページ及び文献 ###
---
* [MySQL - sql.list_dbs][MySQL]
* [GitHub - wordpress-cookbook][wp]
* [GitHub - Opscode-DataBase][db]
* [入門Chef Solo - Infrastructure as Code][bookchef]
* [misty-magic.h | 忘れないために][misty-blog]



----
[Read me to English][enmd]





[vagr]: http://www.vagrantup.com/
[vb]: https://www.virtualbox.org/
[opscode]: https://learnchef.opscode.com/quickstart/workstation-setup/
[hosterapp]: http://www.redwinder.com/macapp/hoster/
[MySQL]: http://www.rubydoc.info/github/tmtm/ruby-mysql/Mysql:list_dbs
[wp]: https://github.com/brint/wordpress-cookbook
[db]: https://github.com/opscode-cookbooks/database
[bookchef]: http://tatsu-zine.com/books/chef-solo
[misty-blog]: http://mistymagich.wordpress.com/2013/10/08/db%E3%81%8C%E5%AD%98%E5%9C%A8%E3%81%97%E3%81%AA%E3%81%84%E3%81%A8%E3%81%8D%E3%81%ABdb%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8Bchef%E3%83%AC%E3%82%B7%E3%83%94%E3%82%92%E4%BD%9C%E3%81%A3%E3%81%9F/

[enmd]: README.md

