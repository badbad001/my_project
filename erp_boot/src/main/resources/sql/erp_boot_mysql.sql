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

insert  into `act_ge_bytearray`(`ID_`,`REV_`,`NAME_`,`DEPLOYMENT_ID_`,`BYTES_`,`GENERATED_`) values ('2',1,'leaveBill.bpmn','1','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.activiti.org/test\">\n  <process id=\"Leavebill\" name=\"Leavebill\" isExecutable=\"true\">\n    <startEvent id=\"startevent1\" name=\"Start\"></startEvent>\n    <userTask id=\"usertask1\" name=\"提交申请\" activiti:assignee=\"#{username}\"></userTask>\n    <sequenceFlow id=\"flow1\" sourceRef=\"startevent1\" targetRef=\"usertask1\"></sequenceFlow>\n    <userTask id=\"usertask2\" name=\"审批【上级领导】\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"cn.itcast.sys.listener.TaskListenerImpl\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow2\" name=\"提交\" sourceRef=\"usertask1\" targetRef=\"usertask2\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'提交\'}]]></conditionExpression>\n    </sequenceFlow>\n    <userTask id=\"usertask3\" name=\"审批【上上级领导】\">\n      <extensionElements>\n        <activiti:taskListener event=\"create\" class=\"cn.itcast.sys.listener.TaskListenerImpl\"></activiti:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"flow3\" name=\"同意\" sourceRef=\"usertask2\" targetRef=\"usertask3\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'同意\'}]]></conditionExpression>\n    </sequenceFlow>\n    <endEvent id=\"endevent1\" name=\"End\"></endEvent>\n    <sequenceFlow id=\"flow4\" name=\"同意\" sourceRef=\"usertask3\" targetRef=\"endevent1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'同意\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow6\" name=\"驳回\" sourceRef=\"usertask2\" targetRef=\"usertask1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'驳回\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow7\" name=\"驳回\" sourceRef=\"usertask3\" targetRef=\"usertask1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'驳回\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"flow8\" name=\"放弃\" sourceRef=\"usertask1\" targetRef=\"endevent1\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${outcome==\'放弃\'}]]></conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_Leavebill\">\n    <bpmndi:BPMNPlane bpmnElement=\"Leavebill\" id=\"BPMNPlane_Leavebill\">\n      <bpmndi:BPMNShape bpmnElement=\"startevent1\" id=\"BPMNShape_startevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"460.0\" y=\"90.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask1\" id=\"BPMNShape_usertask1\">\n        <omgdc:Bounds height=\"55.0\" width=\"105.0\" x=\"425.0\" y=\"170.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask2\" id=\"BPMNShape_usertask2\">\n        <omgdc:Bounds height=\"55.0\" width=\"156.0\" x=\"400.0\" y=\"270.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"usertask3\" id=\"BPMNShape_usertask3\">\n        <omgdc:Bounds height=\"55.0\" width=\"151.0\" x=\"402.0\" y=\"370.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"endevent1\" id=\"BPMNShape_endevent1\">\n        <omgdc:Bounds height=\"35.0\" width=\"35.0\" x=\"460.0\" y=\"470.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"flow1\" id=\"BPMNEdge_flow1\">\n        <omgdi:waypoint x=\"477.0\" y=\"125.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"477.0\" y=\"170.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow2\" id=\"BPMNEdge_flow2\">\n        <omgdi:waypoint x=\"477.0\" y=\"225.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"478.0\" y=\"270.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"490.0\" y=\"239.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow3\" id=\"BPMNEdge_flow3\">\n        <omgdi:waypoint x=\"478.0\" y=\"325.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"477.0\" y=\"370.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"478.0\" y=\"339.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow4\" id=\"BPMNEdge_flow4\">\n        <omgdi:waypoint x=\"477.0\" y=\"425.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"477.0\" y=\"470.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"477.0\" y=\"439.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow6\" id=\"BPMNEdge_flow6\">\n        <omgdi:waypoint x=\"556.0\" y=\"297.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"685.0\" y=\"297.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"685.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"530.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"689.0\" y=\"240.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow7\" id=\"BPMNEdge_flow7\">\n        <omgdi:waypoint x=\"402.0\" y=\"397.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"292.0\" y=\"397.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"292.0\" y=\"295.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"292.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"425.0\" y=\"197.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"302.0\" y=\"289.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"flow8\" id=\"BPMNEdge_flow8\">\n        <omgdi:waypoint x=\"425.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"284.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"222.0\" y=\"197.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"222.0\" y=\"264.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"222.0\" y=\"487.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"460.0\" y=\"487.0\"></omgdi:waypoint>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"18.0\" width=\"32.0\" x=\"181.0\" y=\"300.0\"></omgdc:Bounds>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),('3',1,'leaveBill.png','1','�PNG\r\n\Z\n\0\0\0\rIHDR\0\0+\0\0�\0\0\0:b=\0\09�IDATx���l$�}?p+��\"\\5-nՖM���rV�����ʹR�Xj��A-EI@QSTU�i�\\Մ��&=U)\"mB�V|�*:���R����8 �8���\0G�r˝}7�96ˮw=k��<��륏N���x��g����k{ \0\0��@�\'\0\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0ȏ\0\0�G\0\0�#�\0\0\0��@\0\0��H \0\0@~$\0\0 ?\0\0�	�`�JennnϞ=co\ZO�-��E� \0t�P�4x�Icpp0�i�ؿ��;���z��կ}򓟚��\Z\Zڹs���L�\'\0�!�\0�СCccci�H�Ʃ���uϽ�]}����.,,}�\0�]@���ݛƉ;��Ʀ٣�|���_~�5�T*��G\0\0[\'�\0�\'\r������me����o[^^.z(\0�E@N���s�����-Ǐ꛲��,--= \0�\n	 \'���ۏ�wd�!�۱\0�E@��ݻ�7_5����NLL=,\0h��u�\Z�`�X��|�7�tSу��H \0]�Ə:��r��g/���X\0�	�����&&&:?�����}��=D\0h��]ccc��鏶�\r2<<\\��\r@��塡�.ŏ����8P�@ +	��fff�����@>s�\r���E\0��@\0��k��馛��@��cccE\0��@\0�h||���~��	��#G.��T�@ +	����{xk��\'�(\0d%�\0t�����g��jIk`����a�袑��o>,�\0@�E�����@�\0�H袩��/�|sW�=��w�e�=P\0�J�}��}�����&����â\n\0YI \0]���T*���@v��=??_�@ +	������?144T�T�%\0d%�\0tWW߈���}.=x�C�6H \0�U�TJ�R7�*�+�O\\|qiyy��!@$�������UW�\0$@>~�}�ۿ��Əo>�cǎW��(zd\0�	 �r���.�ԏ����4~<y�H����I \09Y\\\\LCH\Z�?~�}���_+z@\0�@~:�cǎ{�o;o�Jc��@�@\0rU.�/���O~�S/�x�������������U� \0`�$��U*�4�\\r�H�(�\\�%~|����?��?NsKѧ\0�\"�\0cyy���\Z\Z����/\r>t�.u���r����UW��\\}�.--}�\0�@�*�������Ԏ;�*�\'�����r������@\0���O\0�H���+3\01���E n�9��H \0��:	��Y�\0�\"�\07�@X$\0�f��@ܬs\0a�@\0��u ,\0q���E n�9��H \0��:	��Y�\0�\"�\07�@X$\0�f��@ܬs\0a�@\0��u ,\0q���E n�9��H \0��:	��Y�\0�\"�\07�@X$\0�f��@ܬs\0a�@\0��u ,\0q���E n�9��H \0��:	��Y�\0�\"�\07�@X$\0�f��@ܬs\0a�@\0��u ,\0q���E n�9��H \0��:P����4x����7�����?����ŢO\r\0:L(�m��6�`׮]sssE�\Z\0t�P�J�r�y��ƏK/�txx�\\.}j\0�a@����s�9��@�������O\n\0:O�E]�?���R�T�T�>#\0�<	 w�}��瞛&���q?@�$��\\q��	���n�@\0����&����I \0a�	��u�J�2;;;99966V*�\Z�:G�HǞ>333~0\0� �\0$���i�Ə[n��λ�z�ȑS++�Y���G`���W_}u���9��\'��H @_+��SSS�w�>���S+�Tm���iI���墟(\0�!�\0�+����_����VN�fu�Wo��˖���~�\0����������j]w�u���F�O\0��@�>5??�{��+���>�gz�\r�.�I Џ*�J�Tz�٥���T�:~�G;v\\��\0�}Џfff���VV_�֮�����jk�꫺ᆿ���.����I @?������8~\\��I���䉕��\'�GN&_�w�7������J����_I�y5������y�#�|��0PH=t����h�O\0=O����������X�����Ir�L��j�ҩ��$��?����~r�Ϯ$GO&G_O�*ɓ�ɗ���ڷAN�a?qlpp����\'�\0�hhh��cϮ�_�4T�z:9y��VϜ��+_�ϟ��_���|v5I^YM^^I^ZI�Ir���%���Y�؋}�\0����Gk)�j��XM����:���r��>��O���>w���IN�%��z�n߾*	��\0�h-E�_��&����&?<��$ɩ�\'G.�d`�������kw|���u��UI \0l���Gk)��j����k�s�$Ͽ�<x�{]t�����w\\����%�<����}��$\0��Z���Q�V��kg��*g�����],�ڎ���g~�¡��¿|��$9~2y����9�@ݾ}U\0�g-�Q�I����Z�u\ZB^^I~t*y�[������[����䇕��Jr�d�f�{��n߾*	��\0��.E�����<��c�-�{p�އ���#�u�����Sw|�~�އ�{���{��7������\'	��e-��Zy��>���f���������W%�\0�}���%�c�ݒ@\0�>k	Џ�&��/�vK`��%@?ZK /�vK`��%@?ZK ϫvK`��%@?ZK ?T���YK�h���.--m��������A���־VG�Yw�vj\0�#�\0qz�����\\�����v<�l��{;�\r�v�n\'�r���~p}�?�s?\'�\0��ĩR���mo[o��=��w��ݵ��Zk��mV�A\Z��K�{�n_ݠ�3�Ȑ���M7�488�~��������r�4\0�F���ĵ��;��}�Ci2I�����m�j�x��=-\"A���3n���ݹ�!������/��/מ�Ν;K�R�O8\0�A������={�ޔ�>m5y0p�5vk��:�%����M�p�\'S{��סg�nI/���cz����/��E_�~L����cbbbppp}Y]xS��<���/��dk��yqq1y�{ �l�j�x�,�������f9Î����@�����������X}x/�����Ѣ�pސ>AՋIza\Z\ZJ\'���\\ѧp�BoX^^^���hV��F�r������|��N�����~v�5?�ͪ=H��ܓ}�Vc@݇����������_����G>�����F����#\r��!�@= mt��1]>�>���oDz�����K����tݻP�z��o��R�w�v�~�fiܠu�h<ZGF�eȵc\Z9����K��Ki_��{�С|�dږ>G�U���\'�����������߈��>�333���S	$�q�Ō�	$��u�dI,I ��G8}�}7�W��qrr2}ʊ>�I -�lFGGcj��Q�Z�ȟ�N�����v���7��b�M?����o�8E?ut@\ZB���8P�\0}�ZB�v���\Z߈z�َ�����h�vc��f9¦[�}���u�l���:޺�R�SGg,--��������577711Q�YtR|#�]k�S۬ڃTog<򦛵��ʛ�b�����觎�������W�Y\0��ZB�������>�N�oD�k�#��6�� ��o\r	�vl}u�m�a�1�$��w��E?ut������H�g�#k	�Z^^.�,:)�������6�� �ۭ��f��ٿ֦Gnܸ#�]?N�O��}�@!�%*�7,�7���֑?��Z߽z����̈́���\r�b�\r\Zoos��G+�����(���@ŷ.�7���֑?�����P�����Gk�Y[\'\\���[{���::���\0���������`_|#�il���$���Q��߻��QOK;�3gW�����R�T�Y\0}�ZB��Eq�?eݻ�QO[K �U��)�?�544��oD=m-�,�vK�\Z�)�?�ߢ߈z�Z��j�L��xN��������F��_{��3g���*�8>�S �;*�E1���R���S_?s�j�L��xN��������F������c��3ɷT����W�����4�s�!P�-�񍨧�ݻwz�C����U�<󙩩���::̥	ȟ���oQ�oD=miiid�]�U<�<�2���sssE?ut�K�?�ߢ߈zݞ��9�<��Կ�����x�O\Z�����u�@ŷ(�7�^W�T���{���&�#�u-/�52�r����4:ϥ	ȟ���oQ�oDX\\\\�dqq.I�f�Ə4�-,|�觋�pi��C��[�Q8����{�(IV�57�������?�D�-.M@�\\wT|�b|#�F�R���\Z{���_./ߑ$U��߳�=9�{bb,�]�SD�4�s�!P�-��(2SS�;<��\r]09ye\ZB�~Z��& w�;*�E1��%��yri��C��[�]b��\'�\rȟ���oQ�oDt��B��7 �;*�E1��%�\ny2߀�������FD��*��|��C��[�]b��\'�\rȟ���oQ�oDt��B��7 �;*�E1��%�\ny2߀�������FD��*��|��C��[�]b��\'�\rȟ���oQ�oDt��B��7 �;*�E1��%�\ny2߀�������FD��*��|��C��[�]b��\'�\rȟ���oQ�oDt��B��7 �;*�E1��%�\ny2߀�������FD��;U�<��I�-M3�&�\n߈��$���t�k��9�l�4���^mMB��(��V��FD�l3��u4Ӓs�1�4��4��@��[��]ҥ���R����z�l�q���|�C.\n*�+��%�ʆ�A��]�H��l8�LB�����oŊoDtI�߅����&VH�o��� �@V|+V|#�K�J [��D K��tbH @[\\T|+V|#�K��@2�k�o����f���]|�l����oŊoDt�H�]Zt��ž����YY63��:.\n*�+��%mM����m��W19����E�@ŷb�7\"�$�74j�����؝���yu�5�|�0��c@ߊ߈�-���v��ˢo5��P����k�u\\T|+V|#�K:�@Z��vc3�ϵxKU�g[|ä�/�9ߊ߈����k�O��C����z����oŊoDtI��R��~������\'z-�U�,����I�/�3ߊ߈蒶�J���7�t�����Цo��pJ�\'�v�|��ֶ�FD��*��|��C��[�]b��\'�\rȟ���oQ�oDt��B��7 �;*�E1��%�\ny2߀�������FD��Φ3dppptt4�1<<��{���/..}jDΥ	ȟ���oQ�oDt�m�����v��577W��9�& �;*�E1��A�J��Ϋ��^z���p�\\.�Ԉ�K�?�ߢ߈�믿��sΩ&�k��vzz��\"~.M@�\\wT|�b|#��.����q�UW�J�J�R�?�& �;*�E1��qw�}��瞛N���q?B>\\���������FD7\\q��	���_�4�s�!P�-��nX^^N��_�Kn\\���������FD��*��|��C��[�Q*����������X�Tj��\Z+}Rҧfbbbff�oӀK�;�ߢ߈\n7??�6�i���[��\'�9������II�����_}��铕搢g\r�\\���������FT�r�<55�{���=�rJ�D���iI�����g?����u�@ŷ(�7����ctt�K7���I�su�Wo��˖����G���	ȟ���oQ�oDE���Z����;������y�\\���������FT����ݻ�\\Y����O�ٟ�pç��M�����u�@ŷ(�7��U*�R��̳K+������\'~�cǥ��I\\���������F����������W��k�w2�Z�ڽTu�\r5==]��¥	(����oQ�oD������W[�]W��A�<}:yb%���䑓Ƀ�W�����?�������$�W�{^M�x=��{��5-��V�������E�)\\��������F�����Ç^Y=�^�Cz<IN�I^^M^:���$��\Zx�O�r�ٕ�������R%yr5��7Y�6�	N?qlpp��9�KP\0�ߢ߈�744��gWV��W���z:9y��VϜ��+_�ϟ��_���|v5I^YM^^I^ZI�Ir���%��*���gȟ���oQ�oD�[K�T+���jr����76(����/|�o?����n�Lrj-����#u��ʋ\"� �;*�E1��o-E�_��&����&?<��$ɩ�\'G.�d`�������kw|���u��ʋ\"� �;*�E1��o-E�\\��wa{-y���ד.z�9?��9���$�:X��\n��(B�Y\0��C��[�Q��RD�Z釯�I^�����\'w=��k;��Ο���~����ד����Փgw���u��ʋ�p������E��w\\�	T|�I|#�_�����Z�i\ZB^^I~t*y�[������[����䇕��Jr�d�f�{��n_ByQnii�T*}@�q�\'P�&�(u)bl��~�[<ph�ރ��>��}�������Ǟ�����s��>���<��߿�o��U(��Vu�EQ���������;��*��$��o-��T[��G��A�����vT!�E���)�,����O��kM�Q���1MyQn|||~~��\0���?���5�oD�;�@N���)/�b-//�J�J�R�\0}�՟@�ךlsD�= [��@^PєY]�}��]w�uE�Џ\\�	T|�I�����4��?t|�[K ϫh*�Y�+*�J�TZ^^.�D�~��O��kM2��n��7ܷ��{\0�7�U4�,�SSS333E�Ч\\�	T|�I�����:�s���%��U�}�m��/ݍ�����V���\'�۷�k�)�,����O��kM��@�|d�7_��\0&�K ���m��n�o�mF��f��k���[��l�fg��\0%�0U*���)�(��?���5i=�\r�C��Yv��L�H ?�X�����o�k��ٿb덳��=~��^YΡ�.�ǘe�Eϩ>R.����W*���\n(��?���5i7�l��g9}���ո���Y�ᆷ[�C]k���;��m���?�}����9�����{�NLL������@\\�	T|�ɦ	�V���5�<��6ܲ���=���_�}�-�h��[8�f��^uGh�pCY��tm���q���Z�۔>����sss�r��W0�\"�Q��@t\rt�\rl���,���\0&o$�g�צ�ن�����Z��������}���D���=ɶF���E�)\0\n��O��kM$��[�w�f���[�xgM�}�z���˲Y��o��!�.-n�x2n��`[��9@\\�	T|�I�U����6ܷ6l����z�Z����U�}�k����ƍ��ٔ�}n��2���6�h<�f:2�)zNP\0W6Ѻ����]�1X-F�\"<dI �~�޵��n{]{�	�Y���6Z���s�@\0�W6��%��7l�Ɉ�5��l�c�&���W���?\\����f�[|��#d?�f��=���,gU�e����� E�)\0\n���V��\Z�/��6�D��>��4��y�{��~��R��۾Ňo4�\rw6۷ٗ�q_��e٠zO㩶جٍ�9��c,zNP\0W�j��fo\Z��^�ךl:�Ƈ���,��L�H Oe��������Z���>��uGh���=��ɦ���H[��9@\\��Ć��ɤ���\Z�&YFT�f�G��C�?����e���[�x������U��[[�6έ�1�p��bk�v���芞S\0�՟M��\Z�,������F���~�Ȗ+��ۼ�a���iL�[>��#4���uw6;B���3�,�v�s\n������n#��A��4!������#��o��}r��z����nS�}M���5�M?�L�W�r���f|2p��H�s\n����������H��ު�Z��F���~��-צ�o��ݮ7;�L�����<^\0��՟Ml9�d{�V��#߈�xBP�@r�g-�G��A�߈�>�g�<��)/\n�����&�J �����F#��o-�|WES^\0��՟Ml�@\Z?l�c��[���F������)/\n����O+�~�û�� ��o-�|GES^\0��՟Vj�F[?������c߈�788��k�9�mGyQ\0�\'W��0id�vH|#�_�Tzꩯ�9sX�Q^\0��՟6d��G��l�k���F���������L�-A}g�+###E�)\0\n�%\"P����({��P᭳�H���g�����S\0@KD�����Q����FF��Z��3�c��kb⊹����\0������FT�=g]s&yT�t����LN�=�\0(���@�ׯ�7�BT*����8�I���Z^�kd�]��=E�&\0��%\"P����(������,.�%�!�s�Ə4C.,|��y@a�D*�~=����iٻ����a�C57�������?=�\0(���@�ׯ�7�bU*��驱��������IrP[����������v�s��i�T|�z|#\n���������\0\Z�`r��4�=_\0���@\rDׯ�7\"��_�\0 nZ\"_�߈�S��Y�T|MX|#�KL\0�f�#P�5a�.1U\0��u�@�ׄ�7\"��T n�9_߈�S��Y�T|MX|#�KL\0�f�#P�5a�.1U\0��u�@�ׄ�7\"��T n�9_߈�S��Y�T|MX|#�KL\0�f�#P�5a�.1U\0��u�@�ׄ�7\"��T n�9_߈�S��Y�T|MX|#�KL\0�f�#P�5a�.1U\0��u�@�ׄ�7\"��#S�| X�(_�߈���2�A�^�7�Y�T|\rS|#�K�	$�f��i�\Z+���m�oDt�vH��f\0�8��:��FD��&�o��Ψ,���^,\0�a5\"P�J�.���@\0 p0_w߈�-\'��\0�\'X�T|=S|#�K6}�U�f�;6; \0²D����]Ҙ@\Z?�x�{ \0�����g�oDt�vH�@ ,K*��)��%�@�,K*��)��%[�9��#\0@��R*�*��%[�H�.�{mx\0D����]�\'Zl�l�\ro��\0��jD��k��]�ii�M�M�$ V#_�߈�,�i6�$:\0��,��z��FD��*\0��:G��k��]b�\07����	�oDt��@ܬs*�&,��%�\n\0q�������FD��Φ3dppptt4�1<<��{���/..}j\0�aZ\"_�߈��n���X�ڵknn��S�������FDU*���;�6~\\z�����r��S�������FDg]���sN5�\\{����E�\0t���@�ׯ�7\":.Z�W]uU�T�T*E�\0t���@�ׯ�7\":���>��sө2>>�\'@\0����@�ׯ�7\"��+�XO E�\0t���@�ׯ�7\"�ayy9�*~	/\0������FD��*\0��:G��k��Q8*����������X�Tj��\Z�,}��bbbbff�/����@\rDׯ�7�@��ϧ�n\Z?n��;���#GN���b+}��b���W_}u��9��i@@�D*�~=��\\.OMM�޽��3GO��Ra�/����iZ^^.z�\0-���_�oD�J�����n�⩕�*�����_v�eKKKEO\0��%\"P����XSSSk��u�+u�]w\\~�o=q\0(���@�ׯ�7������}��jE�V}����>]���`Z\"_�߈�R�TJ��3�.����z����ю��k\'\0}NKD�����QQfff���VV_�֮����[bk�R��\r7����tѓ�\"i�T|�z|#*�����[�����r������+ɷO&��L<����o|�ٗ�?��o%�����jr�������G��h�-x��C���=�\0(���@�ׯ�7�����>�����J��Ir�L��j�ҩ��$��?����~r�Ϯ$GO&G_O�*ɓ�ɗ���ڷAN����c���EO\"\0��%\"P����(CCC/{ve��z�쫧����~j��������_�տ��gW�����䥕��$w<��Z9��-��>g P��(�(k)�j��XM����:���r��>��O���>w�Oଡ଼IN�%��z�n_UHy-\0�9�\0���G�T*E�E�R��U�l9���j����J��:yr�K�>00��?��v�>\\��*��{u��\0���G)�J� tG�������.�c�%Ͻ�<�z����]t�Eo?�\'�q�;\'?����C��U�T|�n\0�b P��(����*�,b��\"��J?|�L�R���@^x=���_��w���^8�S_��/��$�O&��<��=��WR�h�e�@�ף���-,,}1H���ꏪ�>U���J�S�s�����Ҏ_�����O&?�$�W�c\'�4��s�u��B*�W7\0m���z���������\"u)bl��~�[<ph�ރ��>��}�������Ǟ�����s��>���<��߿�o��U(��V�h�e�@�ף��%��\"k	�����>�������_��*��{u��\0���GY\\\\)�,b��@��ޭ�^�\0��2@���Q�0zG�M �_T�[Q����2@���Q���w�u�}=o-���z��|u��e�@E٣T*�R����\\������݊��\r@v�k����066V�Y����Cջ���,*�eϞ=ދ�k	dy�j�,�e�={�{�m����vE�� �\0���G���/��E�HOj�Og�k�iv�ž�r�\n�͚�����m�K��h��D �@V�=���|�Tڳg�i�Z����j�.��\'�A�^��nV��ܸ�lw��mZ����{e9��dLַ/zP$�\0���\\.�	$�!���鍅���Ϩ7�s����֫�v�{\Z�lv���\rR�T�f�mz�-o�z�->�z�������I@�,�z�J�2??�&����,������ٴ�7j������S�}�#7��6-Nf��ox��no�a�ǳ�6�9�#3�7�n\06d Pz�Ykp��V뎹n��.-no�ˆ_��f��Rٿ�Ch|dZ���^�d�Gƫ��Y��f�\Zܣ�j���;k���-�v�M�I\"����Ƙe�7Z<b7���xu�9�\0�ң��Z���j��a흵��ظq�7��M��x�v�o�&ː?�x�q��l�����s��G��Ɔ��v����J ��ǆ���Ȓ@�<	�,,J�B3k\r���j���{j�lv�Y�4ٛl��ٷo�?�%�(�l����d|p����e�@�Qh�l�{f�Z�?|�9n��پ�[2@��7ݦ��7���8��5���v�n�>g Pz�Ykp��V�^�����s������m����T��7�sン��=-���ܲ?2^�\0}�2@��(4���~�Zm}�x������U��[[�7��8�پ���솣�x2�n���R�$�H��G����H�j���m���r��l�=�m�L���b��\r�Pwg�#d�k;����EO\"\0�d Pz�Ykp�lVY>[�M��5=t�#l�p7�T3[ؾř�Q[����e|@Z��I@�,J�B3k\r�ͪ�g�l�[�fǟi���ߥͫ��Y��f\"�}X^�\0}�2@��(4�΍3gW�[^�\0}�2@��(4��@��z�����e�@�Qhf-�,��-�n�>g Pz�YK �Q�[^�\0}�2@��(4388��k�9�mգ��\r��,J�B3�R驧�~��aգ��\r��,J�B3����1ә�[��;�_)zP$M��@hf�޽��*��V[������Tѓ�\"i��B3KKK##�z�����1�s51q���\\ѓ�\"i��B{κ�L����ٿ��/z�\0P0M��@h�R�������M�GT����]##�*��)z�\0P0M��@hmqqqt���Ź$9�¯4~��qa�EO\0���#P�:p�@\ZB����$yX�\\ss�)-,�S�S� h��B�Jezzjl�=33��|G�T�T��߳�=9�{bb,�]�d �<%�����������\0!\Z�`r��4�=A\0�&�@\rH �+.��i��B�2���u�@i��[&?\0q��(M}�� n�9�	�o��\0��:G�4a�-���Y��&��e�7��҄ѷL~\0�f�#P�0���@ܬsJF�2���u�@i��[&?\0q��(M}�� n�9�	�o��\0��:G�4a�-���Y��&��e�7��҄ѷL~\0�f�#P�0�VG&�W\0��D(�}k}�dP�W���@�$�a�oUH��6��K	��X�������Rw��\0�8(�}�6��xKU�5���Zދ@8�FJ�D����@\0 p0���om9���\0=��D��L��M�dU�Y��\0��,(=}�1�4~�����@\0��%�g�om\'��8 \0²D��L�-� n�%�g�om��@�\0\0a�J(-}k��ۥq�\r��BX��n���\'Zl�l�\ro{Y���*ѷ6M ;I��O�{Y���*ѷ�|�E���\0βD��L�-���Y��&��e�7��҄ѷL~\0�f�#P�0���@ܬsJF_���M�������hzcxx8�����_\\\\,��\0��4yJ���v�m���j׮]sssE�\Z\0t�&�@I ��J�r�y��ƏK/�txx�\\.}j\0�a�<%��o����s�9��@�������O\n\0:O�G�$��E]�?���R�T�T�>#\0�<M��@�Cw�}��瞛N���q?@�4yJ�?]q��	���n��(	������N~����i��B�2���u�@i���JennnϞ=co\ZO�Y^^.���4yJ���#M�������M7��WcM�\Z�o�����;wn�=j�J%� �H *m�����>�4ZOMM5~�������o��oT듟���ݻ붜������i�J�C�}�a���u��������#GN��6�^<�7�8<<\\���\0z�B�����>褥��4<T����x��Q�C>��OU�<p�@����@������L�gS�Tj���nȘ=j�[�_�=��	�k�\0�E�J�G\ZB�>����j�ؿ��-ď�z�CCC��+zX\0�6	�@-..���}�sss���Gm��կU��o߾�\0�@�F\'\Z�d����6��zU&dxx����H �k߾}�]w]�g�5;;[����<ۑ����ߎ�e@o�@W�R�D`ll���w;?��K7߼~ء����\0m�@�����������lt� պ��7~��_]\r@�@ݞ={�Ʉ����.--m��������l�H�#��������1\0l�BH�����r�\\�����p��߿���\\sM�~Vc�y�7��s��B�\0[ �����K�Ҟ={�X��T*o{��֓�����w����!ix^���_�Z�ȓG�T�:aq\0\0�G�g���4���V�ҥ7��pT-պw���Ї�In���>����\'���_���\0\0��h�cҮn~~>M ��/!���\'��F���&\0de�خ/��\Z9&֤	yqq1��������:|�	dppP��X�\0����vӰ��8�wvv����7����/�xl���$\0=Dؖ��~zppp||�T*MOO��Ҷ������7����Ç�>::Z���]�v������l�\'A��ݻ���;�@>s�\r�����}�\0�E@-..V�(����M �_~�����S�@ +	��J��zNؿ��Ə�I�{�\0�	������s;:�m��{����}��!@$��*��տ��n�H�������\09t�P�C�6H \0]�o߾��088��_���#�Hs�5�=8\0h����;wV�J�v�>�+�O�ر�z����G\0�@\0򰴴444TM>tp���3�V�������B����I \09IC��7�����(�����o�J�۷���VH \0�����~\'d��c��կe�����j���@�@\0r���822R\'���O~�[�7����ݻw�n�o���I \0y+��{����e�]��S���~��^\'�\0#�SSS&�Fccc(���$�\"U*����4����֥�R�411q�M7��\01�@\0\0��H \0\0@~$\0\0 ?\0\0�	\0\0���^;���F�\0\0\0\0IEND�B`�',0);

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

insert  into `act_hi_actinst`(`ID_`,`PROC_DEF_ID_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`ACT_ID_`,`TASK_ID_`,`CALL_PROC_INST_ID_`,`ACT_NAME_`,`ACT_TYPE_`,`ASSIGNEE_`,`START_TIME_`,`END_TIME_`,`DURATION_`,`TENANT_ID_`) values ('13','Leavebill:1:4','5','5','usertask2','14',NULL,'审批【上级领导】','userTask','赵六','2019-10-17 07:39:08.878','2019-10-17 07:43:47.273',278395,''),('17','Leavebill:1:4','5','5','usertask3','18',NULL,'审批【上上级领导】','userTask','王五','2019-10-17 07:43:47.273','2019-10-17 07:44:26.656',39383,''),('21','Leavebill:1:4','5','5','endevent1',NULL,NULL,'End','endEvent',NULL,'2019-10-17 07:44:26.656','2019-10-17 07:44:26.656',0,''),('23','Leavebill:1:4','22','22','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 07:46:04.535','2019-10-17 07:46:04.535',0,''),('25','Leavebill:1:4','22','22','usertask1','26',NULL,'提交申请','userTask','孙七','2019-10-17 07:46:04.535','2019-10-17 07:46:29.028',24493,''),('2503','Leavebill:1:4','57','57','usertask2','2504',NULL,'审批【上级领导】','userTask','赵六','2019-10-17 08:31:01.998','2019-10-17 12:51:38.271',15636273,''),('30','Leavebill:1:4','22','22','endevent1',NULL,NULL,'End','endEvent',NULL,'2019-10-17 07:46:29.028','2019-10-17 07:46:29.028',0,''),('32','Leavebill:1:4','31','31','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 07:47:21.969','2019-10-17 07:47:21.970',1,''),('34','Leavebill:1:4','31','31','usertask1','35',NULL,'提交申请','userTask','孙七','2019-10-17 07:47:21.970','2019-10-17 07:47:39.923',17953,''),('39','Leavebill:1:4','31','31','usertask2','40',NULL,'审批【上级领导】','userTask','赵六','2019-10-17 07:47:39.923','2019-10-17 07:48:13.332',33409,''),('43','Leavebill:1:4','31','31','usertask3','44',NULL,'审批【上上级领导】','userTask','王五','2019-10-17 07:48:13.332','2019-10-17 07:49:11.736',58404,''),('47','Leavebill:1:4','31','31','usertask1','48',NULL,'提交申请','userTask','孙七','2019-10-17 07:49:11.736','2019-10-17 07:50:03.324',51588,''),('50','Leavebill:1:4','31','31','usertask2','51',NULL,'审批【上级领导】','userTask','赵六','2019-10-17 07:50:03.325','2019-10-17 07:50:29.275',25950,''),('5002','Leavebill:1:4','5001','5001','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 10:03:40.115','2019-10-17 10:03:40.129',14,''),('5004','Leavebill:1:4','5001','5001','usertask1','5005',NULL,'提交申请','userTask','孙七','2019-10-17 10:03:40.131',NULL,NULL,''),('53','Leavebill:1:4','31','31','usertask3','54',NULL,'审批【上上级领导】','userTask','王五','2019-10-17 07:50:29.275','2019-10-17 07:51:11.007',41732,''),('56','Leavebill:1:4','31','31','endevent1',NULL,NULL,'End','endEvent',NULL,'2019-10-17 07:51:11.007','2019-10-17 07:51:11.007',0,''),('59','Leavebill:1:4','57','57','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 08:13:29.338','2019-10-17 08:13:29.338',0,''),('6','Leavebill:1:4','5','5','startevent1',NULL,NULL,'Start','startEvent',NULL,'2019-10-17 07:38:34.604','2019-10-17 07:38:34.606',2,''),('61','Leavebill:1:4','57','57','usertask1','62',NULL,'提交申请','userTask','孙七','2019-10-17 08:13:29.338','2019-10-17 08:31:01.998',1052660,''),('7502','Leavebill:1:4','57','57','usertask3','7503',NULL,'审批【上上级领导】','userTask','王五','2019-10-17 12:51:38.271',NULL,NULL,''),('8','Leavebill:1:4','5','5','usertask1','9',NULL,'提交申请','userTask','孙七','2019-10-17 07:38:34.606','2019-10-17 07:39:08.878',34272,'');

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

insert  into `act_hi_comment`(`ID_`,`TYPE_`,`TIME_`,`USER_ID_`,`TASK_ID_`,`PROC_INST_ID_`,`ACTION_`,`MESSAGE_`,`FULL_MSG_`) values ('11','comment','2019-10-17 07:39:08.867','孙七','9','5','AddComment','[提交]请领导同意','[提交]请领导同意'),('16','comment','2019-10-17 07:43:47.263','赵六','14','5','AddComment','[同意]同意','[同意]同意'),('20','comment','2019-10-17 07:44:26.645','王五','18','5','AddComment','[同意]乐意','[同意]乐意'),('2501','comment','2019-10-17 08:31:01.983','孙七','62','57','AddComment','[提交]去刷','[提交]去刷'),('28','comment','2019-10-17 07:46:29.017','孙七','26','22','AddComment','[放弃]算了敲代码好了','[放弃]算了敲代码好了'),('37','comment','2019-10-17 07:47:39.915','孙七','35','31','AddComment','[提交]请领导批准','[提交]请领导批准'),('42','comment','2019-10-17 07:48:13.322','赵六','40','31','AddComment','[同意]可以','[同意]可以'),('46','comment','2019-10-17 07:49:11.725','王五','44','31','AddComment','[驳回]代码敲完没,敲代码去','[驳回]代码敲完没,敲代码去'),('49','comment','2019-10-17 07:50:03.315','孙七','48','31','AddComment','[提交]敲完了，单身20年','[提交]敲完了，单身20年'),('52','comment','2019-10-17 07:50:29.266','赵六','51','31','AddComment','[同意]同意','[同意]同意'),('55','comment','2019-10-17 07:51:10.992','王五','54','31','AddComment','[同意]去吧','[同意]去吧'),('7501','comment','2019-10-17 12:51:38.221','赵六','2504','57','AddComment','[同意]好的','[同意]好的');

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

insert  into `act_hi_identitylink`(`ID_`,`GROUP_ID_`,`TYPE_`,`USER_ID_`,`TASK_ID_`,`PROC_INST_ID_`) values ('10',NULL,'participant','孙七',NULL,'5'),('15',NULL,'participant','赵六',NULL,'5'),('19',NULL,'participant','王五',NULL,'5'),('27',NULL,'participant','孙七',NULL,'22'),('36',NULL,'participant','孙七',NULL,'31'),('41',NULL,'participant','赵六',NULL,'31'),('45',NULL,'participant','王五',NULL,'31'),('5006',NULL,'participant','孙七',NULL,'5001'),('58',NULL,'starter','赵六',NULL,'57'),('63',NULL,'participant','孙七',NULL,'57'),('7504',NULL,'participant','王五',NULL,'57');

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

insert  into `act_hi_procinst`(`ID_`,`PROC_INST_ID_`,`BUSINESS_KEY_`,`PROC_DEF_ID_`,`START_TIME_`,`END_TIME_`,`DURATION_`,`START_USER_ID_`,`START_ACT_ID_`,`END_ACT_ID_`,`SUPER_PROCESS_INSTANCE_ID_`,`DELETE_REASON_`,`TENANT_ID_`,`NAME_`) values ('22','22','Leavebill:13','Leavebill:1:4','2019-10-17 07:46:04.535','2019-10-17 07:46:29.029',24494,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('31','31','Leavebill:14','Leavebill:1:4','2019-10-17 07:47:21.969','2019-10-17 07:51:11.008',229039,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('5','5','Leavebill:12','Leavebill:1:4','2019-10-17 07:38:34.604','2019-10-17 07:44:26.657',352053,NULL,'startevent1','endevent1',NULL,NULL,'',NULL),('5001','5001','Leavebill:16','Leavebill:1:4','2019-10-17 10:03:40.113',NULL,NULL,NULL,'startevent1',NULL,NULL,NULL,'',NULL),('57','57','Leavebill:15','Leavebill:1:4','2019-10-17 08:13:29.338',NULL,NULL,'赵六','startevent1',NULL,NULL,NULL,'',NULL);

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

insert  into `act_hi_taskinst`(`ID_`,`PROC_DEF_ID_`,`TASK_DEF_KEY_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`NAME_`,`PARENT_TASK_ID_`,`DESCRIPTION_`,`OWNER_`,`ASSIGNEE_`,`START_TIME_`,`CLAIM_TIME_`,`END_TIME_`,`DURATION_`,`DELETE_REASON_`,`PRIORITY_`,`DUE_DATE_`,`FORM_KEY_`,`CATEGORY_`,`TENANT_ID_`) values ('14','Leavebill:1:4','usertask2','5','5','审批【上级领导】',NULL,NULL,NULL,'赵六','2019-10-17 07:39:08.878',NULL,'2019-10-17 07:43:47.271',278393,'completed',50,NULL,NULL,NULL,''),('18','Leavebill:1:4','usertask3','5','5','审批【上上级领导】',NULL,NULL,NULL,'王五','2019-10-17 07:43:47.273',NULL,'2019-10-17 07:44:26.654',39381,'completed',50,NULL,NULL,NULL,''),('2504','Leavebill:1:4','usertask2','57','57','审批【上级领导】',NULL,NULL,NULL,'赵六','2019-10-17 08:31:01.998',NULL,'2019-10-17 12:51:38.251',15636253,'completed',50,NULL,NULL,NULL,''),('26','Leavebill:1:4','usertask1','22','22','提交申请',NULL,NULL,NULL,'孙七','2019-10-17 07:46:04.536',NULL,'2019-10-17 07:46:29.025',24489,'completed',50,NULL,NULL,NULL,''),('35','Leavebill:1:4','usertask1','31','31','提交申请',NULL,NULL,NULL,'孙七','2019-10-17 07:47:21.971',NULL,'2019-10-17 07:47:39.921',17950,'completed',50,NULL,NULL,NULL,''),('40','Leavebill:1:4','usertask2','31','31','审批【上级领导】',NULL,NULL,NULL,'赵六','2019-10-17 07:47:39.923',NULL,'2019-10-17 07:48:13.330',33407,'completed',50,NULL,NULL,NULL,''),('44','Leavebill:1:4','usertask3','31','31','审批【上上级领导】',NULL,NULL,NULL,'王五','2019-10-17 07:48:13.332',NULL,'2019-10-17 07:49:11.733',58401,'completed',50,NULL,NULL,NULL,''),('48','Leavebill:1:4','usertask1','31','31','提交申请',NULL,NULL,NULL,'孙七','2019-10-17 07:49:11.736',NULL,'2019-10-17 07:50:03.323',51587,'completed',50,NULL,NULL,NULL,''),('5005','Leavebill:1:4','usertask1','5001','5001','提交申请',NULL,NULL,NULL,'孙七','2019-10-17 10:03:40.135',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,''),('51','Leavebill:1:4','usertask2','31','31','审批【上级领导】',NULL,NULL,NULL,'赵六','2019-10-17 07:50:03.325',NULL,'2019-10-17 07:50:29.274',25949,'completed',50,NULL,NULL,NULL,''),('54','Leavebill:1:4','usertask3','31','31','审批【上上级领导】',NULL,NULL,NULL,'王五','2019-10-17 07:50:29.275',NULL,'2019-10-17 07:51:11.004',41729,'completed',50,NULL,NULL,NULL,''),('62','Leavebill:1:4','usertask1','57','57','提交申请',NULL,NULL,NULL,'孙七','2019-10-17 08:13:29.340',NULL,'2019-10-17 08:31:01.995',1052655,'completed',50,NULL,NULL,NULL,''),('7503','Leavebill:1:4','usertask3','57','57','审批【上上级领导】',NULL,NULL,NULL,'王五','2019-10-17 12:51:38.271',NULL,NULL,NULL,NULL,50,NULL,NULL,NULL,''),('9','Leavebill:1:4','usertask1','5','5','提交申请',NULL,NULL,NULL,'孙七','2019-10-17 07:38:34.607',NULL,'2019-10-17 07:39:08.874',34267,'completed',50,NULL,NULL,NULL,'');

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

insert  into `act_hi_varinst`(`ID_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`TASK_ID_`,`NAME_`,`VAR_TYPE_`,`REV_`,`BYTEARRAY_ID_`,`DOUBLE_`,`LONG_`,`TEXT_`,`TEXT2_`,`CREATE_TIME_`,`LAST_UPDATED_TIME_`) values ('12','5','5',NULL,'outcome','string',2,NULL,NULL,NULL,'同意',NULL,'2019-10-17 07:39:08.871','2019-10-17 07:44:26.658'),('24','22','22',NULL,'username','string',1,NULL,NULL,NULL,'孙七',NULL,'2019-10-17 07:46:04.535','2019-10-17 07:46:29.030'),('2502','57','57',NULL,'outcome','string',1,NULL,NULL,NULL,'同意',NULL,'2019-10-17 08:31:01.992','2019-10-17 12:51:38.241'),('29','22','22',NULL,'outcome','string',0,NULL,NULL,NULL,'放弃',NULL,'2019-10-17 07:46:29.021','2019-10-17 07:46:29.030'),('33','31','31',NULL,'username','string',1,NULL,NULL,NULL,'孙七',NULL,'2019-10-17 07:47:21.969','2019-10-17 07:51:11.009'),('38','31','31',NULL,'outcome','string',5,NULL,NULL,NULL,'同意',NULL,'2019-10-17 07:47:39.918','2019-10-17 07:51:11.009'),('5003','5001','5001',NULL,'username','string',0,NULL,NULL,NULL,'孙七',NULL,'2019-10-17 10:03:40.116','2019-10-17 10:03:40.116'),('60','57','57',NULL,'username','string',0,NULL,NULL,NULL,'孙七',NULL,'2019-10-17 08:13:29.338','2019-10-17 08:13:29.338'),('7','5','5',NULL,'username','string',1,NULL,NULL,NULL,'孙七',NULL,'2019-10-17 07:38:34.604','2019-10-17 07:44:26.658');

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

insert  into `act_re_deployment`(`ID_`,`NAME_`,`CATEGORY_`,`TENANT_ID_`,`DEPLOY_TIME_`) values ('1','请假单001',NULL,'','2019-10-17 07:38:23.490');

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

insert  into `act_ru_identitylink`(`ID_`,`REV_`,`GROUP_ID_`,`TYPE_`,`USER_ID_`,`TASK_ID_`,`PROC_INST_ID_`,`PROC_DEF_ID_`) values ('5006',1,NULL,'participant','孙七',NULL,'5001',NULL),('58',1,NULL,'starter','赵六',NULL,'57',NULL),('63',1,NULL,'participant','孙七',NULL,'57',NULL),('7504',1,NULL,'participant','王五',NULL,'57',NULL);

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

insert  into `act_ru_task`(`ID_`,`REV_`,`EXECUTION_ID_`,`PROC_INST_ID_`,`PROC_DEF_ID_`,`NAME_`,`PARENT_TASK_ID_`,`DESCRIPTION_`,`TASK_DEF_KEY_`,`OWNER_`,`ASSIGNEE_`,`DELEGATION_`,`PRIORITY_`,`CREATE_TIME_`,`DUE_DATE_`,`CATEGORY_`,`SUSPENSION_STATE_`,`TENANT_ID_`,`FORM_KEY_`) values ('5005',1,'5001','5001','Leavebill:1:4','提交申请',NULL,NULL,'usertask1',NULL,'孙七',NULL,50,'2019-10-17 10:03:40.131',NULL,NULL,1,'',NULL),('7503',1,'57','57','Leavebill:1:4','审批【上上级领导】',NULL,NULL,'usertask3',NULL,'王五',NULL,50,'2019-10-17 12:51:38.271',NULL,NULL,1,'',NULL);

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

insert  into `act_ru_variable`(`ID_`,`REV_`,`TYPE_`,`NAME_`,`EXECUTION_ID_`,`PROC_INST_ID_`,`TASK_ID_`,`BYTEARRAY_ID_`,`DOUBLE_`,`LONG_`,`TEXT_`,`TEXT2_`) values ('2502',2,'string','outcome','57','57',NULL,NULL,NULL,NULL,'同意',NULL),('5003',1,'string','username','5001','5001',NULL,NULL,NULL,NULL,'孙七',NULL),('60',1,'string','username','57','57',NULL,NULL,NULL,NULL,'孙七',NULL);

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

insert  into `bus_customer`(`id`,`customername`,`zip`,`address`,`telephone`,`connectionperson`,`phone`,`bank`,`account`,`email`,`fax`,`available`) values (1,'小张超市','111','武汉','027-9123131','张大明','13812312312321312','中国银行','654431331343413','213123@sina.com','430000',1),(2,'小明超市','222','深圳','0755-9123131','张小明','13812312312321312','中国银行','654431331343413','213123@sina.com','430000',1),(3,'快七超市','430000','武汉','027-11011011','雷生','13434134131','招商银行','6543123341334133','6666@66.com','545341',1),(4,'苏宁小店','232','广州','020-4324','孟非','2312312','中国银行','241243432423','112@qq.com','32sdff',1);

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

insert  into `bus_goods`(`id`,`goodsname`,`produceplace`,`size`,`goodspackage`,`productcode`,`promitcode`,`description`,`price`,`number`,`dangernum`,`goodsimg`,`available`,`providerid`) values (1,'娃哈哈','武汉','120ML','瓶','PH12345','PZ1234','小孩子都爱的',2,1000,10,'img/哇哈哈.jpg',1,3),(2,'旺旺雪饼[小包]','仙桃','包','袋','PH12312312','PZ12312','好吃不上火',4,1000,10,'img/旺旺雪饼.jpg',1,1),(3,'旺旺大礼包','仙桃','盒','盒','11','11','111',28,980,100,'img/旺旺大礼包.jpg',1,1),(4,'娃哈哈','武汉','200ML','瓶','11','111','12321',3,980,10,'img/哇哈哈.jpg',1,3),(5,'娃哈哈','武汉','300ML','瓶','1234','12321','22221111',3,1000,100,'img/哇哈哈.jpg',1,3),(15,'旺旺脆冰冰','武汉','120ML','袋','PH12345','PZ1234','小孩子都爱的',1,1050,100,'2019-10-11/201910112149380119466.jpg',1,1),(16,'旺子牛奶','武汉','120ML','瓶','1234','12321','小孩子都爱的',3,970,100,'2019-10-11/201910111149295438339.jpg',1,1),(17,'旺旺仙贝','武汉','520g','袋','1234','PZ1234','小孩子都爱的',20,1000,100,'2019-10-11/201910111149418709450.jpg',1,1),(18,'旺子小馒头','武汉','500g','袋','PH12345','12321','小孩子都爱的',20,1000,100,'2019-10-11/201910111150474971489.jpg',1,1),(19,'达利园八宝粥','武汉','300ML','瓶','PH12345','12321','小孩子都爱的',4.5,970,100,'2019-10-11/201910111615581974825.jpg',1,2),(20,'达利园派','武汉','500g','袋','PH12345','PZ1234','小孩子都爱的',15,1000,100,'2019-10-11/201910111616422425764.jpg',1,2);

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

insert  into `bus_inport`(`id`,`paytype`,`inporttime`,`operateperson`,`number`,`remark`,`inportprice`,`providerid`,`goodsid`) values (1,'微信','2018-05-07 00:00:00','张三',100,'备注',3.5,3,1),(2,'支付宝','2018-05-07 00:00:00','张三',1000,'无',2.5,3,1),(3,'银联','2018-05-07 00:00:00','张三',100,'1231',111,3,3),(4,'银联','2018-05-07 00:00:00','张三',1000,'无',2,3,1),(5,'银联','2018-05-07 00:00:00','张三',100,'无',1,3,1),(6,'银联','2018-05-07 00:00:00','张三',100,'1231',2.5,1,2),(8,'支付宝','2018-05-07 00:00:00','张三',100,'',1,3,1),(10,'支付宝','2018-08-07 17:17:57','超级管理员',100,'sadfasfdsa',1.5,3,1),(11,'支付宝','2018-09-17 16:12:25','超级管理员',21,'21',21,1,3),(12,'微信','2018-12-25 16:48:24','超级管理员',100,'123213213',12321321,3,1),(18,'支付宝','2019-10-11 11:14:40','雷军',100,'无',100,1,15);

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

insert  into `bus_outport`(`id`,`providerid`,`paytype`,`outputtime`,`operateperson`,`outportprice`,`number`,`remark`,`goodsid`) values (1,3,'微信','2019-08-16 08:19:50','超级管理员',12321321.00,1,'',1),(2,3,'微信','2019-08-16 08:26:54','超级管理员',12321321.00,11,'11',1),(11,1,'支付宝','2019-10-11 11:42:53','雷军',100.00,50,'',15);

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

insert  into `bus_provider`(`id`,`providername`,`zip`,`address`,`telephone`,`connectionperson`,`phone`,`bank`,`account`,`email`,`fax`,`available`) values (1,'旺旺食品','434000','仙桃','0728-4124312','小明','13413441141','中国农业银行','654124345131','12312321@sina.com','5123123',1),(2,'达利园食品','430000','汉川','0728-4124312','大明','13413441141','中国农业银行','654124345131','12312321@sina.com','5123123',1),(3,'娃哈哈集团','513131','杭州','21312','小晨','12312','建设银行','512314141541','123131','312312',1);

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

insert  into `bus_sales`(`id`,`customerid`,`paytype`,`salestime`,`operateperson`,`number`,`remark`,`saleprice`,`goodsid`) values (1,1,'支付宝','2019-10-12 12:58:31','雷军',50,'312','50.00',15),(2,2,'支付宝','2019-10-18 02:08:57','雷军',30,'无','100.00',16),(3,3,'支付宝','2019-10-18 02:09:14','雷军',30,'ds','100.00',19),(4,4,'支付宝','2019-10-18 02:09:42','雷军',20,'haha','70.00',4),(5,2,'支付宝','2019-10-18 02:11:49','雷军',20,'','31.00',3);

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

insert  into `bus_salesback`(`id`,`customerid`,`paytype`,`salesbacktime`,`salebackprice`,`operateperson`,`number`,`remark`,`goodsid`) values (1,1,'支付宝','2019-10-12 14:09:38',50.00,'雷军',50,'无',15);

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `open` int(11) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `available` int(11) DEFAULT NULL COMMENT '状态【0不可用1可用】',
  `ordernum` int(11) DEFAULT NULL COMMENT '排序码【为了调事显示顺序】',
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_dept` */

insert  into `sys_dept`(`id`,`pid`,`title`,`open`,`remark`,`address`,`available`,`ordernum`,`createtime`) values (1,0,'总经办',1,'大BOSS','深圳',1,1,'2019-04-10 14:06:32'),(2,1,'销售部',0,'程序员屌丝','武汉',1,2,'2019-04-10 14:06:32'),(3,1,'运营部',0,'无','武汉',1,3,'2019-04-10 14:06:32'),(4,1,'生产部',0,'无','武汉',1,4,'2019-04-10 14:06:32'),(5,2,'销售一部',0,'销售一部','武汉',1,5,'2019-04-10 14:06:32'),(6,2,'销售二部',0,'销售二部','武汉',1,6,'2019-04-10 14:06:32'),(7,3,'运营一部',0,'运营一部','武汉',1,7,'2019-04-10 14:06:32'),(8,2,'销售三部',0,'销售三部','11',1,8,'2019-04-10 14:06:32'),(9,2,'销售四部',0,'销售四部','222',1,9,'2019-04-10 14:06:32'),(10,2,'销售五部',0,'销售五部','33',1,10,'2019-04-10 14:06:32'),(18,4,'生产一部',0,'生产食品','武汉',1,11,'2019-04-13 09:49:38'),(20,4,'dsadsadas',0,'dsa','dsa',1,13,'2019-10-08 05:14:51'),(21,4,'qwrr',0,'rwq','rqw',1,14,'2019-10-08 05:35:50'),(22,1,'电商部',0,'雷军','武汉',1,15,'2019-10-08 05:53:44'),(23,22,'电商一部',0,'2312','武汉1号',1,16,'2019-10-08 05:55:23'),(31,22,'电商二部',0,'小米有品','武汉',1,17,'2019-10-08 06:14:46'),(33,22,'dsa',0,'dasdsadsa','dassad',1,18,'2019-10-08 07:17:16'),(34,22,'asd',0,'as','sdas',1,19,'2019-10-08 08:40:55'),(35,22,'dsa',0,'das','das',1,20,'2019-10-08 08:41:13'),(36,22,'fdf',0,'das','dsa',1,21,'2019-10-08 08:41:32');

/*Table structure for table `sys_leavebill` */

DROP TABLE IF EXISTS `sys_leavebill`;

CREATE TABLE `sys_leavebill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `days` double(255,0) DEFAULT NULL,
  `leavetime` datetime DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL COMMENT '1,新建  2，已提交   3，审批中  4，审批完成',
  `userid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `sys_leavebill` */

insert  into `sys_leavebill`(`id`,`title`,`content`,`days`,`leavetime`,`state`,`userid`) values (12,'【孙七】的请假单','回家过年',3,'2019-10-16 16:00:00','2',5),(13,'【孙七】的请假单','去玩',3,'2019-10-16 16:00:00','3',5),(14,'【孙七】的请假单','出去看看世界',3,'2019-10-16 16:00:00','2',5),(15,'【孙七】的请假单','去耍',3,'2019-10-17 16:00:00','1',5),(16,'【孙七】的请假单','搞事情',5,'2019-10-16 16:00:00','1',5);

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

insert  into `sys_loginfo`(`id`,`loginname`,`loginip`,`logintime`) values (2,'超级管理员-system','127.0.0.1','2018-12-21 16:54:52'),(3,'超级管理员-system','127.0.0.1','2018-12-21 16:55:15'),(4,'超级管理员-system','127.0.0.1','2018-12-21 17:29:22'),(5,'超级管理员-system','127.0.0.1','2018-12-22 09:05:22'),(6,'超级管理员-system','127.0.0.1','2018-12-22 09:20:43'),(7,'超级管理员-system','127.0.0.1','2018-12-22 09:25:40'),(8,'超级管理员-system','127.0.0.1','2018-12-22 09:27:11'),(9,'超级管理员-system','127.0.0.1','2018-12-22 09:29:58'),(10,'超级管理员-system','127.0.0.1','2018-12-22 09:36:49'),(11,'超级管理员-system','127.0.0.1','2018-12-22 09:46:56'),(12,'超级管理员-system','127.0.0.1','2018-12-22 09:48:29'),(13,'超级管理员-system','127.0.0.1','2018-12-22 09:49:13'),(14,'超级管理员-system','127.0.0.1','2018-12-22 09:49:57'),(15,'超级管理员-system','127.0.0.1','2018-12-22 09:57:46'),(16,'超级管理员-system','127.0.0.1','2018-12-22 10:21:53'),(17,'超级管理员-system','127.0.0.1','2018-12-22 10:38:25'),(18,'超级管理员-system','127.0.0.1','2018-12-22 10:49:21'),(19,'超级管理员-system','127.0.0.1','2018-12-22 14:01:42'),(20,'超级管理员-system','127.0.0.1','2018-12-22 14:19:48'),(21,'超级管理员-system','127.0.0.1','2018-12-22 14:45:29'),(22,'超级管理员-system','127.0.0.1','2018-12-22 15:58:05'),(23,'超级管理员-system','127.0.0.1','2018-12-22 16:40:53'),(24,'超级管理员-system','127.0.0.1','2018-12-22 17:12:01'),(25,'超级管理员-system','127.0.0.1','2018-12-24 09:19:15'),(26,'超级管理员-system','127.0.0.1','2018-12-24 09:37:28'),(27,'超级管理员-system','127.0.0.1','2018-12-24 09:46:51'),(28,'超级管理员-system','127.0.0.1','2018-12-24 09:50:40'),(29,'超级管理员-system','127.0.0.1','2018-12-24 09:52:52'),(30,'超级管理员-system','127.0.0.1','2018-12-24 10:00:26'),(31,'超级管理员-system','127.0.0.1','2018-12-24 10:10:58'),(32,'超级管理员-system','127.0.0.1','2018-12-24 10:21:28'),(33,'超级管理员-system','127.0.0.1','2018-12-24 11:22:27'),(34,'超级管理员-system','127.0.0.1','2018-12-24 11:35:28'),(35,'超级管理员-system','127.0.0.1','2018-12-24 14:05:28'),(36,'超级管理员-system','127.0.0.1','2018-12-24 15:16:29'),(37,'李四-ls','127.0.0.1','2018-12-24 15:16:50'),(38,'王五-ww','127.0.0.1','2018-12-24 15:17:36'),(39,'赵六-zl','127.0.0.1','2018-12-24 15:17:47'),(40,'孙七-sq','127.0.0.1','2018-12-24 15:17:58'),(41,'刘八-lb','127.0.0.1','2018-12-24 15:18:09'),(42,'超级管理员-system','127.0.0.1','2018-12-24 15:34:59'),(43,'超级管理员-system','127.0.0.1','2018-12-24 15:35:09'),(44,'刘八-lb','127.0.0.1','2018-12-24 15:36:09'),(45,'刘八-lb','127.0.0.1','2018-12-24 15:42:58'),(46,'刘八-lb','127.0.0.1','2018-12-24 15:43:04'),(47,'超级管理员-system','127.0.0.1','2018-12-24 15:46:01'),(48,'超级管理员-system','127.0.0.1','2018-12-24 17:03:54'),(49,'超级管理员-system','127.0.0.1','2018-12-24 17:26:32'),(50,'超级管理员-system','127.0.0.1','2018-12-25 09:07:42'),(51,'超级管理员-system','127.0.0.1','2018-12-25 09:16:27'),(52,'超级管理员-system','127.0.0.1','2018-12-25 09:59:03'),(53,'超级管理员-system','127.0.0.1','2018-12-25 10:05:13'),(54,'超级管理员-system','127.0.0.1','2018-12-25 10:05:47'),(55,'超级管理员-system','127.0.0.1','2018-12-25 10:11:17'),(56,'超级管理员-system','127.0.0.1','2018-12-25 10:14:06'),(57,'超级管理员-system','127.0.0.1','2018-12-25 10:36:16'),(58,'超级管理员-system','127.0.0.1','2018-12-25 14:17:21'),(59,'超级管理员-system','127.0.0.1','2018-12-25 14:20:00'),(60,'超级管理员-system','127.0.0.1','2018-12-25 14:34:22'),(61,'超级管理员-system','127.0.0.1','2018-12-25 14:34:27'),(62,'超级管理员-system','127.0.0.1','2018-12-25 14:38:37'),(63,'超级管理员-system','127.0.0.1','2018-12-25 14:50:37'),(64,'超级管理员-system','127.0.0.1','2018-12-25 16:01:35'),(65,'超级管理员-system','127.0.0.1','2018-12-25 16:25:28'),(66,'超级管理员-system','127.0.0.1','2018-12-25 16:27:37'),(67,'超级管理员-system','127.0.0.1','2018-12-25 16:28:28'),(68,'超级管理员-system','127.0.0.1','2018-12-25 16:44:02'),(69,'超级管理员-system','127.0.0.1','2018-12-25 16:47:55'),(70,'超级管理员-system','127.0.0.1','2018-12-28 15:59:34'),(71,'超级管理员-system','127.0.0.1','2018-12-28 17:27:16'),(72,'超级管理员-system','127.0.0.1','2018-12-28 17:29:40'),(73,'超级管理员-system','127.0.0.1','2018-12-28 17:51:10'),(74,'超级管理员-system','127.0.0.1','2019-04-15 17:05:02'),(75,'超级管理员-system','127.0.0.1','2019-04-15 17:05:12'),(76,'超级管理员-system','127.0.0.1','2019-04-15 17:10:22'),(77,'刘八-lb','127.0.0.1','2019-04-15 17:11:45'),(78,'刘八-lb','127.0.0.1','2019-04-15 17:28:50'),(79,'超级管理员-system','127.0.0.1','2019-04-15 17:29:13'),(80,'刘八-lb','127.0.0.1','2019-04-15 17:30:59'),(81,'刘八-lb','127.0.0.1','2019-04-15 17:32:42'),(82,'刘八-lb','127.0.0.1','2019-04-15 17:33:48'),(83,'刘八-lb','127.0.0.1','2019-04-15 17:34:17'),(84,'超级管理员-system','127.0.0.1','2019-04-15 17:36:40'),(85,'超级管理员-system','127.0.0.1','2019-04-15 17:47:21'),(86,'超级管理员-system','127.0.0.1','2019-04-15 17:54:10'),(87,'超级管理员-system','127.0.0.1','2019-04-15 17:55:52'),(88,'超级管理员-system','127.0.0.1','2019-04-16 09:26:01'),(89,'超级管理员-system','127.0.0.1','2019-04-16 09:26:25'),(90,'超级管理员-system','127.0.0.1','2019-04-16 09:46:54'),(91,'超级管理员-system','127.0.0.1','2019-04-16 10:07:48'),(92,'超级管理员-system','127.0.0.1','2019-04-16 10:10:30'),(93,'超级管理员-system','127.0.0.1','2019-04-16 10:14:29'),(94,'超级管理员-system','127.0.0.1','2019-04-16 10:15:04'),(95,'超级管理员-system','127.0.0.1','2019-04-16 10:15:58'),(96,'超级管理员-system','127.0.0.1','2019-04-16 10:28:14'),(97,'超级管理员-system','127.0.0.1','2019-04-16 10:32:42'),(98,'超级管理员-system','127.0.0.1','2019-04-16 10:33:03'),(99,'超级管理员-system','127.0.0.1','2019-04-16 11:02:01'),(100,'超级管理员-system','127.0.0.1','2019-04-16 11:03:09'),(101,'超级管理员-system','127.0.0.1','2019-04-16 11:13:42'),(102,'超级管理员-system','127.0.0.1','2019-04-16 11:24:55'),(104,'超级管理员-system','127.0.0.1','2019-08-14 01:11:34'),(105,'超级管理员-system','127.0.0.1','2019-08-14 01:24:03'),(106,'李四-ls','127.0.0.1','2019-08-14 01:25:47'),(107,'李四-ls','127.0.0.1','2019-08-14 01:26:41'),(108,'孙七-sq','127.0.0.1','2019-08-14 01:28:22'),(109,'刘八-lb','127.0.0.1','2019-08-14 01:28:32'),(110,'超级管理员-system','127.0.0.1','2019-08-14 01:46:18'),(111,'超级管理员-system','127.0.0.1','2019-08-14 02:18:44'),(112,'超级管理员-system','127.0.0.1','2019-08-14 02:32:06'),(113,'李四-ls','127.0.0.1','2019-08-14 03:00:19'),(114,'李四-ls','127.0.0.1','2019-08-14 03:00:56'),(115,'李四-ls','127.0.0.1','2019-08-14 03:01:31'),(116,'李四-ls','127.0.0.1','2019-08-14 03:01:39'),(117,'李四-ls','127.0.0.1','2019-08-14 03:02:25'),(118,'李四-ls','127.0.0.1','2019-08-14 03:04:57'),(119,'李四-ls','127.0.0.1','2019-08-14 03:07:19'),(120,'李四-ls','127.0.0.1','2019-08-14 03:07:54'),(121,'超级管理员-system','127.0.0.1','2019-08-14 03:13:06'),(122,'李四-ls','127.0.0.1','2019-08-14 03:14:46'),(123,'超级管理员-system','127.0.0.1','2019-08-14 06:03:47'),(124,'超级管理员-system','127.0.0.1','2019-08-14 07:20:12'),(125,'超级管理员-system','127.0.0.1','2019-08-14 07:23:05'),(126,'超级管理员-system','127.0.0.1','2019-08-14 07:25:30'),(127,'超级管理员-system','127.0.0.1','2019-08-14 07:26:34'),(128,'超级管理员-system','127.0.0.1','2019-08-14 07:27:22'),(129,'超级管理员-system','127.0.0.1','2019-08-14 07:27:51'),(130,'超级管理员-system','127.0.0.1','2019-08-14 08:22:05'),(131,'超级管理员-system','127.0.0.1','2019-08-14 08:43:53'),(132,'超级管理员-system','127.0.0.1','2019-08-14 08:45:55'),(133,'超级管理员-system','127.0.0.1','2019-08-14 08:47:13'),(134,'超级管理员-system','127.0.0.1','2019-08-14 09:35:20'),(135,'超级管理员-system','127.0.0.1','2019-08-14 09:41:02'),(136,'超级管理员-system','127.0.0.1','2019-08-14 09:44:04'),(137,'超级管理员-system','127.0.0.1','2019-08-14 09:50:27'),(138,'超级管理员-system','127.0.0.1','2019-08-14 09:56:57'),(139,'超级管理员-system','127.0.0.1','2019-08-14 09:59:02'),(140,'超级管理员-system','127.0.0.1','2019-08-16 01:05:37'),(141,'超级管理员-system','127.0.0.1','2019-08-16 02:01:44'),(142,'超级管理员-system','127.0.0.1','2019-08-16 02:05:57'),(143,'超级管理员-system','127.0.0.1','2019-08-16 02:07:04'),(144,'超级管理员-system','127.0.0.1','2019-08-16 02:20:02'),(145,'超级管理员-system','127.0.0.1','2019-08-16 02:20:20'),(146,'超级管理员-system','127.0.0.1','2019-08-16 02:21:42'),(147,'超级管理员-system','127.0.0.1','2019-08-16 03:37:37'),(148,'超级管理员-system','127.0.0.1','2019-08-16 03:52:40'),(149,'超级管理员-system','127.0.0.1','2019-08-16 03:59:37'),(150,'超级管理员-system','127.0.0.1','2019-08-16 06:11:45'),(151,'超级管理员-system','127.0.0.1','2019-08-16 06:23:27'),(152,'超级管理员-system','127.0.0.1','2019-08-16 06:50:31'),(153,'超级管理员-system','127.0.0.1','2019-08-16 06:54:49'),(154,'超级管理员-system','127.0.0.1','2019-08-16 07:00:48'),(155,'超级管理员-system','127.0.0.1','2019-08-16 07:01:18'),(156,'超级管理员-system','127.0.0.1','2019-08-16 07:03:35'),(157,'超级管理员-system','127.0.0.1','2019-08-16 07:09:55'),(158,'超级管理员-system','127.0.0.1','2019-08-16 07:46:09'),(159,'超级管理员-system','127.0.0.1','2019-08-16 08:17:59'),(160,'超级管理员-system','127.0.0.1','2019-08-16 08:22:29'),(161,'超级管理员-system','127.0.0.1','2019-08-16 08:23:32'),(162,'超级管理员-system','127.0.0.1','2019-08-16 08:26:48'),(163,'超级管理员-system','127.0.0.1','2019-08-16 08:31:19'),(164,'超级管理员-system','127.0.0.1','2019-08-16 08:55:36'),(169,'雷军','0:0:0:0:0:0:0:1','2019-10-07 13:34:46'),(170,'雷军','0:0:0:0:0:0:0:1','2019-10-07 14:40:25'),(171,'雷军','0:0:0:0:0:0:0:1','2019-10-07 14:41:36'),(172,'雷军','0:0:0:0:0:0:0:1','2019-10-07 14:45:25'),(173,'雷军','0:0:0:0:0:0:0:1','2019-10-07 14:48:02'),(174,'雷军','0:0:0:0:0:0:0:1','2019-10-07 14:56:40'),(175,'雷军','0:0:0:0:0:0:0:1','2019-10-07 15:10:24'),(176,'雷军','0:0:0:0:0:0:0:1','2019-10-08 03:04:26'),(177,'雷军','0:0:0:0:0:0:0:1','2019-10-08 03:18:43'),(178,'雷军','0:0:0:0:0:0:0:1','2019-10-08 04:53:38'),(179,'雷军','0:0:0:0:0:0:0:1','2019-10-08 04:56:08'),(180,'雷军','0:0:0:0:0:0:0:1','2019-10-08 05:01:35'),(181,'雷军','0:0:0:0:0:0:0:1','2019-10-08 05:53:07'),(182,'雷军','0:0:0:0:0:0:0:1','2019-10-08 05:54:22'),(183,'雷军','0:0:0:0:0:0:0:1','2019-10-08 07:10:19'),(184,'雷军','0:0:0:0:0:0:0:1','2019-10-08 08:17:09'),(185,'雷军','0:0:0:0:0:0:0:1','2019-10-08 09:24:55'),(186,'雷军','0:0:0:0:0:0:0:1','2019-10-08 10:28:16'),(187,'雷军','0:0:0:0:0:0:0:1','2019-10-09 02:29:21'),(188,'雷军','0:0:0:0:0:0:0:1','2019-10-09 03:51:55'),(189,'雷军','0:0:0:0:0:0:0:1','2019-10-09 03:55:26'),(190,'雷军','0:0:0:0:0:0:0:1','2019-10-09 03:57:38'),(191,'雷军','0:0:0:0:0:0:0:1','2019-10-09 06:03:11'),(192,'雷军','0:0:0:0:0:0:0:1','2019-10-09 09:22:54'),(193,'雷军','0:0:0:0:0:0:0:1','2019-10-09 14:40:59'),(194,'雷军','0:0:0:0:0:0:0:1','2019-10-09 15:52:10'),(195,'雷军','0:0:0:0:0:0:0:1','2019-10-09 16:38:23'),(196,'罗永浩','0:0:0:0:0:0:0:1','2019-10-09 17:22:44'),(197,'雷军','0:0:0:0:0:0:0:1','2019-10-10 04:21:29'),(198,'雷军','0:0:0:0:0:0:0:1','2019-10-10 06:36:11'),(199,'罗永浩','0:0:0:0:0:0:0:1','2019-10-10 06:39:23'),(200,'雷军','0:0:0:0:0:0:0:1','2019-10-10 06:40:42'),(201,'刘八','0:0:0:0:0:0:0:1','2019-10-10 06:43:39'),(202,'罗永浩','0:0:0:0:0:0:0:1','2019-10-10 06:43:57'),(203,'雷军','0:0:0:0:0:0:0:1','2019-10-10 06:44:58'),(204,'雷军','0:0:0:0:0:0:0:1','2019-10-10 07:28:58'),(205,'罗永浩','0:0:0:0:0:0:0:1','2019-10-10 07:29:14'),(206,'罗永浩','0:0:0:0:0:0:0:1','2019-10-10 08:06:08'),(207,'雷军','0:0:0:0:0:0:0:1','2019-10-10 08:12:39'),(208,'罗永浩','0:0:0:0:0:0:0:1','2019-10-10 08:12:48'),(209,'雷军','0:0:0:0:0:0:0:1','2019-10-10 08:18:47'),(210,'雷军','0:0:0:0:0:0:0:1','2019-10-10 08:58:44'),(211,'罗永浩','0:0:0:0:0:0:0:1','2019-10-10 09:02:37'),(212,'雷军','0:0:0:0:0:0:0:1','2019-10-10 11:50:24'),(213,'雷军','0:0:0:0:0:0:0:1','2019-10-10 11:52:43'),(214,'雷军','0:0:0:0:0:0:0:1','2019-10-10 12:36:53'),(215,'雷军','0:0:0:0:0:0:0:1','2019-10-10 13:45:42'),(216,'雷军','0:0:0:0:0:0:0:1','2019-10-10 14:47:15'),(217,'雷军','0:0:0:0:0:0:0:1','2019-10-11 01:39:36'),(218,'雷军','0:0:0:0:0:0:0:1','2019-10-11 01:57:36'),(219,'雷军','0:0:0:0:0:0:0:1','2019-10-11 02:07:39'),(220,'雷军','0:0:0:0:0:0:0:1','2019-10-11 03:17:13'),(221,'雷军','0:0:0:0:0:0:0:1','2019-10-11 03:26:11'),(222,'雷军','0:0:0:0:0:0:0:1','2019-10-11 03:30:39'),(223,'雷军','0:0:0:0:0:0:0:1','2019-10-11 03:36:34'),(224,'雷军','0:0:0:0:0:0:0:1','2019-10-11 03:43:50'),(225,'雷军','0:0:0:0:0:0:0:1','2019-10-11 06:03:27'),(226,'雷军','0:0:0:0:0:0:0:1','2019-10-11 06:05:17'),(227,'雷军','0:0:0:0:0:0:0:1','2019-10-11 06:07:31'),(228,'雷军','0:0:0:0:0:0:0:1','2019-10-11 06:09:16'),(229,'雷军','0:0:0:0:0:0:0:1','2019-10-11 06:15:55'),(230,'雷军','127.0.0.1','2019-10-11 06:17:13'),(231,'雷军','0:0:0:0:0:0:0:1','2019-10-11 07:55:07'),(232,'雷军','0:0:0:0:0:0:0:1','2019-10-11 07:59:14'),(233,'雷军','0:0:0:0:0:0:0:1','2019-10-11 08:06:44'),(234,'雷军','0:0:0:0:0:0:0:1','2019-10-11 08:09:35'),(235,'雷军','0:0:0:0:0:0:0:1','2019-10-11 08:11:50'),(236,'雷军','0:0:0:0:0:0:0:1','2019-10-11 08:19:34'),(237,'雷军','0:0:0:0:0:0:0:1','2019-10-11 08:26:14'),(238,'雷军','127.0.0.1','2019-10-11 08:31:38'),(239,'雷军','0:0:0:0:0:0:0:1','2019-10-11 08:35:28'),(240,'雷军','0:0:0:0:0:0:0:1','2019-10-11 08:39:25'),(241,'雷军','0:0:0:0:0:0:0:1','2019-10-11 09:04:42'),(242,'雷军','0:0:0:0:0:0:0:1','2019-10-11 09:14:33'),(243,'雷军','0:0:0:0:0:0:0:1','2019-10-11 09:16:04'),(244,'雷军','0:0:0:0:0:0:0:1','2019-10-11 11:13:43'),(245,'雷军','127.0.0.1','2019-10-11 11:34:03'),(246,'雷军','0:0:0:0:0:0:0:1','2019-10-11 11:36:58'),(247,'雷军','0:0:0:0:0:0:0:1','2019-10-11 11:42:35'),(248,'雷军','0:0:0:0:0:0:0:1','2019-10-11 12:06:17'),(249,'雷军','0:0:0:0:0:0:0:1','2019-10-11 13:20:18'),(250,'雷军','0:0:0:0:0:0:0:1','2019-10-11 13:30:28'),(251,'雷军','0:0:0:0:0:0:0:1','2019-10-11 13:36:59'),(252,'雷军','0:0:0:0:0:0:0:1','2019-10-11 14:41:08'),(253,'雷军','0:0:0:0:0:0:0:1','2019-10-11 14:55:19'),(254,'雷军','0:0:0:0:0:0:0:1','2019-10-11 14:57:27'),(255,'雷军','0:0:0:0:0:0:0:1','2019-10-11 15:03:10'),(256,'雷军','0:0:0:0:0:0:0:1','2019-10-11 15:09:57'),(257,'雷军','127.0.0.1','2019-10-11 15:14:29'),(258,'雷军','0:0:0:0:0:0:0:1','2019-10-11 15:15:08'),(259,'雷军','0:0:0:0:0:0:0:1','2019-10-11 15:19:29'),(260,'雷军','0:0:0:0:0:0:0:1','2019-10-12 02:36:43'),(261,'雷军','0:0:0:0:0:0:0:1','2019-10-12 02:39:18'),(262,'雷军','0:0:0:0:0:0:0:1','2019-10-12 02:43:51'),(263,'雷军','0:0:0:0:0:0:0:1','2019-10-12 02:44:21'),(264,'雷军','0:0:0:0:0:0:0:1','2019-10-12 02:46:50'),(265,'雷军','0:0:0:0:0:0:0:1','2019-10-12 02:50:11'),(266,'雷军','0:0:0:0:0:0:0:1','2019-10-12 02:51:40'),(267,'雷军','0:0:0:0:0:0:0:1','2019-10-12 03:04:25'),(268,'雷军','0:0:0:0:0:0:0:1','2019-10-12 03:51:47'),(269,'雷军','0:0:0:0:0:0:0:1','2019-10-12 03:57:02'),(270,'雷军','0:0:0:0:0:0:0:1','2019-10-12 04:07:12'),(271,'雷军','0:0:0:0:0:0:0:1','2019-10-12 04:57:05'),(272,'雷军','0:0:0:0:0:0:0:1','2019-10-12 06:14:31'),(273,'雷军','0:0:0:0:0:0:0:1','2019-10-12 06:23:37'),(274,'雷军','0:0:0:0:0:0:0:1','2019-10-12 06:28:43'),(275,'雷军','127.0.0.1','2019-10-12 06:30:59'),(276,'雷军','0:0:0:0:0:0:0:1','2019-10-12 06:40:09'),(277,'雷军','0:0:0:0:0:0:0:1','2019-10-12 06:48:35'),(278,'雷军','0:0:0:0:0:0:0:1','2019-10-12 07:01:14'),(279,'雷军','0:0:0:0:0:0:0:1','2019-10-12 07:10:08'),(280,'雷军','0:0:0:0:0:0:0:1','2019-10-12 07:10:56'),(281,'雷军','127.0.0.1','2019-10-12 07:12:54'),(282,'雷军','0:0:0:0:0:0:0:1','2019-10-12 07:20:26'),(283,'雷军','0:0:0:0:0:0:0:1','2019-10-12 08:01:39'),(284,'雷军','0:0:0:0:0:0:0:1','2019-10-12 08:20:23'),(285,'雷军','0:0:0:0:0:0:0:1','2019-10-12 08:34:42'),(286,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:06:07'),(287,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:11:25'),(288,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:12:26'),(289,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:14:46'),(290,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:16:42'),(291,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:20:34'),(292,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:25:11'),(293,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:39:28'),(294,'梁爱文','0:0:0:0:0:0:0:1','2019-10-12 09:42:43'),(295,'梁爱文','0:0:0:0:0:0:0:1','2019-10-12 09:52:19'),(296,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:54:22'),(297,'梁爱文','0:0:0:0:0:0:0:1','2019-10-12 09:56:18'),(298,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:56:50'),(299,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:58:11'),(300,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:58:23'),(301,'雷军','0:0:0:0:0:0:0:1','2019-10-12 09:59:47'),(302,'梁爱文','0:0:0:0:0:0:0:1','2019-10-12 10:00:10'),(303,'梁爱文','0:0:0:0:0:0:0:1','2019-10-12 10:02:17'),(304,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:10:24'),(305,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:13:43'),(306,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:17:28'),(307,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:21:13'),(308,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:31:38'),(309,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:34:41'),(310,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:38:56'),(311,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:40:43'),(312,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:42:37'),(313,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:45:30'),(314,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:49:03'),(315,'雷军','0:0:0:0:0:0:0:1','2019-10-12 11:54:39'),(316,'雷军','127.0.0.1','2019-10-12 11:57:28'),(317,'雷军','0:0:0:0:0:0:0:1','2019-10-12 12:33:35'),(318,'雷军','0:0:0:0:0:0:0:1','2019-10-12 12:53:59'),(319,'雷军','0:0:0:0:0:0:0:1','2019-10-12 13:07:11'),(320,'雷军','0:0:0:0:0:0:0:1','2019-10-12 13:20:51'),(321,'雷军','127.0.0.1','2019-10-12 13:22:52'),(322,'雷军','0:0:0:0:0:0:0:1','2019-10-12 13:55:19'),(323,'雷军','0:0:0:0:0:0:0:1','2019-10-12 14:07:32'),(324,'雷军','0:0:0:0:0:0:0:1','2019-10-12 14:10:36'),(325,'雷军','0:0:0:0:0:0:0:1','2019-10-12 14:30:03'),(326,'雷军','0:0:0:0:0:0:0:1','2019-10-15 13:50:57'),(327,'雷军','0:0:0:0:0:0:0:1','2019-10-15 13:52:19'),(328,'雷军','0:0:0:0:0:0:0:1','2019-10-15 15:12:42'),(329,'雷军','0:0:0:0:0:0:0:1','2019-10-15 15:17:04'),(330,'雷军','0:0:0:0:0:0:0:1','2019-10-15 15:18:45'),(331,'雷军','0:0:0:0:0:0:0:1','2019-10-16 01:53:54'),(332,'雷军','0:0:0:0:0:0:0:1','2019-10-16 02:21:26'),(333,'雷军','0:0:0:0:0:0:0:1','2019-10-16 02:22:30'),(334,'雷军','0:0:0:0:0:0:0:1','2019-10-16 02:24:42'),(335,'雷军','0:0:0:0:0:0:0:1','2019-10-16 02:55:18'),(336,'雷军','0:0:0:0:0:0:0:1','2019-10-16 02:57:31'),(337,'雷军','0:0:0:0:0:0:0:1','2019-10-16 03:09:17'),(338,'孙七','0:0:0:0:0:0:0:1','2019-10-16 03:11:48'),(339,'雷军','0:0:0:0:0:0:0:1','2019-10-16 03:12:00'),(340,'雷军','0:0:0:0:0:0:0:1','2019-10-16 03:14:33'),(341,'孙七','0:0:0:0:0:0:0:1','2019-10-16 03:19:01'),(342,'王五','0:0:0:0:0:0:0:1','2019-10-16 03:29:53'),(343,'赵六','0:0:0:0:0:0:0:1','2019-10-16 03:31:57'),(344,'孙七','0:0:0:0:0:0:0:1','2019-10-16 03:32:19'),(345,'雷军','0:0:0:0:0:0:0:1','2019-10-16 03:32:30'),(346,'孙七','0:0:0:0:0:0:0:1','2019-10-16 03:34:42'),(347,'雷军','0:0:0:0:0:0:0:1','2019-10-16 06:08:23'),(348,'雷军','0:0:0:0:0:0:0:1','2019-10-16 06:21:47'),(349,'雷军','0:0:0:0:0:0:0:1','2019-10-16 08:21:58'),(350,'雷军','0:0:0:0:0:0:0:1','2019-10-16 08:52:40'),(351,'雷军','0:0:0:0:0:0:0:1','2019-10-16 09:23:55'),(352,'雷军','0:0:0:0:0:0:0:1','2019-10-16 09:27:36'),(353,'雷军','127.0.0.1','2019-10-16 09:31:33'),(354,'雷军','0:0:0:0:0:0:0:1','2019-10-16 09:35:24'),(355,'雷军','0:0:0:0:0:0:0:1','2019-10-16 10:22:07'),(356,'雷军','0:0:0:0:0:0:0:1','2019-10-16 10:36:07'),(357,'孙七','0:0:0:0:0:0:0:1','2019-10-16 10:36:23'),(358,'雷军','0:0:0:0:0:0:0:1','2019-10-16 10:57:24'),(359,'孙七','0:0:0:0:0:0:0:1','2019-10-16 10:57:44'),(360,'雷军','0:0:0:0:0:0:0:1','2019-10-16 11:07:10'),(361,'孙七','0:0:0:0:0:0:0:1','2019-10-16 11:07:30'),(362,'雷军','0:0:0:0:0:0:0:1','2019-10-16 12:19:30'),(363,'孙七','0:0:0:0:0:0:0:1','2019-10-16 12:21:39'),(364,'雷军','0:0:0:0:0:0:0:1','2019-10-16 12:21:58'),(365,'雷军','0:0:0:0:0:0:0:1','2019-10-16 12:24:31'),(366,'孙七','0:0:0:0:0:0:0:1','2019-10-16 12:24:43'),(367,'雷军','0:0:0:0:0:0:0:1','2019-10-16 14:18:26'),(368,'孙七','0:0:0:0:0:0:0:1','2019-10-16 14:18:37'),(369,'孙七','0:0:0:0:0:0:0:1','2019-10-16 16:37:03'),(370,'孙七','0:0:0:0:0:0:0:1','2019-10-17 06:44:16'),(371,'赵六','0:0:0:0:0:0:0:1','2019-10-17 07:28:35'),(372,'王五','0:0:0:0:0:0:0:1','2019-10-17 07:31:50'),(373,'孙七','0:0:0:0:0:0:0:1','2019-10-17 07:32:26'),(374,'孙七','0:0:0:0:0:0:0:1','2019-10-17 07:37:08'),(375,'赵六','0:0:0:0:0:0:0:1','2019-10-17 07:42:05'),(376,'孙七','0:0:0:0:0:0:0:1','2019-10-17 07:42:47'),(377,'孙七','0:0:0:0:0:0:0:1','2019-10-17 07:43:10'),(378,'赵六','0:0:0:0:0:0:0:1','2019-10-17 07:43:23'),(379,'王五','0:0:0:0:0:0:0:1','2019-10-17 07:44:02'),(380,'孙七','0:0:0:0:0:0:0:1','2019-10-17 07:45:13'),(381,'赵六','0:0:0:0:0:0:0:1','2019-10-17 07:47:53'),(382,'王五','0:0:0:0:0:0:0:1','2019-10-17 07:48:30'),(383,'孙七','0:0:0:0:0:0:0:1','2019-10-17 07:49:21'),(384,'赵六','0:0:0:0:0:0:0:1','2019-10-17 07:50:16'),(385,'王五','0:0:0:0:0:0:0:1','2019-10-17 07:50:54'),(386,'孙七','0:0:0:0:0:0:0:1','2019-10-17 07:51:23'),(387,'赵六','0:0:0:0:0:0:0:1','2019-10-17 08:31:15'),(388,'孙七','0:0:0:0:0:0:0:1','2019-10-17 09:59:58'),(389,'孙七','0:0:0:0:0:0:0:1','2019-10-17 10:38:21'),(390,'孙七','0:0:0:0:0:0:0:1','2019-10-17 11:50:39'),(391,'孙七','0:0:0:0:0:0:0:1','2019-10-17 12:45:24'),(392,'赵六','0:0:0:0:0:0:0:1','2019-10-17 12:51:11'),(393,'王五','0:0:0:0:0:0:0:1','2019-10-17 12:52:12'),(394,'孙七','0:0:0:0:0:0:0:1','2019-10-17 12:52:33'),(395,'雷军','0:0:0:0:0:0:0:1','2019-10-17 12:53:10'),(396,'王五','0:0:0:0:0:0:0:1','2019-10-17 12:56:54'),(397,'孙七','0:0:0:0:0:0:0:1','2019-10-17 12:57:20'),(398,'雷军','0:0:0:0:0:0:0:1','2019-10-17 12:57:43'),(399,'雷军','0:0:0:0:0:0:0:1','2019-10-17 13:00:38'),(400,'雷军','0:0:0:0:0:0:0:1','2019-10-17 13:11:47'),(401,'雷军','0:0:0:0:0:0:0:1','2019-10-17 13:44:58'),(402,'雷军','0:0:0:0:0:0:0:1','2019-10-17 14:07:20'),(403,'雷军','0:0:0:0:0:0:0:1','2019-10-17 14:13:09'),(404,'雷军','0:0:0:0:0:0:0:1','2019-10-17 14:26:32'),(405,'雷军','0:0:0:0:0:0:0:1','2019-10-17 15:52:55'),(406,'雷军','0:0:0:0:0:0:0:1','2019-10-18 01:18:12'),(407,'雷军','0:0:0:0:0:0:0:1','2019-10-18 01:23:59'),(408,'雷军','127.0.0.1','2019-10-18 01:41:38'),(409,'雷军','0:0:0:0:0:0:0:1','2019-10-18 02:03:14'),(410,'雷军','127.0.0.1','2019-10-18 02:07:41'),(411,'雷军','0:0:0:0:0:0:0:1','2019-10-18 02:11:10'),(412,'雷军','0:0:0:0:0:0:0:1','2019-10-18 02:20:07'),(413,'雷军','0:0:0:0:0:0:0:1','2019-10-18 02:23:57'),(414,'雷军','0:0:0:0:0:0:0:1','2019-10-18 02:45:18');

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

insert  into `sys_notice`(`id`,`title`,`content`,`createtime`,`opername`) values (1,'关于系统V1.3更新公告','2','2018-08-07 00:00:00','管理员'),(10,'关于系统V1.2更新公告','12312312<img src=\"/resources/layui/images/face/42.gif\" alt=\"[抓狂]\">','2018-08-07 00:00:00','超级管理员'),(11,'关于系统V1.1更新公告','21321321321<img src=\"/resources/layui/images/face/18.gif\" alt=\"[右哼哼]\">','2018-08-07 00:00:00','超级管理员'),(16,'fdsfsd','fsdf','2019-10-08 03:04:54','雷军');

/*Table structure for table `sys_permission` */

DROP TABLE IF EXISTS `sys_permission`;

CREATE TABLE `sys_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL COMMENT '权限类型[menu/permission]',
  `title` varchar(255) DEFAULT NULL,
  `percode` varchar(255) DEFAULT NULL COMMENT '权限编码[只有type= permission才有  user:view]',
  `icon` varchar(255) DEFAULT NULL,
  `href` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  `open` int(11) DEFAULT NULL,
  `ordernum` int(11) DEFAULT NULL,
  `available` int(11) DEFAULT NULL COMMENT '状态【0不可用1可用】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

/*Data for the table `sys_permission` */

insert  into `sys_permission`(`id`,`pid`,`type`,`title`,`percode`,`icon`,`href`,`target`,`open`,`ordernum`,`available`) values (1,0,'menu','ERP仓库管理系统',NULL,'&#xe68e;','','',1,1,1),(2,1,'menu','基础管理',NULL,'&#xe857;','','',0,2,1),(3,1,'menu','进货管理',NULL,'&#xe645;','',NULL,0,3,1),(4,1,'menu','销售管理',NULL,'&#xe611;','','',0,4,1),(5,1,'menu','系统管理',NULL,'&#xe614;','','',0,5,1),(6,1,'menu','其它管理',NULL,'&#xe628;','','',0,6,1),(7,2,'menu','客户管理',NULL,'&#xe651;','/bus/toCustomerManager','',0,7,1),(8,2,'menu','供应商管理',NULL,'&#xe658;','/bus/toProviderManager','',0,8,1),(9,2,'menu','商品管理',NULL,'&#xe657;','/bus/toGoodsManager','',0,9,1),(10,3,'menu','商品进货',NULL,'&#xe756;','/bus/toInportManager','',0,10,1),(11,3,'menu','商品退货查询',NULL,'&#xe65a;','/bus/toOutportManager','',0,11,1),(12,4,'menu','商品销售',NULL,'&#xe65b;','/bus/toSalesManager','',0,12,1),(13,4,'menu','销售退货查询',NULL,'&#xe770;','/bus/toSalesBackManager','',0,13,1),(14,5,'menu','部门管理',NULL,'&#xe770;','/sys/toDeptManager','',0,14,1),(15,5,'menu','菜单管理',NULL,'&#xe857;','/sys/toMenuManager','',0,15,1),(16,5,'menu','权限管理','','&#xe857;','/sys/toPermissionManager','',0,16,1),(17,5,'menu','角色管理','','&#xe650;','/sys/toRoleManager','',0,17,1),(18,5,'menu','用户管理','','&#xe612;','/sys/toUserManager','',0,18,1),(21,6,'menu','登陆日志',NULL,'&#xe675;','/sys/toLoginInfoManager','',0,21,1),(22,6,'menu','系统公告',NULL,'&#xe756;','/sys/toNoticeManager',NULL,0,22,1),(23,6,'menu','图标管理',NULL,'&#xe670;','../resources/page/icon.html',NULL,0,23,1),(30,14,'permission','添加部门','dept:create','',NULL,NULL,0,24,1),(31,14,'permission','修改部门','dept:update','',NULL,NULL,0,26,1),(32,14,'permission','删除部门','dept:delete','',NULL,NULL,0,27,1),(34,15,'permission','添加菜单','menu:create','','','',0,29,1),(35,15,'permission','修改菜单','menu:update','',NULL,NULL,0,30,1),(36,15,'permission','删除菜单','menu:delete','',NULL,NULL,0,31,1),(38,16,'permission','添加权限','permission:create','',NULL,NULL,0,33,1),(39,16,'permission','修改权限','permission:update','',NULL,NULL,0,34,1),(40,16,'permission','删除权限','permission:delete','',NULL,NULL,0,35,1),(42,17,'permission','添加角色','role:create','',NULL,NULL,0,37,1),(43,17,'permission','修改角色','role:update','',NULL,NULL,0,38,1),(44,17,'permission','角色删除','role:delete','',NULL,NULL,0,39,1),(46,17,'permission','分配权限','role:selectPermission','',NULL,NULL,0,41,1),(47,18,'permission','添加用户','user:create','',NULL,NULL,0,42,1),(48,18,'permission','修改用户','user:update','',NULL,NULL,0,43,1),(49,18,'permission','删除用户','user:delete','',NULL,NULL,0,44,1),(51,18,'permission','用户分配角色','user:selectRole','',NULL,NULL,0,46,1),(52,18,'permission','重置密码','user:resetPwd',NULL,NULL,NULL,0,47,1),(53,14,'permission','部门查询','dept:view',NULL,NULL,NULL,0,48,1),(54,15,'permission','菜单查询','menu:view',NULL,NULL,NULL,0,49,1),(55,16,'permission','权限查询','permission:view',NULL,NULL,NULL,0,50,1),(56,17,'permission','角色查询','role:view',NULL,NULL,NULL,0,51,1),(57,18,'permission','用户查询','user:view',NULL,NULL,NULL,0,52,1),(68,7,'permission','客户查询','customer:view',NULL,NULL,NULL,NULL,60,1),(69,7,'permission','客户添加','customer:create',NULL,NULL,NULL,NULL,61,1),(70,7,'permission','客户修改','customer:update',NULL,NULL,NULL,NULL,62,1),(71,7,'permission','客户删除','customer:delete',NULL,NULL,NULL,NULL,63,1),(73,21,'permission','日志查询','info:view',NULL,NULL,NULL,NULL,65,1),(74,21,'permission','日志删除','info:delete',NULL,NULL,NULL,NULL,66,1),(75,21,'permission','日志批量删除','info:batchdelete',NULL,NULL,NULL,NULL,67,1),(76,22,'permission','公告查询','notice:view',NULL,NULL,NULL,NULL,68,1),(77,22,'permission','公告添加','notice:create',NULL,NULL,NULL,NULL,69,1),(78,22,'permission','公告修改','notice:update',NULL,NULL,NULL,NULL,70,1),(79,22,'permission','公告删除','notice:delete',NULL,NULL,NULL,NULL,71,1),(81,8,'permission','供应商查询','provider:view',NULL,NULL,NULL,NULL,73,1),(82,8,'permission','供应商添加','provider:create',NULL,NULL,NULL,NULL,74,1),(83,8,'permission','供应商修改','provider:update',NULL,NULL,NULL,NULL,75,1),(84,8,'permission','供应商删除','provider:delete',NULL,NULL,NULL,NULL,76,1),(86,22,'permission','公告查看','notice:viewnotice',NULL,NULL,NULL,NULL,78,1),(91,9,'permission','商品查询','goods:view',NULL,NULL,NULL,0,79,1),(92,9,'permission','商品添加','goods:create',NULL,NULL,NULL,0,80,1),(98,6,'menu','缓存管理',NULL,'&#xe6b1;','/sys/toCacheManager',NULL,0,84,1),(99,6,'menu','技术管理',NULL,'&#xe653;','/sys/toTechnologyManager',NULL,0,85,1),(102,6,'menu','数据源监控',NULL,'&#xe674;','/druid',NULL,0,87,1),(103,1,'menu','审批管理',NULL,'&#xe62a;','',NULL,0,88,1),(104,103,'menu','请假单管理',NULL,'&#xe63c;','/sys/toLeaveBillManager',NULL,0,89,1),(105,1,'menu','流程管理',NULL,'&#xe672;','',NULL,0,90,1),(106,105,'menu','流程管理',NULL,'&#xe60a;','/sys/toWorkFlowManager',NULL,0,91,1),(107,103,'menu','我的待办任务',NULL,'&#xe66b;','/sys/toTaskManager',NULL,0,92,1),(108,1,'menu','统计管理',NULL,'&#xe656;','',NULL,1,93,1),(109,108,'menu','客户地区统计',NULL,'&#xe6b2;','/stat/toCustomerAreaStat',NULL,0,94,1),(110,108,'menu','公司年度销售',NULL,'&#xe633;','/stat/toCompanyYearGradeStat',NULL,0,95,1),(111,108,'menu','客户年度销售统计',NULL,'&#xe637;','/stat/toCustomerYearSalesManager',NULL,0,96,1);

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

insert  into `sys_role`(`id`,`name`,`remark`,`available`,`createtime`) values (1,'超级管理员','拥有所有菜单权限',1,'2019-04-10 14:06:32'),(4,'基础数据管理员','基础数据管理员',1,'2019-04-10 14:06:32'),(5,'仓库管理员','仓库管理员',1,'2019-04-10 14:06:32'),(6,'销售管理员','销售管理员',1,'2019-04-10 14:06:32'),(7,'系统管理员','系统管理员',1,'2019-04-10 14:06:32'),(12,'公告管理员','公告管理者',1,'2019-10-10 06:37:23'),(13,'流程管理员','流程管理',1,'2019-10-16 03:13:09'),(14,'审批管理员','审批管理',1,'2019-10-16 12:22:45'),(15,'部门领导的审批管理','部门领导的审批管理',1,'2019-10-17 12:54:22'),(16,'员工的审批管理','员工的审批管理',1,'2019-10-17 12:54:41');

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

insert  into `sys_technology`(`id`,`name`,`available`,`remark`) values (1,'spring',1,'ioc和aop的优秀框架'),(2,'mybatis',1,'轻量级的持久化框架'),(3,'springmvc',1,'spring的web层优秀框架'),(4,'通用mapper',1,'生成单表的sql'),(5,'myabtis-plus',1,'生成单表的sql且自带分页插件'),(6,'springboot',1,'去配置的快速项目搭建的框架'),(7,'springcloud',1,'微服务框架'),(8,'shiro',1,'轻量级的apche的权限控制框架'),(9,'spring-security',1,'spring的权限控制解决方案较重量级'),(10,'spring-data',1,''),(11,'quartz',1,'定时任务调度'),(12,'layui',1,'后台开发拿来即用的优秀前端框架'),(13,'easyui',1,'后台开发的优秀框架页面较简陋'),(14,'activity',1,'工作流'),(15,'echarts',1,'百度的图表展示'),(16,'highcharts',1,'图表展示'),(17,'poi',1,'excel报表'),(18,'zxing',1,'谷歌的二维码生成'),(19,'qrcode',1,'日本的二维码生成'),(20,'druid',1,'阿里巴巴的连接池'),(21,'基本ssm',1,'基本ssm整合'),(22,'themeleaf',1,'模板技术'),(23,'jsp',1,'实际也是servlet不建议用');

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
  `type` int(255) DEFAULT NULL COMMENT '用户类型[0超级管理员1，管理员，2普通用户]',
  `userimgpath` varchar(255) DEFAULT NULL COMMENT '头像地址',
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

insert  into `sys_user`(`id`,`name`,`loginname`,`address`,`sex`,`remark`,`pwd`,`deptid`,`hiredate`,`mgr`,`available`,`ordernum`,`type`,`userimgpath`,`salt`,`birthday`,`email`,`province`,`city`,`area`,`telephone`) values (1,'雷军','leijun','系统深处的男人',1,'超级管理员','83175e09bd5fddad4810a0d6fbe673ad',1,'2018-06-25 11:06:34',NULL,1,1,0,'2019-10-17/201910172111539011403.jpg','0408827849524b62ab0dd8f29ff2e476','2019-10-25','1946408873@qq.com','44','','440904','123456'),(2,'李四','ls','武汉',0,'KING','b07b848d69e0553b80e601d31571797e',1,'2018-06-25 11:06:36',NULL,1,2,1,'img/defaultUserImg.jpg','FC1EE06AE4354D3FBF7FDD15C8FCDA71',NULL,NULL,NULL,NULL,NULL,NULL),(3,'王五','ww','武汉',1,'管理员','3c3f971eae61e097f59d52360323f1c8',3,'2018-06-25 11:06:38',2,1,3,1,'img/defaultUserImg.jpg','3D5F956E053C4E85B7D2681386E235D2',NULL,NULL,NULL,NULL,NULL,NULL),(4,'赵六','zl','武汉',1,'程序员','2e969742a7ea0c7376e9551d578e05dd',4,'2018-06-25 11:06:40',3,1,4,1,'img/defaultUserImg.jpg','6480EE1391E34B0886ACADA501E31145',NULL,NULL,NULL,NULL,NULL,NULL),(5,'孙七','sq','武汉',1,'程序员','47b4c1ad6e4b54dd9387a09cb5a03de1',2,'2018-06-25 11:06:43',4,1,5,1,'img/defaultUserImg.jpg','FE3476C3E3674E5690C737C269FCBF8E',NULL,NULL,NULL,NULL,NULL,NULL),(6,'刘八','lb','深圳',1,'程序员','bcee2b05b4b591106829aec69a094806',4,'2018-08-06 11:21:12',3,1,6,1,'img/defaultUserImg.jpg','E6CCF54A09894D998225878BBD139B20',NULL,NULL,NULL,NULL,NULL,NULL),(7,'小米','xiaomi','武汉',1,'生产小米手机','ebb6fd73fd8ddb94f38453af4f24d280',4,'2019-10-09 14:55:24',6,1,7,1,'img/defaultUserImg.jpg','D0D4349CB77D4DBE80FB7F99A21935E0',NULL,NULL,NULL,NULL,NULL,NULL),(8,'雷军','111','武汉',1,'小米集团CEO','594968e42678a4e438704da63c65190c',22,'2019-10-09 16:19:06',NULL,1,8,1,'img/defaultUserImg.jpg','D88499BD318846CDBB4BB363F1E21F83',NULL,NULL,NULL,NULL,NULL,NULL),(9,'路卫兵','luweibing','武汉',1,'红米','100f39130d8111751364fd52084f91c1',22,'2019-10-09 16:30:35',8,1,9,1,'img/defaultUserImg.jpg','76B7970817D241F1B0E903E014D459A4',NULL,NULL,NULL,NULL,NULL,NULL),(10,'林斌','linbin','武汉',1,'小米','e949e4ad92d81452cddae1f776b74129',22,'2019-10-09 16:33:05',8,1,10,1,'img/defaultUserImg.jpg','3D237866EB5E4E9E9C40F25A6F769D6E',NULL,NULL,NULL,NULL,NULL,NULL),(11,'马化腾','mahuateng','深圳',1,'搞游戏','c3d419754539338aa9e4cdda13550daf',22,'2019-10-09 16:44:57',8,1,11,1,'img/defaultUserImg.jpg','E8116A733E2649B8A1DEBADAA4BD96B8',NULL,NULL,NULL,NULL,NULL,NULL),(13,'罗永浩','luoyonghao','北京',1,'锤子','2e6e55cf04d4fa8daa3c983ff10b0f8d',22,'2019-10-09 17:18:20',8,1,12,1,'img/defaultUserImg.jpg','C03EFF2C3424473784D53D9E6A29BD55',NULL,NULL,NULL,NULL,NULL,NULL),(14,'梁爱文','liangaiwen','广州大石',0,'我是一个可爱的小猪','240cfc56536c00c2cda3ba923d9c8f9a',1,'2019-10-12 09:41:00',2,1,13,1,'2019-10-12/201910121750404011953.jpg','3C5E75C2CCC94052894CF481A1311EE1',NULL,'123@qq.com','44','4401','440113','12345678910');

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
