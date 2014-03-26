wordpress local dev env
=======================

CentOS(Red Hat system) + Apache + mySQL + wordpress

### Outline ###
---
<font color="black">**Please don't use this repository(wp-localdev) if you can help.**</font>  
Perhaps, It is possible for client to run this chef-solo in a local development environment: virtual OS applications(e.g. virtualbox + vagrant).  
In short, this cookbooks are only available in a temporary test environment.

### Requirement(Recommendation) ###
---
* [virtualbox][vb] 4.3.x
* [vagrant][vagr] 1.4.x
	* centos6.4(minimal) x86_64(intell 64bit cpu) box(for virtualbox)
	* centos6.4(minimal) i386(intell 32bit cpu) box(for virtualbox)
* [chef][opscode] 11.10.x
	* knife
* ruby 1.9.4-pxxx or higher(e.g. for rbenv)
	* openssl
* web browser
	* web browser of webkit system(e.g. chrome, safari)
	* web browser of mozilla system(e.g. firefox)
	* ~~web browser of windows system(e.g. IE)~~
* [hoster][hosterapp]

### Work Station(Recommendation versions) ###
---
* Mac OS X 10.7.x or higher

### Install Package ###
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

### Preparation ###
---
**1.** Command

	git clone git@github.com:mickey305/wp-localdev.git

**2.** Command

	git clone https://github.com/mickey305/wp-localdev.git

**3.** GUI  

<div style="margin-left:15px;">Please download a zip file from right side column.</div>


### How To - 1###
---
* **initialize**  
	Please edit the `nodes/wp-local-server.json` file and change the `roles/{mysql.json, savefiles.json}` files, as required.

		name$ cd wp-localdev/wp-local-server/
		name$ vagrant up
		name$ vagrant ssh-config --host wp-local-server >> ~/.ssh/config
		name$ cd ../chef_repo/
		name$ knife solo prepare wp-local-server
		name$ knife solo cook wp-local-server

* **movement, start, reboot & stop**

		name$ cd wp-localdev/wp-local-server/
		name$ vagrant up
		name$ vagrant reload
		name$ vagrant halt


* **sleep & resume**

		name$ vagrant suspend
		name$ vagrant resume

### How To - 2###
---
* **initialize**  
	Please click `init.app` after edit the `nodes/wp-local-server.json` file and change the `roles/{mysql.json, savefiles.json}` files, as required.  
	You may remove this application(`init.app`) from the repository.


* **movement, start, reboot & stop**  
	Same as the above


* **sleep & resume**  
	Same as the above

### Note ###
---

### Bibliography ###
---
* [MySQL - sql.list_dbs][MySQL]
* [GitHub - wordpress-cookbook][wp]
* [GitHub - Opscode-DataBase][db]
* [入門Chef Solo - Infrastructure as Code][bookchef]
* [misty-magic.h | 忘れないために][misty-blog]

----
[Reade me to Japanese][jpmd]








[vagr]: http://www.vagrantup.com/
[vb]: https://www.virtualbox.org/
[opscode]: https://learnchef.opscode.com/quickstart/workstation-setup/
[hosterapp]: http://www.redwinder.com/macapp/hoster/
[MySQL]: http://www.rubydoc.info/github/tmtm/ruby-mysql/Mysql:list_dbs
[wp]: https://github.com/brint/wordpress-cookbook
[db]: https://github.com/opscode-cookbooks/database
[bookchef]: http://tatsu-zine.com/books/chef-solo
[misty-blog]: http://mistymagich.wordpress.com/2013/10/08/db%E3%81%8C%E5%AD%98%E5%9C%A8%E3%81%97%E3%81%AA%E3%81%84%E3%81%A8%E3%81%8D%E3%81%ABdb%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8Bchef%E3%83%AC%E3%82%B7%E3%83%94%E3%82%92%E4%BD%9C%E3%81%A3%E3%81%9F/

[jpmd]: README_jp.md
