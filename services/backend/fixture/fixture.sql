-- Phases
INSERT INTO api.phases (id, name, description) VALUES (1,'Maybe','The status of this item has not been decided yet. Either it has not been investigated, or Kumoris community of experts, is currently investigating this item.') ON CONFLICT DO NOTHING;
INSERT INTO api.phases (id, name, description) VALUES (2,'Buy','The buy phase of technology lifecycle, is when we investigate and research. We want to make it really, really easy to innovate. What new technologies should we use? What is trending and hot, what is hot air? What should be made into a service? When we try out new things, it is important to realize, that an experiment can either succeed or fail! In case of failure, lessons should be learned, and experiment should be thrown away, and we should move on happy, that it was only an experiment.') ON CONFLICT DO NOTHING;
INSERT INTO api.phases (id, name, description) VALUES (3,'Hold','This phase of the lifecycle, is when a technology is well established, well known and mature. We know its quircks, we know how to deal with them. There is no rational reason, to have too many tools that do the same job. Therefore technologies in this phase are subject to Formal Governance, an intentionally high wall, to protect ourselves from unnecessary complexity.') ON CONFLICT DO NOTHING;
INSERT INTO api.phases (id, name, description) VALUES (4,'Sell','The day has come, where a technology has reached the end of the lifecycle, and should be retired. It is outdated, we have better alternatives, and it is really troublesome to keep supporting this oldie. For the sake of the planet, let us reduce the carbon footprint, and clear this one from the data centers.') ON CONFLICT DO NOTHING;


-- Statuses
INSERT INTO api.statuses (id, name, phase, description) VALUES (1,'To be decided',1,'test') ON CONFLICT DO NOTHING;
INSERT INTO api.statuses (id, name, phase, description) VALUES (2,'Experiment',2,'test') ON CONFLICT DO NOTHING;
INSERT INTO api.statuses (id, name, phase, description) VALUES (3,'Testing',2,'test') ON CONFLICT DO NOTHING;
INSERT INTO api.statuses (id, name, phase, description) VALUES (4,'POC',2,'test') ON CONFLICT DO NOTHING;
INSERT INTO api.statuses (id, name, phase, description) VALUES (5,'Default',3,'test') ON CONFLICT DO NOTHING;
INSERT INTO api.statuses (id, name, phase, description) VALUES (6,'Limited',3,'test') ON CONFLICT DO NOTHING;
INSERT INTO api.statuses (id, name, phase, description) VALUES (7,'Deprecated',4,'test') ON CONFLICT DO NOTHING;
INSERT INTO api.statuses (id, name, phase, description) VALUES (8,'Do not use',4,'test') ON CONFLICT DO NOTHING;


-- taxonomy

INSERT INTO api.taxonomy (id, name, level, parent) VALUES
(1,'Business Application Services',1,null),
(2,'Infrastructure Services',1,null),
(3,'Data Center',2,2),
(4,'Enterprise Data Center',3,3),
(5,'Other Data Center',3,3),
(6,'Network',2,2),
(7,'Data Network',3,6),
(8,'Voice Network',3,6),
(9,'Internet Connectivity',3,6),
(10,'Domain Service',3,6),
(11,'Load Balancing',3,6),
(12,'Compute',2,2),
(13,'Physical Compute',3,12),
(14,'Virtual Compute and Containers',3,12),
(15,'Compute on Demand',3,12),
(16,'Mainframe',3,12),
(17,'Storage',2,2),
(18,'Delivery Services',1,null),
(19,'Strategy and Planning',2,18),
(20,'Plan',3,19),
(21,'Technology Business Management',3,19),
(22,'Innovation and Ideation',3,19),
(23,'Enterprise Architecture',3,19),
(24,'Program and Project Management',3,19),
(25,'Business Solution Consulting',3,19),
(26,'IT Vendor Management',3,19),
(27,'Development',2,18),
(28,'Design and Development',3,27),
(29,'Architecture',4,28),
(30,'Requirements',4,28),
(31,'Design',4,28),
(32,'Languages and Libraries',4,28),
(33,'Ad hoc scripting',5,32),
(34,'Application Development',5,32),
(35,'Frameworks',4,28),
(36,'IDE and plug-in’s',4,28),
(37,'Source Control',4,28),
(38,'Artifact Repositories',4,28),
(39,'Building',4,28),
(40,'Deployment',4,28),
(41,'Continuos Delivery',5,40),
(42,'Developer communication',4,28),
(43,'Development instant messaging',5,42),
(44,'System integration',3,27),
(45,'Data transport',4,44),
(46,'Testing',3,27),
(47,'Unit testing',4,46),
(48,'Functional testing',4,46),
(49,'Integration testing',4,46),
(50,'Testing Frameworks',4,46),
(51,'Support',2,18),
(52,'Service Desk',3,51),
(53,'Application Support',3,51),
(54,'IT Training',3,51),
(55,'Central Print',3,51),
(56,'Operations',2,18),
(57,'IT Service Management',3,56),
(58,'Monitoring',3,56),
(59,'Event Gathering',4,58),
(60,'Application Level Event Gathering',5,59),
(61,'Logging',3,56),
(62,'Capacity Management',3,56),
(63,'Deployment and Administration',3,56),
(64,'Security and Compliance',2,18),
(65,'Security',3,64),
(66,'Storage of secrets',4,65),
(67,'Storage of machine secrets',5,66),
(68,'Storage of human secrets',5,66),
(69,'Governance, Risk and Compliance',3,64),
(70,'Business Continuity and Disaster Recovery',3,64),
(71,'Platform Services',1,null),
(72,'Data',2,71),
(73,'Database',3,72),
(74,'Distributed Cache',3,72),
(75,'Data Management',3,72),
(76,'Data Warehouse',3,72),
(77,'Data Analytics and Visualization',3,72),
(78,'Machine Learning',3,72),
(79,'Applications',2,71),
(80,'Application Hosting',3,79),
(81,'Message Bus and Integration',3,79),
(82,'Content Management',3,79),
(83,'Search',3,79),
(84,'Streaming',3,79) ON CONFLICT DO NOTHING;

-- component

INSERT INTO api.components (name, description) VALUES (
  'Apache HTTP Server', 'The Apache HTTP Server is an open-source HTTP server for modern operating systems including UNIX, Microsoft Windows, Mac OS/X and Netware. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services observing the current HTTP standards. Apache has been the most popular web server on the Internet since April of 1996.'
  );

-- usecases
INSERT INTO api.usecases (name, description) VALUES (
  'HTTP Server', 'Serve resources via the http protocol'
  );
