/*
SQLyog Ultimate v11.42 (64 bit)
MySQL - 5.6.21 : Database - erp
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`erp` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `erp`;

/*Table structure for table `act_evt_log` */

DROP TABLE IF EXISTS `act_evt_log`;

CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_evt_log` */

/*Table structure for table `act_ge_bytearray` */

DROP TABLE IF EXISTS `act_ge_bytearray`;

CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ge_bytearray` */

insert  into `act_ge_bytearray`(`ID_`,`REV_`,`NAME_`,`DEPLOYMENT_ID_`,`BYTES_`,`GENERATED_`) values ('2',1,'leaveBill.bpmn','1','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.activiti.org/test\">\n  <process id=\"Leavebill\" name=\"Leavebill\" isExecutable=\"true\">\n    <startEvent id=\"startevent1\" name=\"Start\"></startEvent>\n    <userTask id=\"usertask1\" name=\"æäº¤ç”³è¯·\" activiti:assignee=\"#{username}\"></userTask>\n    <sequenceFlow id=\"flow1\" sourceRef=\"startevent1\" targetRef=\"usertask1\"></sequenceFlow>\n    <userTask id=\"usertask2\" name=\"å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"cn.itcast.sys.listener.TaskListenerImpl\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow2\" name=\"æäº¤\" sourceRef=\"usertask1\" targetRef=\"usertask2\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'æäº¤\'}]]></conditionExpression>\n    </sequenceFlow>\n    <userTask id=\"usertask3\" name=\"å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"cn.itcast.sys.listener.TaskListenerImpl\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow3\" name=\"åŒæ„\" sourceRef=\"usertask2\" targetRef=\"usertask3\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'åŒæ„\'}]]></conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"endevent1\" name=\"End\"></endEvent>\n    <sequenceFlow id=\"flow4\" name=\"åŒæ„\" sourceRef=\"usertask3\" targetRef=\"endevent1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'åŒæ„\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow6\" name=\"é©³å›\" sourceRef=\"usertask2\" targetRef=\"usertask1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'é©³å›\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow7\" name=\"é©³å›\" sourceRef=\"usertask3\" targetRef=\"usertask1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'é©³å›\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow8\" name=\"æ”¾å¼ƒ\" sourceRef=\"usertask1\" targetRef=\"endevent1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'æ”¾å¼ƒ\'}]]></conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_Leavebill\">\n    <bpmndi:BPMNPlane bpmnElement=\"Leavebill\" id=\"BPMNPlane_Leavebill\">\n      <bpmndi:BPMNShape bpmnElement=\"startevent1\" id=\"BPMNShape_startevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"460.0\" y=\"90.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask1\" id=\"BPMNShape_usertask1\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"425.0\" y=\"170.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask2\" id=\"BPMNShape_usertask2\">\n        <omgdc:Bounds height=\"55.0\" width=\"156.0\" x=\"400.0\" y=\"270.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask3\" id=\"BPMNShape_usertask3\">\n        <omgdc:Bounds height=\"55.0\" width=\"151.0\" x=\"402.0\" y=\"370.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"endevent1\" id=\"BPMNShape_endevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"460.0\" y=\"470.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"flow1\" id=\"BPMNEdge_flow1\">\n        <omgdi:waypoint x=\"477.0\" y=\"125.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"477.0\" y=\"170.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow2\" id=\"BPMNEdge_flow2\">\n        <omgdi:waypoint x=\"477.0\" y=\"225.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"478.0\" y=\"270.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"490.0\" y=\"239.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow3\" id=\"BPMNEdge_flow3\">\n        <omgdi:waypoint x=\"478.0\" y=\"325.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"477.0\" y=\"370.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"478.0\" y=\"339.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow4\" id=\"BPMNEdge_flow4\">\n        <omgdi:waypoint x=\"477.0\" y=\"425.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"477.0\" y=\"470.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"477.0\" y=\"439.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow6\" id=\"BPMNEdge_flow6\">\n        <omgdi:waypoint x=\"556.0\" y=\"297.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"685.0\" y=\"297.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"685.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"530.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"689.0\" y=\"240.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow7\" id=\"BPMNEdge_flow7\">\n        <omgdi:waypoint x=\"402.0\" y=\"397.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"292.0\" y=\"397.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"292.0\" y=\"295.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"292.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"425.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"302.0\" y=\"289.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow8\" id=\"BPMNEdge_flow8\">\n        <omgdi:waypoint x=\"425.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"284.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"222.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"222.0\" y=\"264.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"222.0\" y=\"487.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"460.0\" y=\"487.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"181.0\" y=\"300.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),('3',1,'leaveBill.png','1','‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0+\0\0ş\0\0\0:b=\0\09èIDATxœíİl$å}?p+â \"\\5-nÕ–Mû–ÒrV‰û«ø¨Ê¹RÛXjÜüA-EI@QSTU©i•\\Õ„ª&=U)\"mB­V|ë*:°’ºR—¹òã8 —8À“â\0G–rË}7ß96Ë®w=kïÎ<ûìë¥NëõÌxİgçù¼Ïk{ \0\0ÈË@Ñ\'\0\0\0ô	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0È\0\0äG\0\0ò#\0\0\0ù‘@\0\0€üH \0\0@~$\0\0 ?\0\0	 `•JennnÏ=co\ZOï™-—ËEŸ \0t’P˜4x¤Icpp0ÍiŞØ¿ÿÖ;ïúÆzİşÕ¯}ò“Ÿšœœ\Z\ZÚ¹sçÌÌLÑ\'\0!\0àĞ¡CccciğH“Æ©•ÕÖuÏ½÷]}õ.,,}â\0°]@Şöîİ›Æ‰;ïúÆ¦Ù£¶|èàå—_~Í5×T*•¢G\0\0[\'\0ä\'\r“““ÓÓÓmeÚú‡o[^^.z(\0°E@NÒø±sçÎÙÙÙ-Çê›²Òã,--= \0Ø\n	 \'“““ÛÕwd¥!ÄÛ±\0èE@öîİ»7_5Öşı·NLL=,\0h›Ğu‡\Zí`üX¯|ä£7İtSÑƒ€öH \0]—Æ:Øñrô™g/¾¸ä½X\0ô	 »æææ&&&:?Öëãÿã}ûö=D\0hƒĞ]cccíşé¶¾\r2<<\\ô \r@•Ëå¡¡¡.Åõºì²Ë8Pô@ +	 ‹fff¦¦¦ºš@>sÃ\rÓÓÓE\0²’@\0ºèšk®¹é¦›ºš@î¼ëcccE\0²’@\0ºh||üö¯~­«	äÉ#G.¾¸Tô@ +	 ‹ºô{xkë•ã\'‹(\0d%\0tÑğğğÑgíjIk`ÀÅ€aÑè¢‘‘‘o>,\0@•E ‹ºúÇ@ü\0½Hè¢©©©/İ|sWÈ=÷ŞwÙe—=P\0ÈJè¢}ûö}üãÜÕ’&œ«¯şÃ¢\n\0YI \0]´´´T*•ºš@vïŞ=??_ô@ +	 »ºúÃè¯?144T©TŠ%\0d%\0tWWßˆõÙÏ}.=xÑC€6H \0İU©TJ¥R7ş*È+ÇO\\|qiyy¹è!@$€®›ıÀUWù\0$@>~ï}ïÛ¿ÿÖÆo>¼cÇWŸ(zd\0Ğ	 årù²Ë.ëÔ¤¿ğâ±4~<yäHÑÃ€¶I \09Y\\\\LCH\Z¶?~ï}ï»ı«_+z@\0°@~:´cÇ{î½o;o¾JcŒø@ï’@\0rU.—/¿üòO~òS/¼x¬­ìñÊñŸıÜçÖßÊUô \0`ë$€¼U*•4\\rÉHš(Ò\\‘%~|éæ›Óí?şñ?NsKÑ§\0Û\"\0cyyùºë®\Z\Zú½÷½/\r>t°.u¤÷ÜrËÿûÀUW¥Û\\}õ.--}Ê\0Ğ@‘*•ÊÜÜÜÔÔÔ;Ş*½\'³³³år¹èÓ€‘@\0Â’¦‘¢O\0ºHËÀ€+3\01³Î„E nÖ9€°H \0ÄÍ:	€¸Yç\0Â\"\07ë@X$\0âf‹@Ü¬s\0a‘@\0ˆ›u ,\0q³Î„E nÖ9€°H \0ÄÍ:	€¸Yç\0Â\"\07ë@X$\0âf‹@Ü¬s\0a‘@\0ˆ›u ,\0q³Î„E nÖ9€°H \0ÄÍ:	€¸Yç\0Â\"\07ë@X$\0âf‹@Ü¬s\0a‘@\0ˆ›u ,\0q³Î„E nÖ9€°H \0ÄÍ:	€¸Yç\0Â\"\07ë@X$\0âf‹@Ü¬s\0a‘@\0ˆ›u ,\0q³Î„E nÖ9€°H \0ÄÍ:P¼ÙÙÙ4x¦7†‡‡ÓÏ?ÿüÅÅÅ¢O\r\0:L(Şm·İ6Ğ`×®]sssEŸ\Z\0t˜P¼J¥rŞyçÕÆK/½txx¸\\.}j\0Ğa@®¿şúsÎ9§š@®½öÚééé¢O\n\0:OÅE]´?®ºêªR©T©TŠ>#\0è<	 wß}÷¹ç›&ññq?@¬$€€\\qÅë	¤è€n‘@\0²¼¼œ&¿„€ˆI \0añ	ˆ›uà¬J¥2;;;99966V*•\Zÿ:GŸHÇ>333~0\0İ \0$óóóiçÆ[n¹åÎ»îzòÈ‘S++ıYéØÓG`ÿşıW_}uú˜¤9¤è\'€ØH @_+—ËSSS»wï>úÌÑS+§Tm½ğâiIœååå¢Ÿ(\0â!\0ı+£££_ºù‹§VNªfuûWo¿ì²Ë–––Š~º\0ˆ„ô¯©©©µøñºj]wŞuÇå—ÿFÑO\0‘@€>5??¿{÷•+«•¥>ñgzÃ\rŸ.úI Ğ*•J©TzæÙ¥•Õ×T–:~âG;v\\ê•\0°}Ğfff¦¦¦VV_­Ö®ñßÉøûjk÷ê«ºá†¿š.ú© çI @?š˜˜Øë¿ÿ8~\\¹ûIòôéä‰•äÛ\'“GN&_İwë7¾şìË÷ŸJş·’Ü_Iîy5¹ãõäïïyì#×|´ğ0PH=tğÀèèhÑO\0=OúÑÈÈÈáÃ¯¬X¯ãIrâLòòjòÒ©äÕ$ù“?ÿÔÀÛ~rç•Ï®$GO&G_O–*É“«É—¿ùÈÚ·ANôa?qlpp°è§€\'\0ıhhhèÅcÏ®¬_¯4T¼z:9yúì§VÏœı÷+_ûÏŸÿ•_ı‹Ï|v5I^YM^^I^ZIÊIrÇ®%ãıYéØ‹}â\0ˆ€µèGk)â•j¥XM½–œ:ıÆårùï>ÿ…Oÿíç>wöñ­œIN­%“ûz¤nß¾*	€í³–\0ıh-Eü_µÎ&ÓÉ¯&?<¬$É©“\'G.¹d`àíƒïÿƒ«kw|ğàÃuûöUI \0lŸµèGk)âåj­¿ëØkÉs¯$Ï¿<xø{]tÑÛÏù‰w\\øÎÉ¾%<ğĞÁº}ûª$\0¶ÏZô£µQ®Vúákg’—*g¿òÂëÉ],şÚ÷¼óg~öÂ¡ŸúÂ¿|ùõ$9~2yõäÙï9ğ@İ¾}U\0Ûg-úQÚI¯®ş¨Zëu\ZB^^I~t*yî••û[Úñëïİõ[¿ıüÉä‡•äùJrìd’f{î nß¾*	€í³–\0ı¨.EŒíºüÑï<ñàc‹-Ş{pñŞ‡¿ïÑ#ÿuÿ·¿ùØSw|ü~÷Ş‡¿{à‘Ç{âû7şãÍ¸ê…\'	€Şe-úÑZy©¶>ö±fùƒè¿ÿş÷×íØW%\0°}Ö ­%cªİ’@\0Ø>k	ĞÎ&Ó/ªvK`û¬%@?ZK /¨vK`û¬%@?ZK Ï«vK`û¬%@?ZK ?Tí–ÀöYK€hÍÎÎ.--mø©µ²¼ÍÚòA¶°ãÖ¾VG†YwÀvj\0¨#\0qzüñÇ×î\\°ÿşºÏv<lø«{;˜\r¶v´n\'r¹üÁ~p}°?÷s?\'„\0…Ä©R©¼ímo[oÏ=÷Üw¿ûİµıñZkşƒmVíA\ZØúK´{›n_İ Å3éÈ«áM7İ488¸~äôÆğğğòòrÏ4\0½F¢•öÄµı÷;Şñ}èCi2IÖÈéÓÏm³jÒxÀê=-\"A£Úİ3nÙìšİ¹Í!§Şâââ/ÿò/×ÌÎ;K¥RÑO8\0½A¡÷¤äÂÂÂ={ÆŞ”¶>m5y0p¶5vkµá¡:û%Ö˜ıÃMÏp›\'S{äô×¡g€nI/‰ÕËcz©œŸŸ/—ËE_¹~L¡—¤Ácbbbppp}Y]xSï¾û<¾åÂ/¬ödkÒÇyqq1yã{ Ïl³jÒxÀ,÷´¸¿îÎÖf9ÃÔÀÚ÷@Òùù›¿ù›¿ø‹¿X}x/¸à‚ÑÑÑ¢ŸpŞ>AÕ‹Iza\Z\ZJ\'ÿÜÜ\\Ñ§p–BoX^^^ÿÿ¼hVĞøFšr¹¼ŞŒŒ|øÃNÿ­~v­5?ºÍª=Hã³Ü“}ãVc@İ‡Úş«áüüüÅ_ü¿ğëG>ï¼óÖßáF˜Öÿ¿#\rŠë! @= mtÒö1]>‹>‘‰oDzúé§ÇÇÇK¥Òôôtİ»PÖzñïo³ÖRıw£v¿~ãfiÜ uh<ZGF”eÈµc\Z9öìÙóK¿ôKi_›ş{èĞ¡|ŸdÚ–>Gé“U›Æò\'º¹¹¹±±±˜ŞÄßˆ‚•>Ô333¾¥­S	$ãqšÅŒÖ	$û‡u÷dI,I ëÒG8}œ}7¯W¤¹qrr2}ÊŠ> I -ílFGGcjÖãQZëÈŸŞN½ÙÖÿøv“¾ƒ7¼İb³M?Üô°Ûoõ8E?ut@\ZBÆÆÆ8Pô‰\0}ÊZBĞvîÜÙ\ZßˆzÔÙüÌÒÖêh±vcÃÏf9Â¦[Ö}¶õ‡u÷lœ…¶:Şº¯RôSGg,--ŒŒøÑ ÖÂ577711QôYtR|#ê]kùSÛ¬ÚƒTog<ò¦›µø¾Ê›‰bó“Éşå²¹è§¹îºëöíÛWôY\0ıÈZB¸ÆÇÇççç‹>‹NŠoD½k­#ÿŞ6«ö ÕÛo\r	­vl}uŸmıaİ1›$–íwıÈE?utÌâââÈÈHÑgô#k	Z^^.ú,:)¾õ´µüÈ6«ö ÕÛ­üfØàÙ¿Ö¦GnÜ¸#ã]?NÑOä}¡@!¬%*¾7,Å7¢¶Ö‘?¹åZß½zÚ›ùÍ„õş\r¿bÆ\r\Zoos¼µG+ú©£“¼(„µ„@Å·.Æ7¢¶Ö‘?±ª¡öP½÷é‰êÖGk½Y[\'\\·ñö[{¨¢Ÿ::ÉÿŒ\0…°–¨±±±Èş`_|#êilÊûª$ÈøQ Öß»“ãQOK;é3gWí–™¥¥¥R©TôY\0}ÇZB ÒEqÃ?eİ»âQO[K ßUí–Ï)?×544ÙoD=m-,ªvK·\ZÏ)?×ß¢ßˆzÚZùj·LãøxNü¹î¨øÅøFÔÓ_{íá3g¾­Ú*Ó8>S ®;*¾E1¾õ´R©ôÔS_?sæ°j«LãøxNü¹î¨øÅøFÔÓÆÇÇÿcş¦3É·TöúÎâWüæÖø¸4ùsİ!Pñ-Šñ¨§íİ»wzúC…÷ô½Uÿ<ó™©©©¢Ÿ::Ì¥	ÈŸëŠoQŒoD=miiidä]¯U<“<¦2ÖÄÄsssE?ut˜K?×ß¢ßˆzİ³®9“<ª²Ô¿ÍşÍääxÑO\ZçÒäÏu‡@Å·(Æ7¢^W©TÆÆŞ{àÀ¿&É#ªu-/ß52ò®rù¢Ÿ4:Ï¥	ÈŸëŠoQŒoDX\\\\½dqq.I©f•Æ4ª-,|±è§‹®piòçºC â[ãQ8†½{ÿ(IV57÷¹‘‘ÒÂÂ?ıDÑ-.M@ş\\wT|‹b|#ŠF¥R™\Z{ÏÌÌ_./ß‘$U¹üß³³=9¹{bb,½]ôSD¹4ùsİ!Pñ-Šñ(2SS¿;<üÓ\r]09ye\ZBŠ~Zèº—& w®;*¾E1¾Ñ%şæyriòçºC â[ã]bª\'ó\rÈŸëŠoQŒoDt‰©BÌ7 ®;*¾E1¾Ñ%¦\ny2ß€ü¹î¨øÅøFD—˜*äÉ|òçºC â[ã]bª\'ó\rÈŸëŠoQŒoDt‰©BÌ7 ®;*¾E1¾Ñ%¦\ny2ß€ü¹î¨øÅøFD—˜*äÉ|òçºC â[ã]bª\'ó\rÈŸëŠoQŒoDt‰©BÌ7 ®;*¾E1¾Ñ%¦\ny2ß€ü¹î¨øÅøFD—˜*äÉ|òçºC â[ã]bª\'ó\rÈŸëŠoQŒoDt‰©BÌ7 ®;*¾E1¾Ñ%¦\ny2ß€ü¹î¨øÅøFD—´;U¶<µÌI’-M3Ø&ß\nßˆè’í$tğkŸº9Ğlò4»½á^mMB ¹(¨øV¬øFD—l3´u4Ó’s 1œ4ÛŞ4Úâ¢@ â[±â]Ò¥²éÿRûëşÔzÎlºqëû³|èC.\n*¾+¾Ñ%§Ê†±Aœ ]ÙH–ïl8÷LB ‹ŠoÅŠoDtI·ß…µµÿÆ&VHöoµµ¾ ‘@V|+V|#¢KŠJ [øÒD KœØtbH @[\\T|+V|#¢K¶–@2¾kÓo€˜¨ıfÃÒú]|¾l“‹ŠoÅŠoDtÉHÆ]Zt„šÅ¾ÕúßôYY63©€:.\n*¾+¾Ñ%mM•ºŸ÷m¦õW19û™äÏE@Å·bÅ7\"º$û74jßµ…ƒ´ØşÑâyuñ5Ë|Û0úšc@ßŠßˆè’-¼«ñv»ïË¢o5ş¤P³ğ°åÄkšu\\T|+V|#¢K:•@Z¼«vc3³ÏµxKUãg[|Ã¤­/ô9ßŠßˆè’¾²á»kèOÙÃCëï´ÖñÓzš‹ŠoÅŠoDtIö©R×Ö~ØúÍıÙï\'z-ŞUÕ,¦¶ş¶IÆ/ô3ßŠßˆè’¶¦J³÷ë7şt–Œá¬ûĞ¦o¬ÚpJ˜\'Àv¸|¨øÖ¶øFD—˜*äÉ|òçºC â[ã]bª\'ó\rÈŸëŠoQŒoDt‰©BÌ7 ®;*¾E1¾Ñ%¦\ny2ß€ü¹î¨øÅøFDÍÎÎ¦3dppptt4½1<<œş{şùç/..}jDÎ¥	ÈŸëŠoQŒoDtĞm·İÖø¬víÚ577Wô©9—& ®;*¾E1¾ÑA•Jå¼óÎ«—^zéğğp¹\\.úÔˆœK?×ß¢ßˆè¬ë¯¿şœsÎ©&k¯½vzzºè“\"~.M@ş\\wT|‹b|#¢ã.ºè¢õøqÕUW•J¥J¥Rô?—& ®;*¾E1¾Ñqwß}÷¹ç›N•ññq?B>\\š€ü¹î¨øÅøFD7\\qÅë	¤è¡_¸4ùsİ!Pñ-ŠñˆnX^^N§Š_ÂKn\\š€ü¹î¨øÅøFD—˜*äÉ|òçºC â[ãQ*•ÊìììäääØØX©Tjü“\Z+}RÒ§fbbbffÆoÓ€K;×ß¢ßˆ\n7??Ÿ6¸iü¸å–[î¼ë®\'9µ²¢‚ªôIIŸšıû÷_}õÕé“•æ¢g\rõ\\š€ü¹î¨øÅøFT r¹<55µ{÷î£Ï=µrJõD½ğâiIŸµååå¢g?æÒäÏu‡@Å·(Æ7¢¢¤ñcttôK7ñÔÊIÕsuûWo¿ì²Ë–––ŠG¼Á¥	ÈŸëŠoQŒoDE™ššZ‹¯«­;ïºãòË£èyÄ\\š€ü¹î¨øÅøFTˆùùùİ»¯\\Y­¨®OüÙŸŞpÃ§‹MœåÒäÏu‡@Å·(Æ7¢üU*•R©ôÌ³K+«¯©®ã\'~´cÇ¥şìI\\š€ü¹î¨øÅøF”¿™™™©©©•ÕW«µküw2şZØÚ½TuÃ\r5==]ôœÂ¥	(€ëŠoQŒoDù›˜˜Øë¿W[Ø]WîşA’<}:yb%ùöÉä‘“ÉƒÇW÷İú¯?ûòı§’ÿ­$÷W’{^Mîx=ùû{ûÈ5-¼çVµõĞÁ£££EÏ)\\š€¸î¨øÅøF”¿‘‘‘Ã‡^Y=±^éCz<INœI^^M^:•¼š$òçŸ\ZxÛOî¼râÙ•äèÉäèëÉR%yr5ùò7Yû6È	N?qlpp°è9…KP\0×ß¢ßˆò744ôâ±gWV¯Wú¾z:9yúì§VÏœı÷+_ûÏŸÿ•_ı‹Ï|v5I^YM^^I^ZIÊIrÇ®%ã*¨ò¢gÈŸëŠoQŒoDù[K¯T+ığÄjrìµäÔé76(—Ë÷ù/|úo?ô¹³ónåLrj-™Ü÷Ğ#uûªÊ‹\" ®;*¾E1¾åo-Eü_µÎ&ÓÉ¯&?<¬$É©“\'G.¹d`àíƒïÿƒ«kw|ğàÃuûªÊ‹\" ®;*¾E1¾åo-E¼\\­õwa{-yî•äù×“ï¢‹.zû9?ñß9ùÁ·$:X·¯\n¡¼(BàY\0òçºC â[ãQşÖRD¹Zé‡¯I^ªœıÈ¯\'w=°øk;ŞóÎŸùÙ‡~êÿòå×“äøÉäÕ“gw¼çÀuûªÊ‹¢pËËËÃÃÃEŸĞw\\ı	T|­I|#Ê_ú®®ş¨Zëi\ZB^^I~t*yî••û[Úñëïİõ[¿ıüÉä‡•äùJrìd’f{î n_ByQnii©T*}@ßqõ\'Pñµ&ñ(u)bl×å~ç‰[<phñŞƒ‹÷>üø}ù¯û¿ıÍÇºûàãÿsğ»÷>üİ<şØß¿ñoşÀU(¼áVuåEQ¸ùùùñññ¢Ïè;®ş*¾Ö$¾åo-¼T[ûØG³üAôßÿûëvT!”Eáö¬)ú,€¾ãêO âkMâQşÖÈ1MyQn|||~~¾è³\0ú«?Š¯5‰oDù;›@N¿¨¢)/Šb-//—J¥J¥Rô‰\0}ÇÕŸ@Å×šlsDñ= [°–@^PÑ”Y]¬}ûö]wİuEŸĞ\\ı	T|­I‹ÕıĞÂ†»4î¾é?t|…[K Ï«h*ÊYÚ+*•J©TZ^^.úD€~äêO âkM2¨n³õ7Ü·õã{\0“7ÈU4å,íSSS333EŸĞ§\\ı	T|­IÆÀ°á÷:¶sÀ˜¬%å­UÆ}›m¶/İóéÔöÅV”³´\'ìÛ·ïšk®)ú,€şåêO âkM¶–@²|dÃ7_Å÷\0&ÛK »óÚmšİn±o£mF…êfÍŞk×úü[ïÒlƒfgŞÖ\0%0U*•©©)ñ(–«?Š¯5i=¢\r“C³ÛYv‰ïLŞH ?ÈX­Ûë·öĞoÙkÓÛÙ¿bë³°õ=~¸é^YÎ¡Å.ÙÇ˜e€EÏ©>R.—÷íÛW*•¼ù\n(œ«?Š¯5i7lúôg9}ú¹ŒÕ¸ñ†»×İYûá†·[œC]kŞîéµ;„Ÿm½Ùö?•}˜›°è9¿………½{÷NLL¤Ùãºë®ó£ç@\\ı	T|­É¦	¤V–İû5<›¥6Ü²ñÎê=ÿµ_·}í–-¾híî[8Ãfç¶á^uGhüpCY¶Ùtm´õqÆÆÆZŸÛ”>ÂÓÓÓsssår¹èW0À\"ìQˆÃ@t\rtö\rlö¬,›Å÷\0&o$g²×¦ÍÙ†»´¸İúZ¹ÅÚôÌ÷ªÛ}Ãû¿D³½Ú=É¶FÚúøEÏ)\0\nàêO âkM$í[ëwf¯ºí[ØxgM“}´z£õ—Ë²YİÆoíæ³!Ë.-n´x2nĞÖ`[¤è9@\\ı	T|­I–U»ºº½6Ü·6lÔÊşåzÎZ¿ûıìU·}ëkï¬ı·ÅÆû¾Ù”·}n·É2„ÆÏ6Şh<çf:2Ø)zNP\0W6Ñº÷İÚî]İ1X-FÔ\"<dI í~¹Şµ…Òn{]{±	¤YüØğ¬6Z–²µs“@\0ØW6×Ø%´Õ7l­Éˆ¯5Éê¶l¶c¿&§³Wİö­?\\¿§öÎf·[|¹º#d?·f‡ª=àú,gU·eãíœÛÛâ EÏ)\0\nàêÏV´è\Zÿ/¶Ñ6¿DÊ>¢Æ4²á¾yœ{ËÙ~÷ÌRöªÛ¾Å‡o4Ó\rw6Û·Ù—ûq_Şæ¹eÙ zOã©¶Ø¬Ùì¶9ÒÖc,zNP\0WšjÖÔfo\Z¶Ó^Ä×šl:¢Æ‡·Ùí,ŒïLŞH Oe¯½õ»´¾İâZ¹ÅÊ>œÚuGh¼³Ù=›É¦çÖÖH[§è9@\\ıÙÄ†ï†É¤õí¶\Zñµ&YFTİfÃGµÙCİ?Öúİïe¯ºí[ØxçúíÚ›íUıÔ[[ó6Î­õ1·pòbkÔv†¹éèŠS\0ÀÕŸM´Í\Zˆ,™¤­¯øF”¿µ~÷È–+ËîµÛ¼Ùa¿åşiLæ[>™Æ#4ŞŞğuw6;Bö½¶3Æ,vÑs\n€¸ú³‰ºn#Ùì­A»4!ã×íÈù‡#¾åo­ß}rËÕz÷õÏÖnS·}MÏİô5èM?ÕLãWÏr»İÏf|2pËÏHÑs\n€¸ú³‰š÷ÕİHºùŞªøZ“øF”¿µ~÷‰-×¦»oóøİ®7;şLçÜîı…<^\0ıÉÕŸMl9d{¿VÆİ#ßˆòxBPí–@rõg-‚GëîA©ßˆò—>†gÎ<®¢)/\n€şäêÏ&ÚJ ÙßéıëF#¾åo-|WES^\0ıÉÕŸMl˜@\Z?l±cÆí[ïøF”¿µ²¨¢)/\n€şäêO+Í~äÃ»°¶ ¾åo-|GES^\0ıÉÕŸVj“F[?‰¾á´¶ğ¥cßˆò788øÚkŸ9ómGyQ\0ô\'WšÚ0id‰vH|#Ê_©Tzê©¯Ÿ9sXÅQ^\0ıÉÕŸ6dùGöïŠlíkõ®øF”¿ñññÿ˜¿éLò-A}gñ+###EÏ)\0\n %\"Pñõëñ({÷îşPá­³êHıóÌg¦¦¦ŠS\0@KD âë×ãQş–––FFŞõZåÁ3Écª×kbâŠ¹¹¹¢ç\0Ğ¨øúõøFTˆ=g]s&yTõtıÛìßLN=›\0(†–ˆ@Å×¯Ç7¢BT*•±±÷8ğ¯IòˆêÑZ^¾kdä]åò=EÏ&\0Š¡%\"Pñõëñ¨(‹‹‹££—,.Î%É!Õs•Æ4C.,|±èy@a´D*¾~=¾èÀiÙ»÷’äaÕC57÷¹‘‘ÒÂÂ?=ƒ\0(’–ˆ@Å×¯Ç7¢bU*•éé©±±÷ÌÌüåòòIrP[åòÏÎşõääî‰‰±ôvÑs€‚i‰T|ız|#\nÁÂÂÂÔÔïÿô\0\Zº`ròÊ4„=_\0‚–ˆ@\rD×¯Ç7\"ºÄ_É\0 nZ\"_¿ßˆèS€¸YçT|MX|#¢KL\0âf#Pñ5añˆ.1U\0ˆ›u@Å×„Å7\"ºÄT nÖ9_ßˆèS€¸YçT|MX|#¢KL\0âf#Pñ5añˆ.1U\0ˆ›u@Å×„Å7\"ºÄT nÖ9_ßˆèS€¸YçT|MX|#¢KL\0âf#Pñ5añˆ.1U\0ˆ›u@Å×„Å7\"ºÄT nÖ9_ßˆèS€¸YçT|MX|#¢KL\0âf#Pñ5añˆ.1U\0ˆ›u@Å×„Å7\"º¤#SÅ| X–(_ÿßˆè’õ©2Aİ^Ù7€Y“T|\rS|#¢Kª	$Ëf›Şiâ\Z+Š¯mŠoDtÉvHİıf\0²8¨ø:§øFD—Ô&o©ªÎ¨,ï×ò^,\0Âa5\"PñµJñˆ.Ùæ÷@\0 p0_wßˆè’-\'ßú\0 \'X–T|=S|#¢K6}“Uíf;6; \0Â²D âë™â]Ò˜@\Z?Ûxâ{ \0ôËŠ¯gŠoDtÉvH‹@ ,K*¾)¾Ñ%¾@Ü,K*¾)¾Ñ%[ş9º#\0@˜¬R*¾*¾Ñ%[øHİ.{mx\0Â‚D âë–â]Ò\'ZlÖl—\ro›„\0„ÀjD âk•â]²iiöM’Mİ$ V#_«ßˆè’,ßi6ü$:\0³,¨øz¦øFD—˜*\0ÄÍ:G âkÂâ]bª\07ëŠ¯	‹oDt‰©@Ü¬s*¾&,¾Ñ%¦\n\0q³Î¨øš°øFDÍÎÎ¦3dppptt4½1<<œş{şùç/..}j\0ĞaZ\"_¿ßˆè Ûn»­ñXíÚµknn®èS€Ó¨øúõøFDU*•óÎ;¯6~\\zé¥ÃÃÃår¹èS€Ó¨øúõøFDg]ıõçœsN5\\{íµÓÓÓEŸ\0t–ˆ@Å×¯Ç7\":î¢‹.ZW]uU©TªT*EŸ\0t–ˆ@Å×¯Ç7\":îî»ï>÷ÜsÓ©2>>î\'@\0ˆ•–ˆ@Å×¯Ç7\"ºáŠ+®XO EŸ\0t‹–ˆ@Å×¯Ç7\"ºayy9*~	/\0Ó¨øúõøFD—˜*\0ÄÍ:G âkÂâQ8*•ÊìììäääØØX©TjüÃ\Zä,}ÒçbbbbffÆ/ –ˆ@\rD×¯Ç7¢@ÌÏÏ§ın\Z?n¹å–;ïºëÉ#GN­¬¨b+}ÒçbÿşıW_}uúì¤9¤èi@@´D*¾~=¾®\\.OMMíŞ½ûè3GO­œRaÖ/¾æôiZ^^.zÊ\0-Š¯_oDÅJãÇèèè—nşâ©•“*üºı«·_vÙeKKKEO\0Š§%\"Pñõëñ¨XSSSkñãuÕ+uç]w\\~ùo=q\0(–ˆ@Å×¯Ç7¢ÍÏÏïŞ}åÊjEõV}âÏşô†>]ôô `Z\"_¿ßˆŠR©TJ¥Ò3Ï.­¬¾¦z«ŸøÑ—úk\'\0}NKD âë×ãQQfff¦¦¦VV_­Ö®ñßÉø[bk÷R…Ô\r7üÕôôtÑ“€\"i‰T|ız|#*ÊÄÄÄş[ÿ½ÚÑîºr÷’äéÓÉ+É·O&œL<¾ºïÖo|ıÙ—ï?•üo%¹¿’ÜójrÇëÉßßóØG®ùhá-xŸ×CŒ=‰\0(’–ˆ@Å×¯Ç7¢¢ŒŒŒ>üğÊê‰õJØãIrâLòòjòÒ©äÕ$ù“?ÿÔÀÛ~rç•Ï®$GO&G_O–*É“«É—¿ùÈÚ·AN¨ëø‰cƒƒƒEO\"\0Š¤%\"Pñõëñ¨(CCC/{veõøz¥ì«§““§Ï~jõÌÙ¿òµÿüù_ùÕ¿øÌgW“ä•Õäå•ä¥•¤œ$w<ğèZ9®Š-¯€>g Pñõ(ñ¨(k)â•j¥XM½–œ:ıÆårùï>ÿ…Oÿíç>wöOà­œIN­%“ûz¤n_UHy-\0ô9Ë\0Š¯G¬T*EŸEÖRÄÿUël9¼ğjòÃãÉJ’œ:yrä’KŞ>00øş?¸ºvÇ>\\·¯*¤â{uĞË\0Š¯G)•Jş tG¬¥ˆ—«µş.¬c¯%Ï½’<ÿzòàáï]tÑEo?ç\'Şqá;\'?ø–òÀCëöU…T|¯n\0Úb Pñõ(£££‡*ú,b°–\"ÊÕJ?|íLòRåì÷@^x=¹ëÅ_ÛñwşÌÏ^8ôS_ø—/¿$ÇO&¯<»ã=¨ÛWRñ½ºh‹e€@Å×£Œ-,,}1HçÆêêªµ>UÒòòJò£SÉs¯¬Ü÷ØÒ_ï®ßúíçO&?¬$ÏW’c\'“4ƒÜsÿuûªB*¾W7\0m±¨øz”©©©™™™¢Ï\"u)bl×å~ç‰[<phñŞƒ‹÷>üø}ù¯û¿ıÍÇºûàãÿsğ»÷>üİ<şØß¿ñoşÀU(¼ÿVñ½ºh‹e€@Å×£¬ÿ%ï¢Ï\"k	ä¥ÚúØÇ>šå¢ÿşûß_·£*¤â{uĞË\0Š¯GY\\\\)ú,b°–@©Ş­ø^İ\0´Å2@ ¢ìQü0zGœM §_T½[Q¾ºÈÎ2@ ¢ìQöíÛwİu×}=o-¼ z·¢|ue€@EÙ£T*•R©´¼¼\\ô‰ô¶µò¼êİŠòÕ\r@v–k²°°066VôYô¶µòCÕ»ë«€Œ,*âeÏ=Ş‹µk	dyÃjñ©,›eÜ={µ{Àm§¶ïvEüê Ë\0Š»G™/—ËEŸHOjİOgé¶k·iv»Å¾r\nÕÍšıŞáÖãm½Këßh¼ÍD ‘@Vô=Êüü|©TÚ³gi×Zƒûƒõjİ.¿µ\'şAí^›ŞnV­Ü¸ñ¦lwûÆmZŒ®úá¦{e9‡»dLÖ·/zP$Ë\0ê‡¥\\.§	$Í!ãããé………¢Ï¨7¤sãôéçÖ«öv³{\Zïlv„êí\rRıT­f›mzœ-oßzÈ->Ûz³íª­‡¥èI@‘,ªz”J¥2??Ÿ&±±±,ÿ—ÏÀÙ÷Ù´ª7j«ñÎÚíS»}ë#7¤Ù6-Nf›Ûox†Ínoøa‹Ç³õ6›9û#3Ğ7¯n\06d PzšYkpŸ©Vë¹nãê.-no¸Ë†_®ÅfÏRÙ¿ô†Ch|dZ·õ^ídöGÆ« ÏY”…fÖ\ZÜ£ÕjëÃÆ;kšæ£Õ-ªvûM«I\"ÚîöÍÆ˜e—7Z<b7Èøàxuô9Ë\0Ò£ĞÌZƒûıjµõaíµÿ¶Ø¸qß7›ìM¶ÌxÀv·oÜ&Ë?Ûx£qŒÍlóÁñêès–¥G¡™Æ†»İv¹öşŞJ ÍâÇ†£Øğ¡È’@¶<	€,,JB3k\rîÓÕjëÃõ{jïlv»YÕ4Ù›l™ñ€Ù·oˆ?Ş%Ë(ê¶l¼±ı±d|p¼ºúœe€@éQhælƒ{f©ZÙ?|£9n¸³Ù¾Ö[2@†7İ¦­í7¨ŞÓ8´›5»‘İv¯n€>g PzšYkpŸªV†^ù©ºª½sÃÛîÕøåšm³áÁ³T»Û7sãƒ³á›=-îÜôÜ²?2^İ\0}Î2@ ô(4³Öà~¯Zm}ØxçúíÚ›íUıÔ[[í7Ûô8ÛÙ¾ú¥Ûì†£Îx2›nÜÖÃRô$ H–¥G¡™µ÷H³jıÙÆmŞì˜ßr‹ƒlô=–mLöí¿bãí\rPwg³#dßk;ÉúöEO\"\0Šd PzšYkpŸlVY>[»Mİö5=tÓ#lÔp7ıT3[Ø¾Å™·Q[ŸÍø e|@Z°èI@‘,JB3k\rîÍªõg³lĞ[õfÇŸiŒíŞß¥Í« ÏY”…f\"‹}X^İ\0}Î2@ ô(4“Î3gW½[^İ\0}Î2@ ô(4³–@¾«z·¼ºúœe€@éQhf-,ªŞ-¯n€>g PzšYK ßQ½[^İ\0}Î2@ ô(4388øÚkŸ9ómÕ£åÕ\rĞç,JB3¥Ré©§¾~æÌaÕ£åÕ\rĞç,JB3ãããÿ1Ó™ä[ªë;‹_)zP$M’@hfïŞ½ÓÓ*¼“V[«ùÌÔÔTÑ“€\"iò”B3KKK##ïz­òà™ä1Õs51qÅÜÜ\\Ñ“€\"iò”B{ÎºæLò¨ê­ú·Ù¿™œ/zú\0P0M’@h¡R©Œ½÷ÀM’GT¯Ôòò]##ï*—ï)zú\0P0M’@hmqqqtô’ÅÅ¹$9¤Â¯4~¤¡qaá‹EO\0Š§É#P›:pà@\ZBöîı£$yX…\\ssŸ)-,üSÑS€ hò”B•Jezzjlì=33¹¼|G’TáT¹üß³³=9¹{bb,½]ôd š<%İÂÂÂÔÔïÿô\0!\Zº`ròÊ4„=A\0‹&@\rH ô+.€¸iò”Bß2ùˆ›u@iÂè[&?\0q³Î(M}Ëä nÖ9¥	£o™ü\0ÄÍ:G 4aô-“€¸Yç”&Œ¾eò7ëÒ„Ñ·L~\0âf#Pš0ú–É@Ü¬sJFß2ùˆ›u@iÂè[&?\0q³Î(M}Ëä nÖ9¥	£o™ü\0ÄÍ:G 4aô-“€¸Yç”&Œ¾eò7ëÒ„Ñ·L~\0âf#Pš0úVG&¿W\0Á²D(ı}k}òdP·Wö @Ö$¥a¢oUH–Í6½ÓK	€ĞX™”¶‰¾µRw¿×\0²8(}«6´xKUõ5’åıZŞ‹@8¬FJ«DßÚæ÷@\0 p0¥»¢om9øÖ\0=Á²D ôLô­MßdU»YãÍ\0°,(=}«14~¶ñşÄ÷@\0è–%¥g¢om\'´8 \0Â²D ôLô-ß n–%¥g¢omùç@ê\0\0a²J(-}kß©Û¥q¯\rï€BX”n‰¾Õ\'ZlÖl—\ro{Y«Ò*Ñ·6M Í¾I²éO¢{Y«Ò*Ñ·²|¤EØğ“è\0Î²D ôLô-“€¸Yç”&Œ¾eò7ëÒ„Ñ·L~\0âf#Pš0ú–É@Ü¬sJF_™Mçüàààèèhzcxx8ı÷üóÏ_\\\\,úÔ\0 Ã4yJ¡¯ÜvÛm¿Àj×®]sssEŸ\Z\0t˜&@I ô•J¥rŞyçÕÆK/½txx¸\\.}j\0Ğaš<%Ğo®¿şúsÎ9§š@®½öÚééé¢O\n\0:O“G $úĞE]´?®ºêªR©T©TŠ>#\0è<M’@èCwß}÷¹ç›Nşññq?@¬4yJ¡?]qÅë	¤è€nÑä(	„ş´¼¼œN~¿„€ˆiò”Bß2ùˆ›u@iÂè•JennnÏ=co\ZOï™™™Y^^.ú “4yJ¡¤Á#M‹°ÎèèèM7İäWcM\ZÔo±………;wnš=j•J%¿ €H *m¶–––Š>è¼4ZOMM5~—ãŸø³ıûo½ó®oTë“ŸüÔîİ»ë¶œ˜˜ğ‡ÒèiJ²C‡}ĞaËËËußúøøÇÿøÉ#GN­¬6«^<ö7Ş8<<\\ûÍ¯\0z—B ÆÆÆŠ>è¤¥¥¥4<TƒÄøøxëìQ—C>ùÉOU÷<pà@Ñ€­@ÔÔÔÔÌÌLÑgS©Tj¿ûñ™nÈ˜=jë–[ş_š=ªß	ñk²\0èEJãG\ZBŠ>è˜ÉÉÉjüØ¿ÿÖ-Äõzğ¡ƒCCCëÇ+zX\0Ğ6	„@-..ŒŒ}ĞsssÛüîGmİşÕ¯U¶oß¾¢\0í‘@—F\'\Zéd®şìÇ6ãÇzU&dxxØï­ ·H „kß¾}×]w]ÑgÛ5;;[ıññ£Ï<Û‘òÊñÕßåe@o‘@W¥Rñ³¶D`ll¬ú‹w;?ÖëK7ß¼~Ø¡¡¡¢‡\0m@ÚÂÂ‚Ÿµ¥§•ËåêÏltê Õºøâ7~·¯_]\r@‘@İ={¼É„ÀÍÎÎ.--mø©™™™êï­êlüHë#ùèúÁ§§§ó1\0lBH»«ñññr¹\\ô‰ÀüñõpÁìß¿¿î³×\\sM§~Vcİy×7Ö¾sçÎBÆ\0[ ĞæççK¥Ò={üX¡©T*o{ÛÛÖ“À¹çûîw¿»öû!ix^ÿÔí_ıZÇÈ“GTÿ:aq\0\0´G¡g”Ëå4¤VÚÒ¥7¼ñpT-Õºw¼ãúĞ‡ÖInõ÷ğ>øĞÁ\'´ª_´èÇ\0\0²²hÑcÒ®n~~>M Õß/!«†“\'éF©¿è—&\0deÑØ®/¼°\Z9&Ö¤	yqq1ıÔÈÈÈúıß:|¸	dppP ·X´\0¶¥úûvÓ°ñá8ıwvv¶úÙê7ëî¼ë/¼xlıàş$\0=DØ–§Ÿ~zppp||¼T*MOO×ıÒ¶©©©õğ7ŞØñò­Ã‡×>::ZÔğ ]ÀvÍÍÍÍÌÌlø\'Aöîİ»®¾ú;@>sÃ\rëŸœœÌ}Ğ\0°E@-..Vß(õÊñM —_~ùúÁÓüSô@ +	 »J¥ÒzNØ¿ÿÖÆêIù{\0ô	 »¦§§×sÂ;:ømß{ßûª¿}«è!@$€î*—ËÕ¿Úñ™nèHü¸çŞûªß\09tèPÑC€6H \0]·oß¾õ´088¸ı_Ëûä‘#ÕHsÍ5×=8\0h‡;wVÿJúvş>ú+ÇOìØ±£z¨ååå¢G\0í‘@\0ò°´´444TM>tpñãè3ÏVãÇàààÂÂBÑÃ€¶I \09ICõ‡7ÒüĞîß(¼çŞûªo¾JíÛ·¯èÀVH \0ù™››«~\'dı·cİşÕ¯eùÖÇ®ºj †ø@ï’@\0rµ¸¸822R\'ÒòÉO~ê[‡7¸ñÆİ»w×nœo¾ §I \0y+—Ë{öìØÈe—]ÖìS“““~ô€^\'\0#ÍSSS&Fccc(ú” $€\"U*•ÙÙÙ4ŠŒÖ¥R©411qÓM7ù¾\01‘@\0\0€üH \0\0@~$\0\0 ?\0\0	\0\0ÈÏÿ^;ƒÑÜF°\0\0\0\0IEND®B`‚',0);

/*Table structure for table `act_ge_property` */

DROP TABLE IF EXISTS `act_ge_property`;

CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ge_property` */

insert  into `act_ge_property`(`NAME_`,`VALUE_`,`REV_`) values ('next.dbid','10001',5),('schema.history','create(5.22.0.0)',1),('schema.version','5.22.0.0',1);

/*Table structure for table `act_hi_actinst` */

DROP TABLE IF EXISTS `act_hi_actinst`;

CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_actinst` */

insert  into `act_hi_actinst`(`ID_`,`PROC_DEF_ID_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`ACT_ID_`,`TASK_ID_`,`CALL_PROC_INST_ID_`,`ACT_NAME_`,`ACT_TYPE_`,`ASSIGNEE_`,`START_TIME_`,`END_TIME_`,`DURATION_`,`TENANT_ID_`) values ('13','Leavebill:1:4','5','5','usertask2','14',NULL,'å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘','userTask','èµµå…­','2019-10-17 07:39:08.878','2019-10-17 07:43:47.273',278395,''),('17','Leavebill:1:4','5','5','usertask3','18',NULL,'å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘','userTask','ç‹äº”','2019-10-17 07:43:47.273','2019-10-17 07:44:26.656',39383,''),('21','Leavebill:1:4','5','5','endevent1',NULL,NULL,'End','endEvent',NULL,'2019-10-17 07:44:26.656','2019-10-17 07:44:26.656',0,''),('23','Leavebill:1:4','22','22','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 07:46:04.535','2019-10-17 07:46:04.535',0,''),('25','Leavebill:1:4','22','22','usertask1','26',NULL,'æäº¤ç”³è¯·','userTask','å­™ä¸ƒ','2019-10-17 07:46:04.535','2019-10-17 07:46:29.028',24493,''),('2503','Leavebill:1:4','57','57','usertask2','2504',NULL,'å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘','userTask','èµµå…­','2019-10-17 08:31:01.998','2019-10-17 12:51:38.271',15636273,''),('30','Leavebill:1:4','22','22','endevent1',NULL,NULL,'End','endEvent',NULL,'2019-10-17 07:46:29.028','2019-10-17 07:46:29.028',0,''),('32','Leavebill:1:4','31','31','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 07:47:21.969','2019-10-17 07:47:21.970',1,''),('34','Leavebill:1:4','31','31','usertask1','35',NULL,'æäº¤ç”³è¯·','userTask','å­™ä¸ƒ','2019-10-17 07:47:21.970','2019-10-17 07:47:39.923',17953,''),('39','Leavebill:1:4','31','31','usertask2','40',NULL,'å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘','userTask','èµµå…­','2019-10-17 07:47:39.923','2019-10-17 07:48:13.332',33409,''),('43','Leavebill:1:4','31','31','usertask3','44',NULL,'å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘','userTask','ç‹äº”','2019-10-17 07:48:13.332','2019-10-17 07:49:11.736',58404,''),('47','Leavebill:1:4','31','31','usertask1','48',NULL,'æäº¤ç”³è¯·','userTask','å­™ä¸ƒ','2019-10-17 07:49:11.736','2019-10-17 07:50:03.324',51588,''),('50','Leavebill:1:4','31','31','usertask2','51',NULL,'å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘','userTask','èµµå…­','2019-10-17 07:50:03.325','2019-10-17 07:50:29.275',25950,''),('5002','Leavebill:1:4','5001','5001','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 10:03:40.115','2019-10-17 10:03:40.129',14,''),('5004','Leavebill:1:4','5001','5001','usertask1','5005',NULL,'æäº¤ç”³è¯·','userTask','å­™ä¸ƒ','2019-10-17 10:03:40.131',NULL,NULL,''),('53','Leavebill:1:4','31','31','usertask3','54',NULL,'å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘','userTask','ç‹äº”','2019-10-17 07:50:29.275','2019-10-17 07:51:11.007',41732,''),('56','Leavebill:1:4','31','31','endevent1',NULL,NULL,'End','endEvent',NULL,'2019-10-17 07:51:11.007','2019-10-17 07:51:11.007',0,''),('59','Leavebill:1:4','57','57','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 08:13:29.338','2019-10-17 08:13:29.338',0,''),('6','Leavebill:1:4','5','5','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 07:38:34.604','2019-10-17 07:38:34.606',2,''),('61','Leavebill:1:4','57','57','usertask1','62',NULL,'æäº¤ç”³è¯·','userTask','å­™ä¸ƒ','2019-10-17 08:13:29.338','2019-10-17 08:31:01.998',1052660,''),('7502','Leavebill:1:4','57','57','usertask3','7503',NULL,'å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘','userTask','ç‹äº”','2019-10-17 12:51:38.271',NULL,NULL,''),('8','Leavebill:1:4','5','5','usertask1','9',NULL,'æäº¤ç”³è¯·','userTask','å­™ä¸ƒ','2019-10-17 07:38:34.606','2019-10-17 07:39:08.878',34272,'');

/*Table structure for table `act_hi_attachment` */

DROP TABLE IF EXISTS `act_hi_attachment`;

CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_attachment` */

/*Table structure for table `act_hi_comment` */

DROP TABLE IF EXISTS `act_hi_comment`;

CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_comment` */

insert  into `act_hi_comment`(`ID_`,`TYPE_`,`TIME_`,`USER_ID_`,`TASK_ID_`,`PROC_INST_ID_`,`ACTION_`,`MESSAGE_`,`FULL_MSG_`) values ('11','comment','2019-10-17 07:39:08.867','å­™ä¸ƒ','9','5','AddComment','[æäº¤]è¯·é¢†å¯¼åŒæ„','[æäº¤]è¯·é¢†å¯¼åŒæ„'),('16','comment','2019-10-17 07:43:47.263','èµµå…­','14','5','AddComment','[åŒæ„]åŒæ„','[åŒæ„]åŒæ„'),('20','comment','2019-10-17 07:44:26.645','ç‹äº”','18','5','AddComment','[åŒæ„]ä¹æ„','[åŒæ„]ä¹æ„'),('2501','comment','2019-10-17 08:31:01.983','å­™ä¸ƒ','62','57','AddComment','[æäº¤]å»åˆ·','[æäº¤]å»åˆ·'),('28','comment','2019-10-17 07:46:29.017','å­™ä¸ƒ','26','22','AddComment','[æ”¾å¼ƒ]ç®—äº†æ•²ä»£ç å¥½äº†','[æ”¾å¼ƒ]ç®—äº†æ•²ä»£ç å¥½äº†'),('37','comment','2019-10-17 07:47:39.915','å­™ä¸ƒ','35','31','AddComment','[æäº¤]è¯·é¢†å¯¼æ‰¹å‡†','[æäº¤]è¯·é¢†å¯¼æ‰¹å‡†'),('42','comment','2019-10-17 07:48:13.322','èµµå…­','40','31','AddComment','[åŒæ„]å¯ä»¥','[åŒæ„]å¯ä»¥'),('46','comment','2019-10-17 07:49:11.725','ç‹äº”','44','31','AddComment','[é©³å›]ä»£ç æ•²å®Œæ²¡,æ•²ä»£ç å»','[é©³å›]ä»£ç æ•²å®Œæ²¡,æ•²ä»£ç å»'),('49','comment','2019-10-17 07:50:03.315','å­™ä¸ƒ','48','31','AddComment','[æäº¤]æ•²å®Œäº†ï¼Œå•èº«20å¹´','[æäº¤]æ•²å®Œäº†ï¼Œå•èº«20å¹´'),('52','comment','2019-10-17 07:50:29.266','èµµå…­','51','31','AddComment','[åŒæ„]åŒæ„','[åŒæ„]åŒæ„'),('55','comment','2019-10-17 07:51:10.992','ç‹äº”','54','31','AddComment','[åŒæ„]å»å§','[åŒæ„]å»å§'),('7501','comment','2019-10-17 12:51:38.221','èµµå…­','2504','57','AddComment','[åŒæ„]å¥½çš„','[åŒæ„]å¥½çš„');

/*Table structure for table `act_hi_detail` */

DROP TABLE IF EXISTS `act_hi_detail`;

CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_detail` */

/*Table structure for table `act_hi_identitylink` */

DROP TABLE IF EXISTS `act_hi_identitylink`;

CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_identitylink` */

insert  into `act_hi_identitylink`(`ID_`,`GROUP_ID_`,`TYPE_`,`USER_ID_`,`TASK_ID_`,`PROC_INST_ID_`) values ('10',NULL,'participant','å­™ä¸ƒ',NULL,'5'),('15',NULL,'participant','èµµå…­',NULL,'5'),('19',NULL,'participant','ç‹äº”',NULL,'5'),('27',NULL,'participant','å­™ä¸ƒ',NULL,'22'),('36',NULL,'participant','å­™ä¸ƒ',NULL,'31'),('41',NULL,'participant','èµµå…­',NULL,'31'),('45',NULL,'participant','ç‹äº”',NULL,'31'),('5006',NULL,'participant','å­™ä¸ƒ',NULL,'5001'),('58',NULL,'starter','èµµå…­',NULL,'57'),('63',NULL,'participant','å­™ä¸ƒ',NULL,'57'),('7504',NULL,'participant','ç‹äº”',NULL,'57');

/*Table structure for table `act_hi_procinst` */

DROP TABLE IF EXISTS `act_hi_procinst`;

CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_procinst` */

insert  into `act_hi_procinst`(`ID_`,`PROC_INST_ID_`,`BUSINESS_KEY_`,`PROC_DEF_ID_`,`START_TIME_`,`END_TIME_`,`DURATION_`,`START_USER_ID_`,`START_ACT_ID_`,`END_ACT_ID_`,`SUPER_PROCESS_INSTANCE_ID_`,`DELETE_REASON_`,`TENANT_ID_`,`NAME_`) values ('22','22','Leavebill:13','Leavebill:1:4','2019-10-17 07:46:04.535','2019-10-17 07:46:29.029',24494,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('31','31','Leavebill:14','Leavebill:1:4','2019-10-17 07:47:21.969','2019-10-17 07:51:11.008',229039,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('5','5','Leavebill:12','Leavebill:1:4','2019-10-17 07:38:34.604','2019-10-17 07:44:26.657',352053,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('5001','5001','Leavebill:16','Leavebill:1:4','2019-10-17 10:03:40.113',NULL,NULL,NULL,'startevent1',NULL,NULL,NULL,'',NULL),('57','57','Leavebill:15','Leavebill:1:4','2019-10-17 08:13:29.338',NULL,NULL,'èµµå…­','startevent1',NULL,NULL,NULL,'',NULL);

/*Table structure for table `act_hi_taskinst` */

DROP TABLE IF EXISTS `act_hi_taskinst`;

CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_taskinst` */

insert  into `act_hi_taskinst`(`ID_`,`PROC_DEF_ID_`,`TASK_DEF_KEY_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`NAME_`,`PARENT_TASK_ID_`,`DESCRIPTION_`,`OWNER_`,`ASSIGNEE_`,`START_TIME_`,`CLAIM_TIME_`,`END_TIME_`,`DURATION_`,`DELETE_REASON_`,`PRIORITY_`,`DUE_DATE_`,`FORM_KEY_`,`CATEGORY_`,`TENANT_ID_`) values ('14','Leavebill:1:4','usertask2','5','5','å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,NULL,'èµµå…­','2019-10-17 07:39:08.878',NULL,'2019-10-17 07:43:47.271',278393,'completed',50,NULL,NULL,NULL,''),('18','Leavebill:1:4','usertask3','5','5','å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,NULL,'ç‹äº”','2019-10-17 07:43:47.273',NULL,'2019-10-17 07:44:26.654',39381,'completed',50,NULL,NULL,NULL,''),('2504','Leavebill:1:4','usertask2','57','57','å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,NULL,'èµµå…­','2019-10-17 08:31:01.998',NULL,'2019-10-17 12:51:38.251',15636253,'completed',50,NULL,NULL,NULL,''),('26','Leavebill:1:4','usertask1','22','22','æäº¤ç”³è¯·',NULL,NULL,NULL,'å­™ä¸ƒ','2019-10-17 07:46:04.536',NULL,'2019-10-17 07:46:29.025',24489,'completed',50,NULL,NULL,NULL,''),('35','Leavebill:1:4','usertask1','31','31','æäº¤ç”³è¯·',NULL,NULL,NULL,'å­™ä¸ƒ','2019-10-17 07:47:21.971',NULL,'2019-10-17 07:47:39.921',17950,'completed',50,NULL,NULL,NULL,''),('40','Leavebill:1:4','usertask2','31','31','å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,NULL,'èµµå…­','2019-10-17 07:47:39.923',NULL,'2019-10-17 07:48:13.330',33407,'completed',50,NULL,NULL,NULL,''),('44','Leavebill:1:4','usertask3','31','31','å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,NULL,'ç‹äº”','2019-10-17 07:48:13.332',NULL,'2019-10-17 07:49:11.733',58401,'completed',50,NULL,NULL,NULL,''),('48','Leavebill:1:4','usertask1','31','31','æäº¤ç”³è¯·',NULL,NULL,NULL,'å­™ä¸ƒ','2019-10-17 07:49:11.736',NULL,'2019-10-17 07:50:03.323',51587,'completed',50,NULL,NULL,NULL,''),('5005','Leavebill:1:4','usertask1','5001','5001','æäº¤ç”³è¯·',NULL,NULL,NULL,'å­™ä¸ƒ','2019-10-17 10:03:40.135',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,''),('51','Leavebill:1:4','usertask2','31','31','å®¡æ‰¹ã€ä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,NULL,'èµµå…­','2019-10-17 07:50:03.325',NULL,'2019-10-17 07:50:29.274',25949,'completed',50,NULL,NULL,NULL,''),('54','Leavebill:1:4','usertask3','31','31','å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,NULL,'ç‹äº”','2019-10-17 07:50:29.275',NULL,'2019-10-17 07:51:11.004',41729,'completed',50,NULL,NULL,NULL,''),('62','Leavebill:1:4','usertask1','57','57','æäº¤ç”³è¯·',NULL,NULL,NULL,'å­™ä¸ƒ','2019-10-17 08:13:29.340',NULL,'2019-10-17 08:31:01.995',1052655,'completed',50,NULL,NULL,NULL,''),('7503','Leavebill:1:4','usertask3','57','57','å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,NULL,'ç‹äº”','2019-10-17 12:51:38.271',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,''),('9','Leavebill:1:4','usertask1','5','5','æäº¤ç”³è¯·',NULL,NULL,NULL,'å­™ä¸ƒ','2019-10-17 07:38:34.607',NULL,'2019-10-17 07:39:08.874',34267,'completed',50,NULL,NULL,NULL,'');

/*Table structure for table `act_hi_varinst` */

DROP TABLE IF EXISTS `act_hi_varinst`;

CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_varinst` */

insert  into `act_hi_varinst`(`ID_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`TASK_ID_`,`NAME_`,`VAR_TYPE_`,`REV_`,`BYTEARRAY_ID_`,`DOUBLE_`,`LONG_`,`TEXT_`,`TEXT2_`,`CREATE_TIME_`,`LAST_UPDATED_TIME_`) values ('12','5','5',NULL,'outcome','string',2,NULL,NULL,NULL,'åŒæ„',NULL,'2019-10-17 07:39:08.871','2019-10-17 07:44:26.658'),('24','22','22',NULL,'username','string',1,NULL,NULL,NULL,'å­™ä¸ƒ',NULL,'2019-10-17 07:46:04.535','2019-10-17 07:46:29.030'),('2502','57','57',NULL,'outcome','string',1,NULL,NULL,NULL,'åŒæ„',NULL,'2019-10-17 08:31:01.992','2019-10-17 12:51:38.241'),('29','22','22',NULL,'outcome','string',0,NULL,NULL,NULL,'æ”¾å¼ƒ',NULL,'2019-10-17 07:46:29.021','2019-10-17 07:46:29.030'),('33','31','31',NULL,'username','string',1,NULL,NULL,NULL,'å­™ä¸ƒ',NULL,'2019-10-17 07:47:21.969','2019-10-17 07:51:11.009'),('38','31','31',NULL,'outcome','string',5,NULL,NULL,NULL,'åŒæ„',NULL,'2019-10-17 07:47:39.918','2019-10-17 07:51:11.009'),('5003','5001','5001',NULL,'username','string',0,NULL,NULL,NULL,'å­™ä¸ƒ',NULL,'2019-10-17 10:03:40.116','2019-10-17 10:03:40.116'),('60','57','57',NULL,'username','string',0,NULL,NULL,NULL,'å­™ä¸ƒ',NULL,'2019-10-17 08:13:29.338','2019-10-17 08:13:29.338'),('7','5','5',NULL,'username','string',1,NULL,NULL,NULL,'å­™ä¸ƒ',NULL,'2019-10-17 07:38:34.604','2019-10-17 07:44:26.658');

/*Table structure for table `act_procdef_info` */

DROP TABLE IF EXISTS `act_procdef_info`;

CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_procdef_info` */

/*Table structure for table `act_re_deployment` */

DROP TABLE IF EXISTS `act_re_deployment`;

CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_deployment` */

insert  into `act_re_deployment`(`ID_`,`NAME_`,`CATEGORY_`,`TENANT_ID_`,`DEPLOY_TIME_`) values ('1','è¯·å‡å•001',NULL,'','2019-10-17 07:38:23.490');

/*Table structure for table `act_re_model` */

DROP TABLE IF EXISTS `act_re_model`;

CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_model` */

/*Table structure for table `act_re_procdef` */

DROP TABLE IF EXISTS `act_re_procdef`;

CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_procdef` */

insert  into `act_re_procdef`(`ID_`,`REV_`,`CATEGORY_`,`NAME_`,`KEY_`,`VERSION_`,`DEPLOYMENT_ID_`,`RESOURCE_NAME_`,`DGRM_RESOURCE_NAME_`,`DESCRIPTION_`,`HAS_START_FORM_KEY_`,`HAS_GRAPHICAL_NOTATION_`,`SUSPENSION_STATE_`,`TENANT_ID_`) values ('Leavebill:1:4',1,'http://www.activiti.org/test','Leavebill','Leavebill',1,'1','leaveBill.bpmn','leaveBill.png',NULL,0,1,1,'');

/*Table structure for table `act_ru_event_subscr` */

DROP TABLE IF EXISTS `act_ru_event_subscr`;

CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_event_subscr` */

/*Table structure for table `act_ru_execution` */

DROP TABLE IF EXISTS `act_ru_execution`;

CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_execution` */

insert  into `act_ru_execution`(`ID_`,`REV_`,`PROC_INST_ID_`,`BUSINESS_KEY_`,`PARENT_ID_`,`PROC_DEF_ID_`,`SUPER_EXEC_`,`ACT_ID_`,`IS_ACTIVE_`,`IS_CONCURRENT_`,`IS_SCOPE_`,`IS_EVENT_SCOPE_`,`SUSPENSION_STATE_`,`CACHED_ENT_STATE_`,`TENANT_ID_`,`NAME_`,`LOCK_TIME_`) values ('5001',1,'5001','Leavebill:16',NULL,'Leavebill:1:4',NULL,'usertask1',1,0,1,0,1,2,'',NULL,NULL),('57',3,'57','Leavebill:15',NULL,'Leavebill:1:4',NULL,'usertask3',1,0,1,0,1,2,'',NULL,NULL);

/*Table structure for table `act_ru_identitylink` */

DROP TABLE IF EXISTS `act_ru_identitylink`;

CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_identitylink` */

insert  into `act_ru_identitylink`(`ID_`,`REV_`,`GROUP_ID_`,`TYPE_`,`USER_ID_`,`TASK_ID_`,`PROC_INST_ID_`,`PROC_DEF_ID_`) values ('5006',1,NULL,'participant','å­™ä¸ƒ',NULL,'5001',NULL),('58',1,NULL,'starter','èµµå…­',NULL,'57',NULL),('63',1,NULL,'participant','å­™ä¸ƒ',NULL,'57',NULL),('7504',1,NULL,'participant','ç‹äº”',NULL,'57',NULL);

/*Table structure for table `act_ru_job` */

DROP TABLE IF EXISTS `act_ru_job`;

CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_job` */

/*Table structure for table `act_ru_task` */

DROP TABLE IF EXISTS `act_ru_task`;

CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_task` */

insert  into `act_ru_task`(`ID_`,`REV_`,`EXECUTION_ID_`,`PROC_INST_ID_`,`PROC_DEF_ID_`,`NAME_`,`PARENT_TASK_ID_`,`DESCRIPTION_`,`TASK_DEF_KEY_`,`OWNER_`,`ASSIGNEE_`,`DELEGATION_`,`PRIORITY_`,`CREATE_TIME_`,`DUE_DATE_`,`CATEGORY_`,`SUSPENSION_STATE_`,`TENANT_ID_`,`FORM_KEY_`) values ('5005',1,'5001','5001','Leavebill:1:4','æäº¤ç”³è¯·',NULL,NULL,'usertask1',NULL,'å­™ä¸ƒ',NULL,50,'2019-10-17 10:03:40.131',NULL,NULL,1,'',NULL),('7503',1,'57','57','Leavebill:1:4','å®¡æ‰¹ã€ä¸Šä¸Šçº§é¢†å¯¼ã€‘',NULL,NULL,'usertask3',NULL,'ç‹äº”',NULL,50,'2019-10-17 12:51:38.271',NULL,NULL,1,'',NULL);

/*Table structure for table `act_ru_variable` */

DROP TABLE IF EXISTS `act_ru_variable`;

CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_variable` */

insert  into `act_ru_variable`(`ID_`,`REV_`,`TYPE_`,`NAME_`,`EXECUTION_ID_`,`PROC_INST_ID_`,`TASK_ID_`,`BYTEARRAY_ID_`,`DOUBLE_`,`LONG_`,`TEXT_`,`TEXT2_`) values ('2502',2,'string','outcome','57','57',NULL,NULL,NULL,NULL,'åŒæ„',NULL),('5003',1,'string','username','5001','5001',NULL,NULL,NULL,NULL,'å­™ä¸ƒ',NULL),('60',1,'string','username','57','57',NULL,NULL,NULL,NULL,'å­™ä¸ƒ',NULL);

/*Table structure for table `bus_customer` */

DROP TABLE IF EXISTS `bus_customer`;

CREATE TABLE `bus_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customername` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `connectionperson` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `bank` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `bus_customer` */

insert  into `bus_customer`(`id`,`customername`,`zip`,`address`,`telephone`,`connectionperson`,`phone`,`bank`,`account`,`email`,`fax`,`available`) values (1,'å°å¼ è¶…å¸‚','111','æ­¦æ±‰','027-9123131','å¼ å¤§æ˜','13812312312321312','ä¸­å›½é“¶è¡Œ','654431331343413','213123@sina.com','430000',1),(2,'å°æ˜è¶…å¸‚','222','æ·±åœ³','0755-9123131','å¼ å°æ˜','13812312312321312','ä¸­å›½é“¶è¡Œ','654431331343413','213123@sina.com','430000',1),(3,'å¿«ä¸ƒè¶…å¸‚','430000','æ­¦æ±‰','027-11011011','é›·ç”Ÿ','13434134131','æ‹›å•†é“¶è¡Œ','6543123341334133','6666@66.com','545341',1),(4,'è‹å®å°åº—','232','å¹¿å·','020-4324','å­Ÿé','2312312','ä¸­å›½é“¶è¡Œ','241243432423','112@qq.com','32sdff',1);

/*Table structure for table `bus_goods` */

DROP TABLE IF EXISTS `bus_goods`;

CREATE TABLE `bus_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodsname` varchar(255) DEFAULT NULL,
  `produceplace` varchar(255) DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `goodspackage` varchar(255) DEFAULT NULL,
  `productcode` varchar(255) DEFAULT NULL,
  `promitcode` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `dangernum` int(11) DEFAULT NULL,
  `goodsimg` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  `providerid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_sq0btr2v2lq8gt8b4gb8tlk0i` (`providerid`) USING BTREE,
  CONSTRAINT `bus_goods_ibfk_1` FOREIGN KEY (`providerid`) REFERENCES `bus_provider` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `bus_goods` */

insert  into `bus_goods`(`id`,`goodsname`,`produceplace`,`size`,`goodspackage`,`productcode`,`promitcode`,`description`,`price`,`number`,`dangernum`,`goodsimg`,`available`,`providerid`) values (1,'å¨ƒå“ˆå“ˆ','æ­¦æ±‰','120ML','ç“¶','PH12345','PZ1234','å°å­©å­éƒ½çˆ±çš„',2,1000,10,'img/å“‡å“ˆå“ˆ.jpg',1,3),(2,'æ—ºæ—ºé›ªé¥¼[å°åŒ…]','ä»™æ¡ƒ','åŒ…','è¢‹','PH12312312','PZ12312','å¥½åƒä¸ä¸Šç«',4,1000,10,'img/æ—ºæ—ºé›ªé¥¼.jpg',1,1),(3,'æ—ºæ—ºå¤§ç¤¼åŒ…','ä»™æ¡ƒ','ç›’','ç›’','11','11','111',28,980,100,'img/æ—ºæ—ºå¤§ç¤¼åŒ….jpg',1,1),(4,'å¨ƒå“ˆå“ˆ','æ­¦æ±‰','200ML','ç“¶','11','111','12321',3,980,10,'img/å“‡å“ˆå“ˆ.jpg',1,3),(5,'å¨ƒå“ˆå“ˆ','æ­¦æ±‰','300ML','ç“¶','1234','12321','22221111',3,1000,100,'img/å“‡å“ˆå“ˆ.jpg',1,3),(15,'æ—ºæ—ºè„†å†°å†°','æ­¦æ±‰','120ML','è¢‹','PH12345','PZ1234','å°å­©å­éƒ½çˆ±çš„',1,1050,100,'2019-10-11/201910112149380119466.jpg',1,1),(16,'æ—ºå­ç‰›å¥¶','æ­¦æ±‰','120ML','ç“¶','1234','12321','å°å­©å­éƒ½çˆ±çš„',3,970,100,'2019-10-11/201910111149295438339.jpg',1,1),(17,'æ—ºæ—ºä»™è´','æ­¦æ±‰','520g','è¢‹','1234','PZ1234','å°å­©å­éƒ½çˆ±çš„',20,1000,100,'2019-10-11/201910111149418709450.jpg',1,1),(18,'æ—ºå­å°é¦’å¤´','æ­¦æ±‰','500g','è¢‹','PH12345','12321','å°å­©å­éƒ½çˆ±çš„',20,1000,100,'2019-10-11/201910111150474971489.jpg',1,1),(19,'è¾¾åˆ©å›­å…«å®ç²¥','æ­¦æ±‰','300ML','ç“¶','PH12345','12321','å°å­©å­éƒ½çˆ±çš„',4.5,970,100,'2019-10-11/201910111615581974825.jpg',1,2),(20,'è¾¾åˆ©å›­æ´¾','æ­¦æ±‰','500g','è¢‹','PH12345','PZ1234','å°å­©å­éƒ½çˆ±çš„',15,1000,100,'2019-10-11/201910111616422425764.jpg',1,2);

/*Table structure for table `bus_inport` */

DROP TABLE IF EXISTS `bus_inport`;

CREATE TABLE `bus_inport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paytype` varchar(255) DEFAULT NULL,
  `inporttime` datetime DEFAULT NULL,
  `operateperson` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `inportprice` double DEFAULT NULL,
  `providerid` int(11) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_1o4bujsyd2kl4iqw48fie224v` (`providerid`) USING BTREE,
  KEY `FK_ho29poeu4o2dxu4rg1ammeaql` (`goodsid`) USING BTREE,
  CONSTRAINT `bus_inport_ibfk_1` FOREIGN KEY (`providerid`) REFERENCES `bus_provider` (`id`),
  CONSTRAINT `bus_inport_ibfk_2` FOREIGN KEY (`goodsid`) REFERENCES `bus_goods` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `bus_inport` */

insert  into `bus_inport`(`id`,`paytype`,`inporttime`,`operateperson`,`number`,`remark`,`inportprice`,`providerid`,`goodsid`) values (1,'å¾®ä¿¡','2018-05-07 00:00:00','å¼ ä¸‰',100,'å¤‡æ³¨',3.5,3,1),(2,'æ”¯ä»˜å®','2018-05-07 00:00:00','å¼ ä¸‰',1000,'æ— ',2.5,3,1),(3,'é“¶è”','2018-05-07 00:00:00','å¼ ä¸‰',100,'1231',111,3,3),(4,'é“¶è”','2018-05-07 00:00:00','å¼ ä¸‰',1000,'æ— ',2,3,1),(5,'é“¶è”','2018-05-07 00:00:00','å¼ ä¸‰',100,'æ— ',1,3,1),(6,'é“¶è”','2018-05-07 00:00:00','å¼ ä¸‰',100,'1231',2.5,1,2),(8,'æ”¯ä»˜å®','2018-05-07 00:00:00','å¼ ä¸‰',100,'',1,3,1),(10,'æ”¯ä»˜å®','2018-08-07 17:17:57','è¶…çº§ç®¡ç†å‘˜',100,'sadfasfdsa',1.5,3,1),(11,'æ”¯ä»˜å®','2018-09-17 16:12:25','è¶…çº§ç®¡ç†å‘˜',21,'21',21,1,3),(12,'å¾®ä¿¡','2018-12-25 16:48:24','è¶…çº§ç®¡ç†å‘˜',100,'123213213',12321321,3,1),(18,'æ”¯ä»˜å®','2019-10-11 11:14:40','é›·å†›',100,'æ— ',100,1,15);

/*Table structure for table `bus_outport` */

DROP TABLE IF EXISTS `bus_outport`;

CREATE TABLE `bus_outport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `providerid` int(11) DEFAULT NULL,
  `paytype` varchar(255) DEFAULT NULL,
  `outputtime` datetime DEFAULT NULL,
  `operateperson` varchar(255) DEFAULT NULL,
  `outportprice` double(10,2) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `bus_outport` */

insert  into `bus_outport`(`id`,`providerid`,`paytype`,`outputtime`,`operateperson`,`outportprice`,`number`,`remark`,`goodsid`) values (1,3,'å¾®ä¿¡','2019-08-16 08:19:50','è¶…çº§ç®¡ç†å‘˜',12321321.00,1,'',1),(2,3,'å¾®ä¿¡','2019-08-16 08:26:54','è¶…çº§ç®¡ç†å‘˜',12321321.00,11,'11',1),(11,1,'æ”¯ä»˜å®','2019-10-11 11:42:53','é›·å†›',100.00,50,'',15);

/*Table structure for table `bus_provider` */

DROP TABLE IF EXISTS `bus_provider`;

CREATE TABLE `bus_provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `providername` varchar(255) DEFAULT NULL,
  `zip` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `connectionperson` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `bank` varchar(255) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `bus_provider` */

insert  into `bus_provider`(`id`,`providername`,`zip`,`address`,`telephone`,`connectionperson`,`phone`,`bank`,`account`,`email`,`fax`,`available`) values (1,'æ—ºæ—ºé£Ÿå“','434000','ä»™æ¡ƒ','0728-4124312','å°æ˜','13413441141','ä¸­å›½å†œä¸šé“¶è¡Œ','654124345131','12312321@sina.com','5123123',1),(2,'è¾¾åˆ©å›­é£Ÿå“','430000','æ±‰å·','0728-4124312','å¤§æ˜','13413441141','ä¸­å›½å†œä¸šé“¶è¡Œ','654124345131','12312321@sina.com','5123123',1),(3,'å¨ƒå“ˆå“ˆé›†å›¢','513131','æ­å·','21312','å°æ™¨','12312','å»ºè®¾é“¶è¡Œ','512314141541','123131','312312',1);

/*Table structure for table `bus_sales` */

DROP TABLE IF EXISTS `bus_sales`;

CREATE TABLE `bus_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) DEFAULT NULL,
  `paytype` varchar(255) DEFAULT NULL,
  `salestime` datetime DEFAULT NULL,
  `operateperson` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `saleprice` decimal(10,2) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `bus_sales` */

insert  into `bus_sales`(`id`,`customerid`,`paytype`,`salestime`,`operateperson`,`number`,`remark`,`saleprice`,`goodsid`) values (1,1,'æ”¯ä»˜å®','2019-10-12 12:58:31','é›·å†›',50,'312','50.00',15),(2,2,'æ”¯ä»˜å®','2019-10-18 02:08:57','é›·å†›',30,'æ— ','100.00',16),(3,3,'æ”¯ä»˜å®','2019-10-18 02:09:14','é›·å†›',30,'ds','100.00',19),(4,4,'æ”¯ä»˜å®','2019-10-18 02:09:42','é›·å†›',20,'haha','70.00',4),(5,2,'æ”¯ä»˜å®','2019-10-18 02:11:49','é›·å†›',20,'','31.00',3);

/*Table structure for table `bus_salesback` */

DROP TABLE IF EXISTS `bus_salesback`;

CREATE TABLE `bus_salesback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerid` int(11) DEFAULT NULL,
  `paytype` varchar(255) DEFAULT NULL,
  `salesbacktime` datetime DEFAULT NULL,
  `salebackprice` double(10,2) DEFAULT NULL,
  `operateperson` varchar(255) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `bus_salesback` */

insert  into `bus_salesback`(`id`,`customerid`,`paytype`,`salesbacktime`,`salebackprice`,`operateperson`,`number`,`remark`,`goodsid`) values (1,1,'æ”¯ä»˜å®','2019-10-12 14:09:38',50.00,'é›·å†›',50,'æ— ',15);

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `open` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL COMMENT 'çŠ¶æ€ã€0ä¸å¯ç”¨1å¯ç”¨ã€‘',
  `ordernum` int(11) DEFAULT NULL COMMENT 'æ’åºç ã€ä¸ºäº†è°ƒäº‹æ˜¾ç¤ºé¡ºåºã€‘',
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_dept` */

insert  into `sys_dept`(`id`,`pid`,`title`,`open`,`remark`,`address`,`available`,`ordernum`,`createtime`) values (1,0,'æ€»ç»åŠ',1,'å¤§BOSS','æ·±åœ³',1,1,'2019-04-10 14:06:32'),(2,1,'é”€å”®éƒ¨',0,'ç¨‹åºå‘˜å±Œä¸','æ­¦æ±‰',1,2,'2019-04-10 14:06:32'),(3,1,'è¿è¥éƒ¨',0,'æ— ','æ­¦æ±‰',1,3,'2019-04-10 14:06:32'),(4,1,'ç”Ÿäº§éƒ¨',0,'æ— ','æ­¦æ±‰',1,4,'2019-04-10 14:06:32'),(5,2,'é”€å”®ä¸€éƒ¨',0,'é”€å”®ä¸€éƒ¨','æ­¦æ±‰',1,5,'2019-04-10 14:06:32'),(6,2,'é”€å”®äºŒéƒ¨',0,'é”€å”®äºŒéƒ¨','æ­¦æ±‰',1,6,'2019-04-10 14:06:32'),(7,3,'è¿è¥ä¸€éƒ¨',0,'è¿è¥ä¸€éƒ¨','æ­¦æ±‰',1,7,'2019-04-10 14:06:32'),(8,2,'é”€å”®ä¸‰éƒ¨',0,'é”€å”®ä¸‰éƒ¨','11',1,8,'2019-04-10 14:06:32'),(9,2,'é”€å”®å››éƒ¨',0,'é”€å”®å››éƒ¨','222',1,9,'2019-04-10 14:06:32'),(10,2,'é”€å”®äº”éƒ¨',0,'é”€å”®äº”éƒ¨','33',1,10,'2019-04-10 14:06:32'),(18,4,'ç”Ÿäº§ä¸€éƒ¨',0,'ç”Ÿäº§é£Ÿå“','æ­¦æ±‰',1,11,'2019-04-13 09:49:38'),(20,4,'dsadsadas',0,'dsa','dsa',1,13,'2019-10-08 05:14:51'),(21,4,'qwrr',0,'rwq','rqw',1,14,'2019-10-08 05:35:50'),(22,1,'ç”µå•†éƒ¨',0,'é›·å†›','æ­¦æ±‰',1,15,'2019-10-08 05:53:44'),(23,22,'ç”µå•†ä¸€éƒ¨',0,'2312','æ­¦æ±‰1å·',1,16,'2019-10-08 05:55:23'),(31,22,'ç”µå•†äºŒéƒ¨',0,'å°ç±³æœ‰å“','æ­¦æ±‰',1,17,'2019-10-08 06:14:46'),(33,22,'dsa',0,'dasdsadsa','dassad',1,18,'2019-10-08 07:17:16'),(34,22,'asd',0,'as','sdas',1,19,'2019-10-08 08:40:55'),(35,22,'dsa',0,'das','das',1,20,'2019-10-08 08:41:13'),(36,22,'fdf',0,'das','dsa',1,21,'2019-10-08 08:41:32');

/*Table structure for table `sys_leavebill` */

DROP TABLE IF EXISTS `sys_leavebill`;

CREATE TABLE `sys_leavebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `days` double(255,0) DEFAULT NULL,
  `leavetime` datetime DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL COMMENT '1,æ–°å»º  2ï¼Œå·²æäº¤   3ï¼Œå®¡æ‰¹ä¸­  4ï¼Œå®¡æ‰¹å®Œæˆ',
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `sys_leavebill` */

insert  into `sys_leavebill`(`id`,`title`,`content`,`days`,`leavetime`,`state`,`userid`) values (12,'ã€å­™ä¸ƒã€‘çš„è¯·å‡å•','å›å®¶è¿‡å¹´',3,'2019-10-16 16:00:00','2',5),(13,'ã€å­™ä¸ƒã€‘çš„è¯·å‡å•','å»ç©',3,'2019-10-16 16:00:00','3',5),(14,'ã€å­™ä¸ƒã€‘çš„è¯·å‡å•','å‡ºå»çœ‹çœ‹ä¸–ç•Œ',3,'2019-10-16 16:00:00','2',5),(15,'ã€å­™ä¸ƒã€‘çš„è¯·å‡å•','å»è€',3,'2019-10-17 16:00:00','1',5),(16,'ã€å­™ä¸ƒã€‘çš„è¯·å‡å•','æäº‹æƒ…',5,'2019-10-16 16:00:00','1',5);

/*Table structure for table `sys_loginfo` */

DROP TABLE IF EXISTS `sys_loginfo`;

CREATE TABLE `sys_loginfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginname` varchar(255) DEFAULT NULL,
  `loginip` varchar(255) DEFAULT NULL,
  `logintime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_loginfo` */

insert  into `sys_loginfo`(`id`,`loginname`,`loginip`,`logintime`) values (2,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-21 16:54:52'),(3,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-21 16:55:15'),(4,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-21 17:29:22'),(5,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:05:22'),(6,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:20:43'),(7,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:25:40'),(8,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:27:11'),(9,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:29:58'),(10,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:36:49'),(11,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:46:56'),(12,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:48:29'),(13,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:49:13'),(14,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:49:57'),(15,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 09:57:46'),(16,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 10:21:53'),(17,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 10:38:25'),(18,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 10:49:21'),(19,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 14:01:42'),(20,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 14:19:48'),(21,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 14:45:29'),(22,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 15:58:05'),(23,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 16:40:53'),(24,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-22 17:12:01'),(25,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 09:19:15'),(26,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 09:37:28'),(27,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 09:46:51'),(28,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 09:50:40'),(29,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 09:52:52'),(30,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 10:00:26'),(31,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 10:10:58'),(32,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 10:21:28'),(33,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 11:22:27'),(34,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 11:35:28'),(35,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 14:05:28'),(36,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 15:16:29'),(37,'æå››-ls','127.0.0.1','2018-12-24 15:16:50'),(38,'ç‹äº”-ww','127.0.0.1','2018-12-24 15:17:36'),(39,'èµµå…­-zl','127.0.0.1','2018-12-24 15:17:47'),(40,'å­™ä¸ƒ-sq','127.0.0.1','2018-12-24 15:17:58'),(41,'åˆ˜å…«-lb','127.0.0.1','2018-12-24 15:18:09'),(42,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 15:34:59'),(43,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 15:35:09'),(44,'åˆ˜å…«-lb','127.0.0.1','2018-12-24 15:36:09'),(45,'åˆ˜å…«-lb','127.0.0.1','2018-12-24 15:42:58'),(46,'åˆ˜å…«-lb','127.0.0.1','2018-12-24 15:43:04'),(47,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 15:46:01'),(48,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 17:03:54'),(49,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-24 17:26:32'),(50,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 09:07:42'),(51,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 09:16:27'),(52,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 09:59:03'),(53,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 10:05:13'),(54,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 10:05:47'),(55,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 10:11:17'),(56,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 10:14:06'),(57,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 10:36:16'),(58,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 14:17:21'),(59,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 14:20:00'),(60,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 14:34:22'),(61,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 14:34:27'),(62,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 14:38:37'),(63,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 14:50:37'),(64,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 16:01:35'),(65,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 16:25:28'),(66,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 16:27:37'),(67,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 16:28:28'),(68,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 16:44:02'),(69,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-25 16:47:55'),(70,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-28 15:59:34'),(71,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-28 17:27:16'),(72,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-28 17:29:40'),(73,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2018-12-28 17:51:10'),(74,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-15 17:05:02'),(75,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-15 17:05:12'),(76,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-15 17:10:22'),(77,'åˆ˜å…«-lb','127.0.0.1','2019-04-15 17:11:45'),(78,'åˆ˜å…«-lb','127.0.0.1','2019-04-15 17:28:50'),(79,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-15 17:29:13'),(80,'åˆ˜å…«-lb','127.0.0.1','2019-04-15 17:30:59'),(81,'åˆ˜å…«-lb','127.0.0.1','2019-04-15 17:32:42'),(82,'åˆ˜å…«-lb','127.0.0.1','2019-04-15 17:33:48'),(83,'åˆ˜å…«-lb','127.0.0.1','2019-04-15 17:34:17'),(84,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-15 17:36:40'),(85,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-15 17:47:21'),(86,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-15 17:54:10'),(87,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-15 17:55:52'),(88,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 09:26:01'),(89,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 09:26:25'),(90,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 09:46:54'),(91,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 10:07:48'),(92,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 10:10:30'),(93,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 10:14:29'),(94,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 10:15:04'),(95,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 10:15:58'),(96,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 10:28:14'),(97,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 10:32:42'),(98,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 10:33:03'),(99,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 11:02:01'),(100,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 11:03:09'),(101,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 11:13:42'),(102,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-04-16 11:24:55'),(104,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 01:11:34'),(105,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 01:24:03'),(106,'æå››-ls','127.0.0.1','2019-08-14 01:25:47'),(107,'æå››-ls','127.0.0.1','2019-08-14 01:26:41'),(108,'å­™ä¸ƒ-sq','127.0.0.1','2019-08-14 01:28:22'),(109,'åˆ˜å…«-lb','127.0.0.1','2019-08-14 01:28:32'),(110,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 01:46:18'),(111,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 02:18:44'),(112,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 02:32:06'),(113,'æå››-ls','127.0.0.1','2019-08-14 03:00:19'),(114,'æå››-ls','127.0.0.1','2019-08-14 03:00:56'),(115,'æå››-ls','127.0.0.1','2019-08-14 03:01:31'),(116,'æå››-ls','127.0.0.1','2019-08-14 03:01:39'),(117,'æå››-ls','127.0.0.1','2019-08-14 03:02:25'),(118,'æå››-ls','127.0.0.1','2019-08-14 03:04:57'),(119,'æå››-ls','127.0.0.1','2019-08-14 03:07:19'),(120,'æå››-ls','127.0.0.1','2019-08-14 03:07:54'),(121,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 03:13:06'),(122,'æå››-ls','127.0.0.1','2019-08-14 03:14:46'),(123,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 06:03:47'),(124,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 07:20:12'),(125,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 07:23:05'),(126,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 07:25:30'),(127,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 07:26:34'),(128,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 07:27:22'),(129,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 07:27:51'),(130,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 08:22:05'),(131,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 08:43:53'),(132,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 08:45:55'),(133,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 08:47:13'),(134,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 09:35:20'),(135,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 09:41:02'),(136,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 09:44:04'),(137,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 09:50:27'),(138,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 09:56:57'),(139,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-14 09:59:02'),(140,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 01:05:37'),(141,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 02:01:44'),(142,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 02:05:57'),(143,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 02:07:04'),(144,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 02:20:02'),(145,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 02:20:20'),(146,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 02:21:42'),(147,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 03:37:37'),(148,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 03:52:40'),(149,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 03:59:37'),(150,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 06:11:45'),(151,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 06:23:27'),(152,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 06:50:31'),(153,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 06:54:49'),(154,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 07:00:48'),(155,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 07:01:18'),(156,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 07:03:35'),(157,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 07:09:55'),(158,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 07:46:09'),(159,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 08:17:59'),(160,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 08:22:29'),(161,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 08:23:32'),(162,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 08:26:48'),(163,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 08:31:19'),(164,'è¶…çº§ç®¡ç†å‘˜-system','127.0.0.1','2019-08-16 08:55:36'),(169,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-07 13:34:46'),(170,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-07 14:40:25'),(171,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-07 14:41:36'),(172,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-07 14:45:25'),(173,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-07 14:48:02'),(174,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-07 14:56:40'),(175,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-07 15:10:24'),(176,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 03:04:26'),(177,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 03:18:43'),(178,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 04:53:38'),(179,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 04:56:08'),(180,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 05:01:35'),(181,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 05:53:07'),(182,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 05:54:22'),(183,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 07:10:19'),(184,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 08:17:09'),(185,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 09:24:55'),(186,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-08 10:28:16'),(187,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 02:29:21'),(188,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 03:51:55'),(189,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 03:55:26'),(190,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 03:57:38'),(191,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 06:03:11'),(192,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 09:22:54'),(193,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 14:40:59'),(194,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 15:52:10'),(195,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-09 16:38:23'),(196,'ç½—æ°¸æµ©','0:0:0:0:0:0:0:1','2019-10-09 17:22:44'),(197,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 04:21:29'),(198,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 06:36:11'),(199,'ç½—æ°¸æµ©','0:0:0:0:0:0:0:1','2019-10-10 06:39:23'),(200,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 06:40:42'),(201,'åˆ˜å…«','0:0:0:0:0:0:0:1','2019-10-10 06:43:39'),(202,'ç½—æ°¸æµ©','0:0:0:0:0:0:0:1','2019-10-10 06:43:57'),(203,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 06:44:58'),(204,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 07:28:58'),(205,'ç½—æ°¸æµ©','0:0:0:0:0:0:0:1','2019-10-10 07:29:14'),(206,'ç½—æ°¸æµ©','0:0:0:0:0:0:0:1','2019-10-10 08:06:08'),(207,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 08:12:39'),(208,'ç½—æ°¸æµ©','0:0:0:0:0:0:0:1','2019-10-10 08:12:48'),(209,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 08:18:47'),(210,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 08:58:44'),(211,'ç½—æ°¸æµ©','0:0:0:0:0:0:0:1','2019-10-10 09:02:37'),(212,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 11:50:24'),(213,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 11:52:43'),(214,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 12:36:53'),(215,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 13:45:42'),(216,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-10 14:47:15'),(217,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 01:39:36'),(218,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 01:57:36'),(219,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 02:07:39'),(220,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 03:17:13'),(221,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 03:26:11'),(222,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 03:30:39'),(223,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 03:36:34'),(224,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 03:43:50'),(225,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 06:03:27'),(226,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 06:05:17'),(227,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 06:07:31'),(228,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 06:09:16'),(229,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 06:15:55'),(230,'é›·å†›','127.0.0.1','2019-10-11 06:17:13'),(231,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 07:55:07'),(232,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 07:59:14'),(233,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 08:06:44'),(234,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 08:09:35'),(235,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 08:11:50'),(236,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 08:19:34'),(237,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 08:26:14'),(238,'é›·å†›','127.0.0.1','2019-10-11 08:31:38'),(239,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 08:35:28'),(240,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 08:39:25'),(241,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 09:04:42'),(242,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 09:14:33'),(243,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 09:16:04'),(244,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 11:13:43'),(245,'é›·å†›','127.0.0.1','2019-10-11 11:34:03'),(246,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 11:36:58'),(247,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 11:42:35'),(248,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 12:06:17'),(249,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 13:20:18'),(250,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 13:30:28'),(251,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 13:36:59'),(252,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 14:41:08'),(253,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 14:55:19'),(254,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 14:57:27'),(255,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 15:03:10'),(256,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 15:09:57'),(257,'é›·å†›','127.0.0.1','2019-10-11 15:14:29'),(258,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 15:15:08'),(259,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-11 15:19:29'),(260,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 02:36:43'),(261,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 02:39:18'),(262,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 02:43:51'),(263,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 02:44:21'),(264,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 02:46:50'),(265,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 02:50:11'),(266,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 02:51:40'),(267,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 03:04:25'),(268,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 03:51:47'),(269,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 03:57:02'),(270,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 04:07:12'),(271,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 04:57:05'),(272,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 06:14:31'),(273,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 06:23:37'),(274,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 06:28:43'),(275,'é›·å†›','127.0.0.1','2019-10-12 06:30:59'),(276,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 06:40:09'),(277,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 06:48:35'),(278,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 07:01:14'),(279,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 07:10:08'),(280,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 07:10:56'),(281,'é›·å†›','127.0.0.1','2019-10-12 07:12:54'),(282,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 07:20:26'),(283,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 08:01:39'),(284,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 08:20:23'),(285,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 08:34:42'),(286,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:06:07'),(287,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:11:25'),(288,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:12:26'),(289,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:14:46'),(290,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:16:42'),(291,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:20:34'),(292,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:25:11'),(293,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:39:28'),(294,'æ¢çˆ±æ–‡','0:0:0:0:0:0:0:1','2019-10-12 09:42:43'),(295,'æ¢çˆ±æ–‡','0:0:0:0:0:0:0:1','2019-10-12 09:52:19'),(296,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:54:22'),(297,'æ¢çˆ±æ–‡','0:0:0:0:0:0:0:1','2019-10-12 09:56:18'),(298,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:56:50'),(299,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:58:11'),(300,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:58:23'),(301,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 09:59:47'),(302,'æ¢çˆ±æ–‡','0:0:0:0:0:0:0:1','2019-10-12 10:00:10'),(303,'æ¢çˆ±æ–‡','0:0:0:0:0:0:0:1','2019-10-12 10:02:17'),(304,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:10:24'),(305,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:13:43'),(306,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:17:28'),(307,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:21:13'),(308,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:31:38'),(309,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:34:41'),(310,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:38:56'),(311,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:40:43'),(312,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:42:37'),(313,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:45:30'),(314,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:49:03'),(315,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 11:54:39'),(316,'é›·å†›','127.0.0.1','2019-10-12 11:57:28'),(317,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 12:33:35'),(318,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 12:53:59'),(319,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 13:07:11'),(320,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 13:20:51'),(321,'é›·å†›','127.0.0.1','2019-10-12 13:22:52'),(322,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 13:55:19'),(323,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 14:07:32'),(324,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 14:10:36'),(325,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-12 14:30:03'),(326,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-15 13:50:57'),(327,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-15 13:52:19'),(328,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-15 15:12:42'),(329,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-15 15:17:04'),(330,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-15 15:18:45'),(331,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 01:53:54'),(332,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 02:21:26'),(333,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 02:22:30'),(334,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 02:24:42'),(335,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 02:55:18'),(336,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 02:57:31'),(337,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 03:09:17'),(338,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 03:11:48'),(339,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 03:12:00'),(340,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 03:14:33'),(341,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 03:19:01'),(342,'ç‹äº”','0:0:0:0:0:0:0:1','2019-10-16 03:29:53'),(343,'èµµå…­','0:0:0:0:0:0:0:1','2019-10-16 03:31:57'),(344,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 03:32:19'),(345,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 03:32:30'),(346,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 03:34:42'),(347,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 06:08:23'),(348,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 06:21:47'),(349,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 08:21:58'),(350,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 08:52:40'),(351,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 09:23:55'),(352,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 09:27:36'),(353,'é›·å†›','127.0.0.1','2019-10-16 09:31:33'),(354,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 09:35:24'),(355,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 10:22:07'),(356,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 10:36:07'),(357,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 10:36:23'),(358,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 10:57:24'),(359,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 10:57:44'),(360,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 11:07:10'),(361,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 11:07:30'),(362,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 12:19:30'),(363,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 12:21:39'),(364,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 12:21:58'),(365,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 12:24:31'),(366,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 12:24:43'),(367,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-16 14:18:26'),(368,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 14:18:37'),(369,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-16 16:37:03'),(370,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 06:44:16'),(371,'èµµå…­','0:0:0:0:0:0:0:1','2019-10-17 07:28:35'),(372,'ç‹äº”','0:0:0:0:0:0:0:1','2019-10-17 07:31:50'),(373,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 07:32:26'),(374,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 07:37:08'),(375,'èµµå…­','0:0:0:0:0:0:0:1','2019-10-17 07:42:05'),(376,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 07:42:47'),(377,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 07:43:10'),(378,'èµµå…­','0:0:0:0:0:0:0:1','2019-10-17 07:43:23'),(379,'ç‹äº”','0:0:0:0:0:0:0:1','2019-10-17 07:44:02'),(380,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 07:45:13'),(381,'èµµå…­','0:0:0:0:0:0:0:1','2019-10-17 07:47:53'),(382,'ç‹äº”','0:0:0:0:0:0:0:1','2019-10-17 07:48:30'),(383,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 07:49:21'),(384,'èµµå…­','0:0:0:0:0:0:0:1','2019-10-17 07:50:16'),(385,'ç‹äº”','0:0:0:0:0:0:0:1','2019-10-17 07:50:54'),(386,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 07:51:23'),(387,'èµµå…­','0:0:0:0:0:0:0:1','2019-10-17 08:31:15'),(388,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 09:59:58'),(389,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 10:38:21'),(390,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 11:50:39'),(391,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 12:45:24'),(392,'èµµå…­','0:0:0:0:0:0:0:1','2019-10-17 12:51:11'),(393,'ç‹äº”','0:0:0:0:0:0:0:1','2019-10-17 12:52:12'),(394,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 12:52:33'),(395,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 12:53:10'),(396,'ç‹äº”','0:0:0:0:0:0:0:1','2019-10-17 12:56:54'),(397,'å­™ä¸ƒ','0:0:0:0:0:0:0:1','2019-10-17 12:57:20'),(398,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 12:57:43'),(399,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 13:00:38'),(400,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 13:11:47'),(401,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 13:44:58'),(402,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 14:07:20'),(403,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 14:13:09'),(404,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 14:26:32'),(405,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-17 15:52:55'),(406,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-18 01:18:12'),(407,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-18 01:23:59'),(408,'é›·å†›','127.0.0.1','2019-10-18 01:41:38'),(409,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-18 02:03:14'),(410,'é›·å†›','127.0.0.1','2019-10-18 02:07:41'),(411,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-18 02:11:10'),(412,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-18 02:20:07'),(413,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-18 02:23:57'),(414,'é›·å†›','0:0:0:0:0:0:0:1','2019-10-18 02:45:18');

/*Table structure for table `sys_notice` */

DROP TABLE IF EXISTS `sys_notice`;

CREATE TABLE `sys_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `createtime` datetime DEFAULT NULL,
  `opername` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_notice` */

insert  into `sys_notice`(`id`,`title`,`content`,`createtime`,`opername`) values (1,'å…³äºç³»ç»ŸV1.3æ›´æ–°å…¬å‘Š','2','2018-08-07 00:00:00','ç®¡ç†å‘˜'),(10,'å…³äºç³»ç»ŸV1.2æ›´æ–°å…¬å‘Š','12312312<img src=\"/resources/layui/images/face/42.gif\" alt=\"[æŠ“ç‹‚]\">','2018-08-07 00:00:00','è¶…çº§ç®¡ç†å‘˜'),(11,'å…³äºç³»ç»ŸV1.1æ›´æ–°å…¬å‘Š','21321321321<img src=\"/resources/layui/images/face/18.gif\" alt=\"[å³å“¼å“¼]\">','2018-08-07 00:00:00','è¶…çº§ç®¡ç†å‘˜'),(16,'fdsfsd','fsdf','2019-10-08 03:04:54','é›·å†›');

/*Table structure for table `sys_permission` */

DROP TABLE IF EXISTS `sys_permission`;

CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT 'æƒé™ç±»å‹[menu/permission]',
  `title` varchar(255) DEFAULT NULL,
  `percode` varchar(255) DEFAULT NULL COMMENT 'æƒé™ç¼–ç [åªæœ‰type= permissionæ‰æœ‰  user:view]',
  `icon` varchar(255) DEFAULT NULL,
  `href` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  `open` int(11) DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  `available` int(11) DEFAULT NULL COMMENT 'çŠ¶æ€ã€0ä¸å¯ç”¨1å¯ç”¨ã€‘',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_permission` */

insert  into `sys_permission`(`id`,`pid`,`type`,`title`,`percode`,`icon`,`href`,`target`,`open`,`ordernum`,`available`) values (1,0,'menu','ERPä»“åº“ç®¡ç†ç³»ç»Ÿ',NULL,'&#xe68e;','','',1,1,1),(2,1,'menu','åŸºç¡€ç®¡ç†',NULL,'&#xe857;','','',0,2,1),(3,1,'menu','è¿›è´§ç®¡ç†',NULL,'&#xe645;','',NULL,0,3,1),(4,1,'menu','é”€å”®ç®¡ç†',NULL,'&#xe611;','','',0,4,1),(5,1,'menu','ç³»ç»Ÿç®¡ç†',NULL,'&#xe614;','','',0,5,1),(6,1,'menu','å…¶å®ƒç®¡ç†',NULL,'&#xe628;','','',0,6,1),(7,2,'menu','å®¢æˆ·ç®¡ç†',NULL,'&#xe651;','/bus/toCustomerManager','',0,7,1),(8,2,'menu','ä¾›åº”å•†ç®¡ç†',NULL,'&#xe658;','/bus/toProviderManager','',0,8,1),(9,2,'menu','å•†å“ç®¡ç†',NULL,'&#xe657;','/bus/toGoodsManager','',0,9,1),(10,3,'menu','å•†å“è¿›è´§',NULL,'&#xe756;','/bus/toInportManager','',0,10,1),(11,3,'menu','å•†å“é€€è´§æŸ¥è¯¢',NULL,'&#xe65a;','/bus/toOutportManager','',0,11,1),(12,4,'menu','å•†å“é”€å”®',NULL,'&#xe65b;','/bus/toSalesManager','',0,12,1),(13,4,'menu','é”€å”®é€€è´§æŸ¥è¯¢',NULL,'&#xe770;','/bus/toSalesBackManager','',0,13,1),(14,5,'menu','éƒ¨é—¨ç®¡ç†',NULL,'&#xe770;','/sys/toDeptManager','',0,14,1),(15,5,'menu','èœå•ç®¡ç†',NULL,'&#xe857;','/sys/toMenuManager','',0,15,1),(16,5,'menu','æƒé™ç®¡ç†','','&#xe857;','/sys/toPermissionManager','',0,16,1),(17,5,'menu','è§’è‰²ç®¡ç†','','&#xe650;','/sys/toRoleManager','',0,17,1),(18,5,'menu','ç”¨æˆ·ç®¡ç†','','&#xe612;','/sys/toUserManager','',0,18,1),(21,6,'menu','ç™»é™†æ—¥å¿—',NULL,'&#xe675;','/sys/toLoginInfoManager','',0,21,1),(22,6,'menu','ç³»ç»Ÿå…¬å‘Š',NULL,'&#xe756;','/sys/toNoticeManager',NULL,0,22,1),(23,6,'menu','å›¾æ ‡ç®¡ç†',NULL,'&#xe670;','../resources/page/icon.html',NULL,0,23,1),(30,14,'permission','æ·»åŠ éƒ¨é—¨','dept:create','',NULL,NULL,0,24,1),(31,14,'permission','ä¿®æ”¹éƒ¨é—¨','dept:update','',NULL,NULL,0,26,1),(32,14,'permission','åˆ é™¤éƒ¨é—¨','dept:delete','',NULL,NULL,0,27,1),(34,15,'permission','æ·»åŠ èœå•','menu:create','','','',0,29,1),(35,15,'permission','ä¿®æ”¹èœå•','menu:update','',NULL,NULL,0,30,1),(36,15,'permission','åˆ é™¤èœå•','menu:delete','',NULL,NULL,0,31,1),(38,16,'permission','æ·»åŠ æƒé™','permission:create','',NULL,NULL,0,33,1),(39,16,'permission','ä¿®æ”¹æƒé™','permission:update','',NULL,NULL,0,34,1),(40,16,'permission','åˆ é™¤æƒé™','permission:delete','',NULL,NULL,0,35,1),(42,17,'permission','æ·»åŠ è§’è‰²','role:create','',NULL,NULL,0,37,1),(43,17,'permission','ä¿®æ”¹è§’è‰²','role:update','',NULL,NULL,0,38,1),(44,17,'permission','è§’è‰²åˆ é™¤','role:delete','',NULL,NULL,0,39,1),(46,17,'permission','åˆ†é…æƒé™','role:selectPermission','',NULL,NULL,0,41,1),(47,18,'permission','æ·»åŠ ç”¨æˆ·','user:create','',NULL,NULL,0,42,1),(48,18,'permission','ä¿®æ”¹ç”¨æˆ·','user:update','',NULL,NULL,0,43,1),(49,18,'permission','åˆ é™¤ç”¨æˆ·','user:delete','',NULL,NULL,0,44,1),(51,18,'permission','ç”¨æˆ·åˆ†é…è§’è‰²','user:selectRole','',NULL,NULL,0,46,1),(52,18,'permission','é‡ç½®å¯†ç ','user:resetPwd',NULL,NULL,NULL,0,47,1),(53,14,'permission','éƒ¨é—¨æŸ¥è¯¢','dept:view',NULL,NULL,NULL,0,48,1),(54,15,'permission','èœå•æŸ¥è¯¢','menu:view',NULL,NULL,NULL,0,49,1),(55,16,'permission','æƒé™æŸ¥è¯¢','permission:view',NULL,NULL,NULL,0,50,1),(56,17,'permission','è§’è‰²æŸ¥è¯¢','role:view',NULL,NULL,NULL,0,51,1),(57,18,'permission','ç”¨æˆ·æŸ¥è¯¢','user:view',NULL,NULL,NULL,0,52,1),(68,7,'permission','å®¢æˆ·æŸ¥è¯¢','customer:view',NULL,NULL,NULL,NULL,60,1),(69,7,'permission','å®¢æˆ·æ·»åŠ ','customer:create',NULL,NULL,NULL,NULL,61,1),(70,7,'permission','å®¢æˆ·ä¿®æ”¹','customer:update',NULL,NULL,NULL,NULL,62,1),(71,7,'permission','å®¢æˆ·åˆ é™¤','customer:delete',NULL,NULL,NULL,NULL,63,1),(73,21,'permission','æ—¥å¿—æŸ¥è¯¢','info:view',NULL,NULL,NULL,NULL,65,1),(74,21,'permission','æ—¥å¿—åˆ é™¤','info:delete',NULL,NULL,NULL,NULL,66,1),(75,21,'permission','æ—¥å¿—æ‰¹é‡åˆ é™¤','info:batchdelete',NULL,NULL,NULL,NULL,67,1),(76,22,'permission','å…¬å‘ŠæŸ¥è¯¢','notice:view',NULL,NULL,NULL,NULL,68,1),(77,22,'permission','å…¬å‘Šæ·»åŠ ','notice:create',NULL,NULL,NULL,NULL,69,1),(78,22,'permission','å…¬å‘Šä¿®æ”¹','notice:update',NULL,NULL,NULL,NULL,70,1),(79,22,'permission','å…¬å‘Šåˆ é™¤','notice:delete',NULL,NULL,NULL,NULL,71,1),(81,8,'permission','ä¾›åº”å•†æŸ¥è¯¢','provider:view',NULL,NULL,NULL,NULL,73,1),(82,8,'permission','ä¾›åº”å•†æ·»åŠ ','provider:create',NULL,NULL,NULL,NULL,74,1),(83,8,'permission','ä¾›åº”å•†ä¿®æ”¹','provider:update',NULL,NULL,NULL,NULL,75,1),(84,8,'permission','ä¾›åº”å•†åˆ é™¤','provider:delete',NULL,NULL,NULL,NULL,76,1),(86,22,'permission','å…¬å‘ŠæŸ¥çœ‹','notice:viewnotice',NULL,NULL,NULL,NULL,78,1),(91,9,'permission','å•†å“æŸ¥è¯¢','goods:view',NULL,NULL,NULL,0,79,1),(92,9,'permission','å•†å“æ·»åŠ ','goods:create',NULL,NULL,NULL,0,80,1),(98,6,'menu','ç¼“å­˜ç®¡ç†',NULL,'&#xe6b1;','/sys/toCacheManager',NULL,0,84,1),(99,6,'menu','æŠ€æœ¯ç®¡ç†',NULL,'&#xe653;','/sys/toTechnologyManager',NULL,0,85,1),(102,6,'menu','æ•°æ®æºç›‘æ§',NULL,'&#xe674;','/druid',NULL,0,87,1),(103,1,'menu','å®¡æ‰¹ç®¡ç†',NULL,'&#xe62a;','',NULL,0,88,1),(104,103,'menu','è¯·å‡å•ç®¡ç†',NULL,'&#xe63c;','/sys/toLeaveBillManager',NULL,0,89,1),(105,1,'menu','æµç¨‹ç®¡ç†',NULL,'&#xe672;','',NULL,0,90,1),(106,105,'menu','æµç¨‹ç®¡ç†',NULL,'&#xe60a;','/sys/toWorkFlowManager',NULL,0,91,1),(107,103,'menu','æˆ‘çš„å¾…åŠä»»åŠ¡',NULL,'&#xe66b;','/sys/toTaskManager',NULL,0,92,1),(108,1,'menu','ç»Ÿè®¡ç®¡ç†',NULL,'&#xe656;','',NULL,1,93,1),(109,108,'menu','å®¢æˆ·åœ°åŒºç»Ÿè®¡',NULL,'&#xe6b2;','/stat/toCustomerAreaStat',NULL,0,94,1),(110,108,'menu','å…¬å¸å¹´åº¦é”€å”®',NULL,'&#xe633;','/stat/toCompanyYearGradeStat',NULL,0,95,1),(111,108,'menu','å®¢æˆ·å¹´åº¦é”€å”®ç»Ÿè®¡',NULL,'&#xe637;','/stat/toCustomerYearSalesManager',NULL,0,96,1);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`name`,`remark`,`available`,`createtime`) values (1,'è¶…çº§ç®¡ç†å‘˜','æ‹¥æœ‰æ‰€æœ‰èœå•æƒé™',1,'2019-04-10 14:06:32'),(4,'åŸºç¡€æ•°æ®ç®¡ç†å‘˜','åŸºç¡€æ•°æ®ç®¡ç†å‘˜',1,'2019-04-10 14:06:32'),(5,'ä»“åº“ç®¡ç†å‘˜','ä»“åº“ç®¡ç†å‘˜',1,'2019-04-10 14:06:32'),(6,'é”€å”®ç®¡ç†å‘˜','é”€å”®ç®¡ç†å‘˜',1,'2019-04-10 14:06:32'),(7,'ç³»ç»Ÿç®¡ç†å‘˜','ç³»ç»Ÿç®¡ç†å‘˜',1,'2019-04-10 14:06:32'),(12,'å…¬å‘Šç®¡ç†å‘˜','å…¬å‘Šç®¡ç†è€…',1,'2019-10-10 06:37:23'),(13,'æµç¨‹ç®¡ç†å‘˜','æµç¨‹ç®¡ç†',1,'2019-10-16 03:13:09'),(14,'å®¡æ‰¹ç®¡ç†å‘˜','å®¡æ‰¹ç®¡ç†',1,'2019-10-16 12:22:45'),(15,'éƒ¨é—¨é¢†å¯¼çš„å®¡æ‰¹ç®¡ç†','éƒ¨é—¨é¢†å¯¼çš„å®¡æ‰¹ç®¡ç†',1,'2019-10-17 12:54:22'),(16,'å‘˜å·¥çš„å®¡æ‰¹ç®¡ç†','å‘˜å·¥çš„å®¡æ‰¹ç®¡ç†',1,'2019-10-17 12:54:41');

/*Table structure for table `sys_role_permission` */

DROP TABLE IF EXISTS `sys_role_permission`;

CREATE TABLE `sys_role_permission` (
  `rid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  PRIMARY KEY (`pid`,`rid`) USING BTREE,
  KEY `FK_tcsr9ucxypb3ce1q5qngsfk33` (`rid`) USING BTREE,
  CONSTRAINT `sys_role_permission_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `sys_permission` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sys_role_permission_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_role_permission` */

insert  into `sys_role_permission`(`rid`,`pid`) values (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,21),(1,22),(1,23),(1,30),(1,31),(1,32),(1,34),(1,35),(1,36),(1,38),(1,39),(1,40),(1,42),(1,43),(1,44),(1,46),(1,47),(1,48),(1,49),(1,51),(1,52),(1,53),(1,54),(1,55),(1,56),(1,57),(1,68),(1,69),(1,70),(1,71),(1,73),(1,74),(1,75),(1,76),(1,77),(1,78),(1,79),(1,81),(1,82),(1,83),(1,84),(1,86),(1,91),(1,92),(1,98),(1,99),(1,102),(1,103),(1,104),(4,1),(4,2),(4,7),(4,8),(4,9),(4,68),(4,69),(4,70),(4,71),(4,81),(4,82),(4,83),(4,84),(4,91),(4,92),(5,1),(5,3),(5,10),(5,11),(6,1),(6,4),(6,12),(6,13),(7,1),(7,5),(7,14),(7,15),(7,16),(7,17),(7,18),(7,30),(7,31),(7,32),(7,34),(7,35),(7,36),(7,38),(7,39),(7,40),(7,42),(7,43),(7,44),(7,46),(7,47),(7,48),(7,49),(7,51),(7,52),(7,53),(7,54),(7,55),(7,56),(7,57),(12,1),(12,6),(12,22),(12,76),(12,77),(12,78),(12,79),(12,86),(13,1),(13,105),(13,106),(14,1),(14,103),(14,104),(14,107),(15,1),(15,103),(15,107),(16,1),(16,103),(16,104),(16,107);

/*Table structure for table `sys_role_user` */

DROP TABLE IF EXISTS `sys_role_user`;

CREATE TABLE `sys_role_user` (
  `rid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`rid`) USING BTREE,
  KEY `FK_203gdpkwgtow7nxlo2oap5jru` (`rid`) USING BTREE,
  CONSTRAINT `sys_role_user_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `sys_role` (`id`),
  CONSTRAINT `sys_role_user_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_role_user` */

insert  into `sys_role_user`(`rid`,`uid`) values (4,3),(5,4),(7,2),(7,3),(7,4),(7,5),(7,6),(12,13),(15,2),(15,3),(15,4),(16,5),(16,6);

/*Table structure for table `sys_technology` */

DROP TABLE IF EXISTS `sys_technology`;

CREATE TABLE `sys_technology` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `available` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `sys_technology` */

insert  into `sys_technology`(`id`,`name`,`available`,`remark`) values (1,'spring',1,'iocå’Œaopçš„ä¼˜ç§€æ¡†æ¶'),(2,'mybatis',1,'è½»é‡çº§çš„æŒä¹…åŒ–æ¡†æ¶'),(3,'springmvc',1,'springçš„webå±‚ä¼˜ç§€æ¡†æ¶'),(4,'é€šç”¨mapper',1,'ç”Ÿæˆå•è¡¨çš„sql'),(5,'myabtis-plus',1,'ç”Ÿæˆå•è¡¨çš„sqlä¸”è‡ªå¸¦åˆ†é¡µæ’ä»¶'),(6,'springboot',1,'å»é…ç½®çš„å¿«é€Ÿé¡¹ç›®æ­å»ºçš„æ¡†æ¶'),(7,'springcloud',1,'å¾®æœåŠ¡æ¡†æ¶'),(8,'shiro',1,'è½»é‡çº§çš„apcheçš„æƒé™æ§åˆ¶æ¡†æ¶'),(9,'spring-security',1,'springçš„æƒé™æ§åˆ¶è§£å†³æ–¹æ¡ˆè¾ƒé‡é‡çº§'),(10,'spring-data',1,''),(11,'quartz',1,'å®šæ—¶ä»»åŠ¡è°ƒåº¦'),(12,'layui',1,'åå°å¼€å‘æ‹¿æ¥å³ç”¨çš„ä¼˜ç§€å‰ç«¯æ¡†æ¶'),(13,'easyui',1,'åå°å¼€å‘çš„ä¼˜ç§€æ¡†æ¶é¡µé¢è¾ƒç®€é™‹'),(14,'activity',1,'å·¥ä½œæµ'),(15,'echarts',1,'ç™¾åº¦çš„å›¾è¡¨å±•ç¤º'),(16,'highcharts',1,'å›¾è¡¨å±•ç¤º'),(17,'poi',1,'excelæŠ¥è¡¨'),(18,'zxing',1,'è°·æ­Œçš„äºŒç»´ç ç”Ÿæˆ'),(19,'qrcode',1,'æ—¥æœ¬çš„äºŒç»´ç ç”Ÿæˆ'),(20,'druid',1,'é˜¿é‡Œå·´å·´çš„è¿æ¥æ± '),(21,'åŸºæœ¬ssm',1,'åŸºæœ¬ssmæ•´åˆ'),(22,'themeleaf',1,'æ¨¡æ¿æŠ€æœ¯'),(23,'jsp',1,'å®é™…ä¹Ÿæ˜¯servletä¸å»ºè®®ç”¨');

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `loginname` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `pwd` varchar(255) DEFAULT NULL,
  `deptid` int(11) DEFAULT NULL,
  `hiredate` datetime DEFAULT NULL,
  `mgr` int(11) DEFAULT NULL,
  `available` int(11) DEFAULT '1',
  `ordernum` int(11) DEFAULT NULL,
  `type` int(255) DEFAULT NULL COMMENT 'ç”¨æˆ·ç±»å‹[0è¶…çº§ç®¡ç†å‘˜1ï¼Œç®¡ç†å‘˜ï¼Œ2æ™®é€šç”¨æˆ·]',
  `userimgpath` varchar(255) DEFAULT NULL COMMENT 'å¤´åƒåœ°å€',
  `salt` varchar(255) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `province` varchar(32) DEFAULT NULL,
  `city` varchar(32) DEFAULT NULL,
  `area` varchar(32) DEFAULT NULL,
  `telephone` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_3rrcpvho2w1mx1sfiuuyir1h` (`deptid`) USING BTREE,
  CONSTRAINT `sys_user_ibfk_1` FOREIGN KEY (`deptid`) REFERENCES `sys_dept` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`name`,`loginname`,`address`,`sex`,`remark`,`pwd`,`deptid`,`hiredate`,`mgr`,`available`,`ordernum`,`type`,`userimgpath`,`salt`,`birthday`,`email`,`province`,`city`,`area`,`telephone`) values (1,'é›·å†›','leijun','ç³»ç»Ÿæ·±å¤„çš„ç”·äºº',1,'è¶…çº§ç®¡ç†å‘˜','83175e09bd5fddad4810a0d6fbe673ad',1,'2018-06-25 11:06:34',NULL,1,1,0,'2019-10-17/201910172111539011403.jpg','0408827849524b62ab0dd8f29ff2e476','2019-10-25','1946408873@qq.com','44','','440904','123456'),(2,'æå››','ls','æ­¦æ±‰',0,'KING','b07b848d69e0553b80e601d31571797e',1,'2018-06-25 11:06:36',NULL,1,2,1,'img/defaultUserImg.jpg','FC1EE06AE4354D3FBF7FDD15C8FCDA71',NULL,NULL,NULL,NULL,NULL,NULL),(3,'ç‹äº”','ww','æ­¦æ±‰',1,'ç®¡ç†å‘˜','3c3f971eae61e097f59d52360323f1c8',3,'2018-06-25 11:06:38',2,1,3,1,'img/defaultUserImg.jpg','3D5F956E053C4E85B7D2681386E235D2',NULL,NULL,NULL,NULL,NULL,NULL),(4,'èµµå…­','zl','æ­¦æ±‰',1,'ç¨‹åºå‘˜','2e969742a7ea0c7376e9551d578e05dd',4,'2018-06-25 11:06:40',3,1,4,1,'img/defaultUserImg.jpg','6480EE1391E34B0886ACADA501E31145',NULL,NULL,NULL,NULL,NULL,NULL),(5,'å­™ä¸ƒ','sq','æ­¦æ±‰',1,'ç¨‹åºå‘˜','47b4c1ad6e4b54dd9387a09cb5a03de1',2,'2018-06-25 11:06:43',4,1,5,1,'img/defaultUserImg.jpg','FE3476C3E3674E5690C737C269FCBF8E',NULL,NULL,NULL,NULL,NULL,NULL),(6,'åˆ˜å…«','lb','æ·±åœ³',1,'ç¨‹åºå‘˜','bcee2b05b4b591106829aec69a094806',4,'2018-08-06 11:21:12',3,1,6,1,'img/defaultUserImg.jpg','E6CCF54A09894D998225878BBD139B20',NULL,NULL,NULL,NULL,NULL,NULL),(7,'å°ç±³','xiaomi','æ­¦æ±‰',1,'ç”Ÿäº§å°ç±³æ‰‹æœº','ebb6fd73fd8ddb94f38453af4f24d280',4,'2019-10-09 14:55:24',6,1,7,1,'img/defaultUserImg.jpg','D0D4349CB77D4DBE80FB7F99A21935E0',NULL,NULL,NULL,NULL,NULL,NULL),(8,'é›·å†›','111','æ­¦æ±‰',1,'å°ç±³é›†å›¢CEO','594968e42678a4e438704da63c65190c',22,'2019-10-09 16:19:06',NULL,1,8,1,'img/defaultUserImg.jpg','D88499BD318846CDBB4BB363F1E21F83',NULL,NULL,NULL,NULL,NULL,NULL),(9,'è·¯å«å…µ','luweibing','æ­¦æ±‰',1,'çº¢ç±³','100f39130d8111751364fd52084f91c1',22,'2019-10-09 16:30:35',8,1,9,1,'img/defaultUserImg.jpg','76B7970817D241F1B0E903E014D459A4',NULL,NULL,NULL,NULL,NULL,NULL),(10,'æ—æ–Œ','linbin','æ­¦æ±‰',1,'å°ç±³','e949e4ad92d81452cddae1f776b74129',22,'2019-10-09 16:33:05',8,1,10,1,'img/defaultUserImg.jpg','3D237866EB5E4E9E9C40F25A6F769D6E',NULL,NULL,NULL,NULL,NULL,NULL),(11,'é©¬åŒ–è…¾','mahuateng','æ·±åœ³',1,'ææ¸¸æˆ','c3d419754539338aa9e4cdda13550daf',22,'2019-10-09 16:44:57',8,1,11,1,'img/defaultUserImg.jpg','E8116A733E2649B8A1DEBADAA4BD96B8',NULL,NULL,NULL,NULL,NULL,NULL),(13,'ç½—æ°¸æµ©','luoyonghao','åŒ—äº¬',1,'é”¤å­','2e6e55cf04d4fa8daa3c983ff10b0f8d',22,'2019-10-09 17:18:20',8,1,12,1,'img/defaultUserImg.jpg','C03EFF2C3424473784D53D9E6A29BD55',NULL,NULL,NULL,NULL,NULL,NULL),(14,'æ¢çˆ±æ–‡','liangaiwen','å¹¿å·å¤§çŸ³',0,'æˆ‘æ˜¯ä¸€ä¸ªå¯çˆ±çš„å°çŒª','240cfc56536c00c2cda3ba923d9c8f9a',1,'2019-10-12 09:41:00',2,1,13,1,'2019-10-12/201910121750404011953.jpg','3C5E75C2CCC94052894CF481A1311EE1',NULL,'123@qq.com','44','4401','440113','12345678910');

/*Table structure for table `sys_user_technology` */

DROP TABLE IF EXISTS `sys_user_technology`;

CREATE TABLE `sys_user_technology` (
  `uid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_technology` */

insert  into `sys_user_technology`(`uid`,`tid`) values (1,5),(1,6),(1,8),(1,11),(1,12),(1,14),(1,15),(1,17),(1,22),(14,1),(14,2),(14,3),(14,4),(14,5),(14,6),(14,7),(14,8),(14,9),(14,10),(14,11),(14,12),(14,13),(14,14),(14,15),(14,16),(14,17),(14,18),(14,19),(14,20),(14,21),(14,22),(14,23);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
