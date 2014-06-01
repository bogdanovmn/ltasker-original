--
-- Table structure for table 'component'
--

CREATE TABLE IF NOT EXISTS component (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  project_id int(11) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table 'helper_task_priority'
--

CREATE TABLE IF NOT EXISTS helper_task_priority (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table 'helper_task_status'
--

CREATE TABLE IF NOT EXISTS helper_task_status (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table 'helper_task_type'
--

CREATE TABLE IF NOT EXISTS helper_task_type (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table 'project'
--

CREATE TABLE IF NOT EXISTS project (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  description text NOT NULL,
  `owner` int(10) unsigned NOT NULL,
  create_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table 'task'
--

CREATE TABLE IF NOT EXISTS task (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  project_id int(10) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `owner` int(10) unsigned NOT NULL,
  create_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL,
  priority int(11) NOT NULL,
  `type` int(11) NOT NULL,
  close_date timestamp NULL DEFAULT NULL,
  description text NOT NULL,
  performer int(10) unsigned NOT NULL,
  component int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table 'task_history'
--

CREATE TABLE IF NOT EXISTS task_history (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  task_id int(10) unsigned NOT NULL,
  `event` int(10) unsigned NOT NULL,
  event_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id int(10) unsigned NOT NULL,
  details text NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table 'user'
--

CREATE TABLE IF NOT EXISTS `user` (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  email varchar(250) DEFAULT NULL,
  password_hash varchar(32) NOT NULL,
  create_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;
