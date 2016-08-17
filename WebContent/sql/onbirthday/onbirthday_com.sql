-- 
-- Table structure for table `advertise`
-- 

CREATE TABLE `advertise` (
  `busid` int(5) unsigned zerofill NOT NULL auto_increment,
  `fname` varchar(100) default '',
  `lname` varchar(100) default '',
  `busname` varchar(100) default '',
  `phone` varchar(15) default '',
  `email` varchar(100) default '',
  `http` varchar(100) default '',
  `comment` text,
  `createdttm` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`busid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=15 ;


-- --------------------------------------------------------

-- 
-- Table structure for table `comment`
-- 

CREATE TABLE `comment` (
  `id` int(10) unsigned zerofill NOT NULL auto_increment,
  `name` varchar(20) default NULL,
  `email` varchar(50) default '',
  `comment` text,
  `busid` varchar(10) default NULL,
  `busname` varchar(100) default NULL,
  `createdttm` datetime default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=315 ;


-- --------------------------------------------------------

-- 
-- Table structure for table `customers`
-- 

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
  `spam` char(1) default '',
  `createdttm` datetime default '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

-- 
-- Table structure for table `image_config`
-- 

CREATE TABLE `image_config` (
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
  `filenames` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

-- 
-- Table structure for table `products`
-- 

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

-- 
-- Table structure for table `restaurants`
-- 

CREATE TABLE `restaurants` (
  `busid` int(5) unsigned zerofill NOT NULL auto_increment,
  `name` varchar(100) default '',
  `address1` varchar(100) default '',
  `address2` varchar(100) default '',
  `city` varchar(100) default '',
  `state` varchar(30) default '',
  `states` text,
  `zipcode` varchar(15) default '',
  `phone1` varchar(15) default '',
  `phone2` varchar(15) default '',
  `http` varchar(255) default NULL,
  `freemeal` char(1) default '',
  `forkids` char(1) default 'N',
  `nationwide` char(1) default '',
  `category` varchar(100) default '',
  `description` text,
  `details` text NOT NULL,
  `banner` blob,
  `approved` char(1) default '',
  `sendername` varchar(100) default NULL,
  `senderemail` varchar(100) default NULL,
  `expiresdttm` date default NULL,
  `createdttm` datetime NOT NULL default '0000-00-00 00:00:00',
  `paid` char(1) default 'Y',
  `nonstate` char(1) NOT NULL default '',
  PRIMARY KEY  (`busid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=277 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `siteaccess`
-- 

CREATE TABLE `siteaccess` (
  `counter` int(10) unsigned zerofill NOT NULL auto_increment,
  `referrer` varchar(200) NOT NULL default '',
  `host` varchar(200) NOT NULL default '',
  `ipaddress` varchar(100) NOT NULL default '',
  `createdttm` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`counter`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=32283 ;

-- --------------------------------------------------------

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

CREATE TABLE `users` (
  `userid` varchar(50) NOT NULL default '',
  `password` varchar(50) NOT NULL default ''
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

