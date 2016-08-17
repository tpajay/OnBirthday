# Host: localhost
# Database: birthday
# Table: 'advertise'
# 
CREATE TABLE `advertise` (
  `fname` varchar(100) default '',
  `busname` varchar(100) default '',
  `email` varchar(100) default '',
  `http` varchar(100) default '',
  `comment` varchar(255) default '',
  `phone` varchar(15) default '',
  `lname` varchar(100) default '',
  `createdttm` datetime NOT NULL default '0000-00-00 00:00:00',
  `busid` int(10) unsigned zerofill NOT NULL auto_increment,
  PRIMARY KEY  (`busid`)
) TYPE=MyISAM; 

# Host: localhost
# Database: birthday
# Table: 'comment'
# 
CREATE TABLE `comment` (
  `name` varchar(100) default '',
  `email` varchar(50) default '',
  `comment` varchar(255) default '',
  `createdttm` datetime default '0000-00-00 00:00:00',
  `id` int(10) unsigned zerofill NOT NULL auto_increment,
  `busid` varchar(100) NOT NULL default '',
  `busname` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM; 

# Host: localhost
# Database: birthday
# Table: 'customers'
# 
CREATE TABLE `customers` (
  `email` varchar(100) default NULL,
  `password` varchar(20) default NULL,
  `fname` varchar(50) default '',
  `lname` varchar(50) default '',
  `company` varchar(100) default '',
  `address1` varchar(200) default '',
  `address2` varchar(200) default '',
  `city` varchar(100) default '',
  `state` varchar(20) default '',
  `zipcode` varchar(15) default '',
  `phone1` varchar(15) default '',
  `phone2` varchar(15) default '',
  `ipaddress` varchar(100) default '',
  `spam` char(1) default '',
  `createdttm` datetime default '0000-00-00 00:00:00'
) TYPE=MyISAM; 

# Host: localhost
# Database: birthday
# Table: 'forum'
# 
CREATE TABLE `forum` (
  `Id` varchar(30) NOT NULL default '',
  `Id1` varchar(30) default '',
  `Moment` varchar(14) default '',
  `Subject` varchar(80) default '',
  `Author` varchar(255) default '',
  `Email` varchar(80) default '',
  `Url` varchar(80) default '',
  `Attach` varchar(255) default '',
  `Msg` varchar(100) default '',
  `Notify` char(1) default '',
  PRIMARY KEY  (`Id`)
) TYPE=MyISAM; 

# Host: localhost
# Database: birthday
# Table: 'patsy_config'
# 
CREATE TABLE `patsy_config` (
  `gallery` varchar(100) NOT NULL default '',
  `dir` varchar(255) NOT NULL default '',
  `outputdirectorypath` varchar(255) NOT NULL default '',
  `title` varchar(100) NOT NULL default '',
  `header` varchar(100) NOT NULL default '',
  `footer` varchar(100) NOT NULL default '',
  `bgcolor` varchar(100) NOT NULL default '',
  `fgcolor` varchar(100) NOT NULL default '',
  `fontface` varchar(100) NOT NULL default '',
  `fontsize` varchar(100) NOT NULL default '',
  `cols` varchar(100) NOT NULL default '',
  `space` varchar(100) NOT NULL default '',
  `width` varchar(100) NOT NULL default '',
  `height` varchar(100) NOT NULL default '',
  `border` varchar(100) NOT NULL default '',
  `names` varchar(100) NOT NULL default '',
  `target` varchar(100) NOT NULL default '',
  `filenames` varchar(100) NOT NULL default ''
) TYPE=MyISAM; 

# Host: localhost
# Database: birthday
# Table: 'products'
# 
CREATE TABLE `products` (
  `sku` varchar(100) default '',
  `description` varchar(255) default '',
  `details` text,
  `picture` blob,
  `price` varchar(100) default '',
  `listprice` varchar(100) default '',
  `stock` varchar(100) default '',
  `imagelink` varchar(250) default '',
  `imagelinklarge` varchar(250) default '',
  `orderlink` varchar(250) default '',
  `category` varchar(100) default '',
  `subcategory` varchar(100) default ''
) TYPE=MyISAM; 

# Host: localhost
# Database: birthday
# Table: 'restaurants'
# 
CREATE TABLE `restaurants` (
  `name` varchar(100) default '',
  `address1` varchar(100) default '',
  `address2` varchar(100) default '',
  `city` varchar(100) default '',
  `state` varchar(30) default '',
  `zipcode` varchar(15) default '',
  `phone1` varchar(15) default '',
  `phone2` varchar(15) default '',
  `http` varchar(100) default '',
  `freemeal` char(1) default '',
  `createdttm` datetime default '0000-00-00 00:00:00',
  `banner` blob,
  `category` varchar(100) default '',
  `category2` varchar(100) default '',
  `nationwide` char(1) default '',
  `nonstate` char(1) default '',
  `busid` int(5) unsigned zerofill NOT NULL auto_increment,
  `details` varchar(255) default '',
  `approved` char(1) default '',
  `forkids` char(1) default 'N',
  `sendername` varchar(100) default '',
  `senderemail` varchar(100) default '',
  `paid` char(1) default 'Y',
  `expiresdttm` date default '0000-00-00',
  `states` text,
  PRIMARY KEY  (`busid`),
  FULLTEXT KEY `states` (`states`)
) TYPE=MyISAM; 

# Host: localhost
# Database: birthday
# Table: 'siteaccess'
# 
CREATE TABLE `siteaccess` (
  `ipaddress` varchar(100) NOT NULL default '',
  `host` varchar(100) NOT NULL default '',
  `referrer` varchar(100) NOT NULL default '',
  `createdttm` datetime NOT NULL default '0000-00-00 00:00:00',
  `counter` int(10) unsigned zerofill NOT NULL auto_increment,
  PRIMARY KEY  (`counter`)
) TYPE=MyISAM; 


# Host: localhost
# Database: birthday
# Table: 'users'
# 
CREATE TABLE `users` (
  `userid` varchar(10) default NULL,
  `password` varchar(10) default NULL,
  `fname` varchar(50) default '',
  `lname` varchar(50) default '',
  `address1` varchar(100) default '',
  `address2` varchar(100) default '',
  `city` varchar(100) default '',
  `state` varchar(30) default '',
  `zipcode` varchar(15) default '',
  `phone1` varchar(15) default '',
  `phone2` varchar(15) default '',
  `email` varchar(50) default '',
  `ipaddress` varchar(100) default '',
  `spam` char(1) default '',
  `createdttm` datetime default '0000-00-00 00:00:00'
) TYPE=MyISAM; 

