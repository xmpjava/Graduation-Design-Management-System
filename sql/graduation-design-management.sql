/*
 Navicat Premium Data Transfer

 Source Server         : mysql5.5.27
 Source Server Type    : MySQL
 Source Server Version : 50527
 Source Host           : localhost:3316
 Source Schema         : graduation-design-management

 Target Server Type    : MySQL
 Target Server Version : 50527
 File Encoding         : 65001

 Date: 28/02/2023 13:37:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `admin_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '管理员id',
  `admin_pwd` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '管理员密码',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('admin', '123');

-- ----------------------------
-- Table structure for base_dept
-- ----------------------------
DROP TABLE IF EXISTS `base_dept`;
CREATE TABLE `base_dept`  (
  `dept_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dept_name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dept_state` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`dept_id`) USING BTREE,
  UNIQUE INDEX `dept_name`(`dept_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of base_dept
-- ----------------------------
INSERT INTO `base_dept` VALUES ('0001', '信息与电子工程学院', 1);
INSERT INTO `base_dept` VALUES ('0002', '土木工程学院', 1);
INSERT INTO `base_dept` VALUES ('0003', '机械工程学院', 1);
INSERT INTO `base_dept` VALUES ('0004', '经济与管理学院', 1);
INSERT INTO `base_dept` VALUES ('0005', '教育与现代艺术学院', 1);
INSERT INTO `base_dept` VALUES ('0006', '医学院', 1);

-- ----------------------------
-- Table structure for base_major
-- ----------------------------
DROP TABLE IF EXISTS `base_major`;
CREATE TABLE `base_major`  (
  `major_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `major_name` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dept_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `major_state` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`major_id`) USING BTREE,
  UNIQUE INDEX `major_name`(`major_name`) USING BTREE,
  INDEX `dept_id`(`dept_id`) USING BTREE,
  CONSTRAINT `base_major_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `base_dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of base_major
-- ----------------------------
INSERT INTO `base_major` VALUES ('1001', '计算机科学与技术', '0001', 1);
INSERT INTO `base_major` VALUES ('1002', '软件工程', '0001', 1);
INSERT INTO `base_major` VALUES ('1003', '电子信息工程技术', '0001', 1);
INSERT INTO `base_major` VALUES ('1004', '通信工程', '0001', 1);
INSERT INTO `base_major` VALUES ('1005', '信息管理与信息系统', '0001', 1);
INSERT INTO `base_major` VALUES ('1006', '电气工程及其自动化', '0001', 1);
INSERT INTO `base_major` VALUES ('1007', '物联网工程', '0001', 1);
INSERT INTO `base_major` VALUES ('2001', '工程造价专业', '0002', 1);
INSERT INTO `base_major` VALUES ('2002', '城市地下空间工程专业', '0002', 1);
INSERT INTO `base_major` VALUES ('2003', '土木工程专业', '0002', 1);
INSERT INTO `base_major` VALUES ('2004', '工程管理专业', '0002', 1);
INSERT INTO `base_major` VALUES ('2005', '道路桥梁与渡河工程', '0002', 1);
INSERT INTO `base_major` VALUES ('3001', '机械电子工程', '0003', 1);
INSERT INTO `base_major` VALUES ('3002', '机械设计制造及其自动化', '0003', 1);
INSERT INTO `base_major` VALUES ('3003', '车辆工程', '0003', 1);
INSERT INTO `base_major` VALUES ('3004', '汽车服务工程', '0003', 1);
INSERT INTO `base_major` VALUES ('3005', '机器人工程', '0003', 1);
INSERT INTO `base_major` VALUES ('3006', '测控技术与仪器', '0003', 1);
INSERT INTO `base_major` VALUES ('4001', '会计学', '0004', 1);
INSERT INTO `base_major` VALUES ('4002', '大数据与会计', '0004', 1);
INSERT INTO `base_major` VALUES ('4003', '市场营销', '0004', 1);
INSERT INTO `base_major` VALUES ('4004', '现代物流管理', '0004', 1);
INSERT INTO `base_major` VALUES ('4005', '金融学', '0004', 1);
INSERT INTO `base_major` VALUES ('4006', '经济统计学', '0004', 1);
INSERT INTO `base_major` VALUES ('5001', '学前教育', '0005', 1);
INSERT INTO `base_major` VALUES ('5002', '环境设计', '0005', 1);
INSERT INTO `base_major` VALUES ('5003', '产品设计', '0005', 1);
INSERT INTO `base_major` VALUES ('5004', '小学教育', '0005', 1);
INSERT INTO `base_major` VALUES ('6001', '护理学', '0006', 1);
INSERT INTO `base_major` VALUES ('6002', '助产学', '0006', 1);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `c_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '建议编号',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `t_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `f_id` bigint(20) NULL DEFAULT NULL,
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `datetime` datetime NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`c_id`) USING BTREE,
  INDEX `t_id`(`t_id`) USING BTREE,
  INDEX `s_id`(`s_id`) USING BTREE,
  INDEX `f_id`(`f_id`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `teacher` (`t_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`f_id`) REFERENCES `myfile` (`f_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 87 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (78, '', '20011', 1, '3119010107', '2023-02-27 01:20:08');
INSERT INTO `comments` VALUES (79, '', '20011', 2, '3119010107', '2023-02-27 01:20:28');
INSERT INTO `comments` VALUES (80, '', '20011', 3, '3119010107', '2023-02-27 01:20:41');
INSERT INTO `comments` VALUES (81, '', '20011', 4, '3119010107', '2023-02-27 01:21:29');
INSERT INTO `comments` VALUES (82, '', '20011', 5, '3119010108', '2023-02-27 01:22:16');
INSERT INTO `comments` VALUES (83, '', '20011', 6, '3119010108', '2023-02-27 01:22:34');
INSERT INTO `comments` VALUES (84, '', '20011', 7, '3119010108', '2023-02-27 01:23:00');
INSERT INTO `comments` VALUES (85, '', '20011', 8, '3119010108', '2023-02-27 01:23:15');
INSERT INTO `comments` VALUES (86, '', '20011', 9, '3119010108', '2023-02-27 01:23:31');

-- ----------------------------
-- Table structure for mid_check
-- ----------------------------
DROP TABLE IF EXISTS `mid_check`;
CREATE TABLE `mid_check`  (
  `m_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '中期检查编号',
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `f_id` bigint(20) NULL DEFAULT NULL,
  `agree` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`m_id`) USING BTREE,
  INDEX `s_id`(`s_id`) USING BTREE,
  INDEX `f_id`(`f_id`) USING BTREE,
  CONSTRAINT `mid_check_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mid_check_ibfk_2` FOREIGN KEY (`f_id`) REFERENCES `myfile` (`f_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of mid_check
-- ----------------------------
INSERT INTO `mid_check` VALUES (1, '3119010107', 3, '通过');
INSERT INTO `mid_check` VALUES (2, '3119010108', 8, '通过');

-- ----------------------------
-- Table structure for myfile
-- ----------------------------
DROP TABLE IF EXISTS `myfile`;
CREATE TABLE `myfile`  (
  `f_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '文件编号',
  `f_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `f_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `upload_datetime` datetime NULL DEFAULT NULL COMMENT '上传时间',
  `f_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  PRIMARY KEY (`f_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of myfile
-- ----------------------------
INSERT INTO `myfile` VALUES (1, '3119010107谭展鹏任务书.doc', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010107谭展鹏任务书.doc', '2023-02-27 01:19:59', '任务书');
INSERT INTO `myfile` VALUES (2, '3119010107谭展鹏开题报告.doc', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010107谭展鹏开题报告.doc', '2023-02-27 01:20:21', '开题报告');
INSERT INTO `myfile` VALUES (3, '3119010107谭展鹏中期检查.doc', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010107谭展鹏中期检查.doc', '2023-02-27 01:20:34', '中期检查');
INSERT INTO `myfile` VALUES (4, '3119010107谭展鹏论文.docx', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010107谭展鹏论文.docx', '2023-02-27 01:21:22', '论文');
INSERT INTO `myfile` VALUES (5, '3119010108石鹏任务书.docx', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010108石鹏任务书.docx', '2023-02-27 01:22:06', '任务书');
INSERT INTO `myfile` VALUES (6, '3119010108石鹏开题报告.docx', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010108石鹏开题报告.docx', '2023-02-27 01:22:24', '开题报告');
INSERT INTO `myfile` VALUES (7, '3119010108石鹏开题报告(1).docx', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010108石鹏开题报告(1).docx', '2023-02-27 01:22:47', '开题报告');
INSERT INTO `myfile` VALUES (8, '3119010108石鹏中期检查.docx', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010108石鹏中期检查.docx', '2023-02-27 01:23:07', '中期检查');
INSERT INTO `myfile` VALUES (9, '3119010108石鹏论文.docx', 'E:\\Java\\eclipse\\xmp\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Graduation-Design-Management-System\\upload\\20011\\3119010108石鹏论文.docx', '2023-02-27 01:23:25', '论文');

-- ----------------------------
-- Table structure for open_report
-- ----------------------------
DROP TABLE IF EXISTS `open_report`;
CREATE TABLE `open_report`  (
  `r_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '开题报告编号',
  `f_id` bigint(20) NULL DEFAULT NULL COMMENT '文件编号',
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学号',
  `agree` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否同意开题',
  PRIMARY KEY (`r_id`) USING BTREE,
  INDEX `f_id`(`f_id`) USING BTREE,
  INDEX `s_id`(`s_id`) USING BTREE,
  CONSTRAINT `open_report_ibfk_1` FOREIGN KEY (`f_id`) REFERENCES `myfile` (`f_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `open_report_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of open_report
-- ----------------------------
INSERT INTO `open_report` VALUES (1, 2, '3119010107', '通过');
INSERT INTO `open_report` VALUES (2, 6, '3119010108', '不通过');
INSERT INTO `open_report` VALUES (3, 7, '3119010108', '通过');

-- ----------------------------
-- Table structure for proj_book
-- ----------------------------
DROP TABLE IF EXISTS `proj_book`;
CREATE TABLE `proj_book`  (
  `p_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务书编号',
  `f_id` bigint(20) NOT NULL COMMENT '文件编号',
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学生编号',
  `agree` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否通过(待通过，不通过，通过)',
  PRIMARY KEY (`p_id`) USING BTREE,
  INDEX `s_id`(`s_id`) USING BTREE,
  INDEX `f_id`(`f_id`) USING BTREE,
  CONSTRAINT `proj_book_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `proj_book_ibfk_2` FOREIGN KEY (`f_id`) REFERENCES `myfile` (`f_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of proj_book
-- ----------------------------
INSERT INTO `proj_book` VALUES (1, 1, '3119010107', '通过');
INSERT INTO `proj_book` VALUES (2, 5, '3119010108', '通过');

-- ----------------------------
-- Table structure for reply_group
-- ----------------------------
DROP TABLE IF EXISTS `reply_group`;
CREATE TABLE `reply_group`  (
  `reply_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `reply_leader` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reply_member` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reply_place` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reply_datetime` datetime NULL DEFAULT NULL,
  `batch` smallint(6) NULL DEFAULT NULL,
  `reply_student` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creator` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`reply_id`) USING BTREE,
  INDEX `creator`(`creator`) USING BTREE,
  CONSTRAINT `reply_group_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `teacher` (`t_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of reply_group
-- ----------------------------
INSERT INTO `reply_group` VALUES ('0001', '10011 张主任', '30011 评阅老师一,30012 评阅老师二', '7A311', '2023-02-27 01:24:38', 1, '20011 张三', '10011');

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `member_t_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `review_score` int(11) NULL DEFAULT NULL,
  `review_comments` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reply_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `review_type` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`s_id`, `member_t_id`) USING BTREE,
  INDEX `review_ibfk_3`(`reply_id`) USING BTREE,
  INDEX `member_t_id`(`member_t_id`) USING BTREE,
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `review_ibfk_3` FOREIGN KEY (`reply_id`) REFERENCES `reply_group` (`reply_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_4` FOREIGN KEY (`member_t_id`) REFERENCES `teacher` (`t_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of review
-- ----------------------------
INSERT INTO `review` VALUES ('3119010107', '10011', 87, '', '0001', '答辩组长评分');
INSERT INTO `review` VALUES ('3119010107', '30011', 77, '', '0001', '评阅教师评分');
INSERT INTO `review` VALUES ('3119010107', '30012', 96, '', '0001', '评阅教师评分');
INSERT INTO `review` VALUES ('3119010108', '10011', 74, '', '0001', '答辩组长评分');
INSERT INTO `review` VALUES ('3119010108', '30011', 87, '', '0001', '评阅教师评分');
INSERT INTO `review` VALUES ('3119010108', '30012', 99, '', '0001', '评阅教师评分');

-- ----------------------------
-- Table structure for score_proportion
-- ----------------------------
DROP TABLE IF EXISTS `score_proportion`;
CREATE TABLE `score_proportion`  (
  `proportion_id` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `t_score_proportion` double NULL DEFAULT NULL,
  `leader_score_proportion` double NULL DEFAULT NULL,
  `review_score_proportion` double NULL DEFAULT NULL,
  PRIMARY KEY (`proportion_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of score_proportion
-- ----------------------------
INSERT INTO `score_proportion` VALUES ('1', 0.5, 0.3, 0.2);

-- ----------------------------
-- Table structure for select_title
-- ----------------------------
DROP TABLE IF EXISTS `select_title`;
CREATE TABLE `select_title`  (
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '学生编号',
  `titl_id` bigint(20) NOT NULL,
  `t_score` int(11) NULL DEFAULT NULL COMMENT '指导教师评分',
  `t_comments` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '指导教师评语',
  `reply_score` double NULL DEFAULT NULL COMMENT '答辩评分',
  `reply_comments` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '答辩评语',
  `seltitl_state` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '选题状态(待同意，同意，拒绝，无效)',
  PRIMARY KEY (`s_id`, `titl_id`) USING BTREE,
  INDEX `titl_id`(`titl_id`) USING BTREE,
  CONSTRAINT `select_title_ibfk_1` FOREIGN KEY (`titl_id`) REFERENCES `title` (`titl_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `select_title_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of select_title
-- ----------------------------
INSERT INTO `select_title` VALUES ('3119010107', 1, 92, '', 43.3, NULL, '同意');
INSERT INTO `select_title` VALUES ('3119010108', 2, 87, '', 40.8, NULL, '同意');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `s_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `s_pwd` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `s_class` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(11) NULL DEFAULT NULL,
  `dept` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `major` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `batch` smallint(6) NULL DEFAULT NULL,
  `s_state` int(11) NULL DEFAULT NULL,
  `major_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`s_id`) USING BTREE,
  INDEX `dept_id`(`dept`) USING BTREE,
  INDEX `major_id`(`major`) USING BTREE,
  INDEX `major_id_2`(`major_id`) USING BTREE,
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`major_id`) REFERENCES `base_major` (`major_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('3119010101', '任语堂', '123', '1', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', '3050608872@qq.com', 1, 1, '1001');
INSERT INTO `student` VALUES ('3119010102', '叶君浩', '123', '1', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', '3050608872@qq.com', 1, 1, '1001');
INSERT INTO `student` VALUES ('3119010103', '苏炫明', '123', '2', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', 'xmp0526@126.com', 1, 1, '1001');
INSERT INTO `student` VALUES ('3119010104', '夏绍齐', '123', '1', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', 'xmp0526@126.com', 1, 1, '1001');
INSERT INTO `student` VALUES ('3119010105', '黎立诚', '123', '3', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', '2453629708@qq.com', 1, 1, '1001');
INSERT INTO `student` VALUES ('3119010106', '薛天磊', '123', '3', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', '2453629708@qq.com', 1, 1, '1001');
INSERT INTO `student` VALUES ('3119010107', '谭展鹏', '123', '4', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', '3050608872@qq.com', 1, 1, '1001');
INSERT INTO `student` VALUES ('3119010108', '石鹏', '123', '4', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', '3050608872@qq.com', 1, 1, '1001');
INSERT INTO `student` VALUES ('3119010109', '黎立', '123', '1', NULL, NULL, '信息与电子工程学院', '软件工程', '18838583135', '2453629708@qq.com', 1, 1, '1002');
INSERT INTO `student` VALUES ('3119010110', '王小虎', '123', '1', NULL, NULL, '信息与电子工程学院', '软件工程', '18838583135', '2453629708@qq.com', 1, 1, '1002');
INSERT INTO `student` VALUES ('3119010138', '熊民普', '123', '1', NULL, NULL, '信息与电子工程学院', '计算机科学与技术', '18838583135', 'xmp0526@126.com', 1, 1, '1001');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `t_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `t_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `age` int(11) NULL DEFAULT NULL,
  `t_pwd` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dept` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `major` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `duties` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `power` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `t_state` int(1) NULL DEFAULT NULL COMMENT '1:正常 0:暂停',
  `dept_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `major_id` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`t_id`) USING BTREE,
  INDEX `dept_id`(`dept_id`) USING BTREE,
  INDEX `major_id`(`major_id`) USING BTREE,
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `base_dept` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`major_id`) REFERENCES `base_major` (`major_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('10011', '张主任', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '教授', '教授', '18888888888', '18888888888@qq.com', '是', 1, '0001', '1001');
INSERT INTO `teacher` VALUES ('10012', '李主任', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '教授', '教授', '18888888888', '18888888888@qq.com', '是', 1, '0001', '1001');
INSERT INTO `teacher` VALUES ('10013', '王主任', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '教授', '教授', '18888888888', '18888888888@qq.com', '是', 1, '0001', '1001');
INSERT INTO `teacher` VALUES ('10014', '赵主任', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '教授', '教授', '18888888888', '18888888888@qq.com', '是', 1, '0001', '1001');
INSERT INTO `teacher` VALUES ('10015', '韩主任', NULL, NULL, '123', '信息与电子工程学院', '软件工程', '教授', '教授', '18888888888', '18888888888@qq.com', '是', 1, '0001', '1002');
INSERT INTO `teacher` VALUES ('20011', '张三', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '讲师', '讲师', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('20012', '李四', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '讲师', '讲师', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('20013', '王五', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '讲师', '讲师', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('20014', '赵六', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '讲师', '讲师', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('20015', '孙七', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '讲师', '讲师', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('20016', '周八', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '讲师', '讲师', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('20017', '吴九', NULL, NULL, '123', '信息与电子工程学院', '软件工程', '讲师', '讲师', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('30011', '评阅老师一', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '助教', '助教', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('30012', '评阅老师二', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '助教', '助教', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('30013', '评阅老师三', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '助教', '助教', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('30014', '评阅老师四', NULL, NULL, '123', '信息与电子工程学院', '计算机科学与技术', '助教', '助教', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);
INSERT INTO `teacher` VALUES ('30015', '评阅老师五', NULL, NULL, '123', '信息与电子工程学院', '软件工程', '助教', '助教', '18838383838', '18838383838@qq.com', '否', 1, '0001', NULL);

-- ----------------------------
-- Table structure for thesis
-- ----------------------------
DROP TABLE IF EXISTS `thesis`;
CREATE TABLE `thesis`  (
  `thesis_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '论文编号',
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学生编号',
  `titl_id` bigint(20) NULL DEFAULT NULL COMMENT '课题编号',
  `f_id` bigint(20) NULL DEFAULT NULL COMMENT '文件编号',
  `agree` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`thesis_id`) USING BTREE,
  INDEX `titl_id`(`titl_id`) USING BTREE,
  INDEX `s_id`(`s_id`) USING BTREE,
  INDEX `f_id`(`f_id`) USING BTREE,
  CONSTRAINT `thesis_ibfk_1` FOREIGN KEY (`titl_id`) REFERENCES `title` (`titl_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `thesis_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `thesis_ibfk_3` FOREIGN KEY (`f_id`) REFERENCES `myfile` (`f_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of thesis
-- ----------------------------
INSERT INTO `thesis` VALUES (1, '3119010107', 1, 4, '通过');
INSERT INTO `thesis` VALUES (2, '3119010108', 2, 9, '通过');

-- ----------------------------
-- Table structure for thesis_attachment
-- ----------------------------
DROP TABLE IF EXISTS `thesis_attachment`;
CREATE TABLE `thesis_attachment`  (
  `a_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `f_id` bigint(20) NULL DEFAULT NULL,
  `s_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`a_id`) USING BTREE,
  INDEX `f_id`(`f_id`) USING BTREE,
  INDEX `s_id`(`s_id`) USING BTREE,
  CONSTRAINT `thesis_attachment_ibfk_1` FOREIGN KEY (`f_id`) REFERENCES `myfile` (`f_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `thesis_attachment_ibfk_2` FOREIGN KEY (`s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of thesis_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for title
-- ----------------------------
DROP TABLE IF EXISTS `title`;
CREATE TABLE `title`  (
  `titl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `titl_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `t_id` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `titl_source` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `titl_type` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `titl_describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `titl_state` varchar(7) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sel_state` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `major` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`titl_id`) USING BTREE,
  INDEX `t_id`(`t_id`) USING BTREE,
  CONSTRAINT `title_ibfk_1` FOREIGN KEY (`t_id`) REFERENCES `teacher` (`t_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of title
-- ----------------------------
INSERT INTO `title` VALUES (1, '图书管理系统', '20011', '科研课题', '软件设计类', '支持管理员控制开放系统多个模块，可管理图书管理、期款管理、读者管理、数据管理、报表统计、系统设置、智慧图书馆分析平台个子系统功能模块的名称更改、编辑、删除，开放功能。', '已审批', '已被选择', '计算机科学与技术');
INSERT INTO `title` VALUES (2, '宿舍管理系统', '20011', '科研课题', '软件设计类', '宿舍管理主要在各个中学和高校中经常提到。宿舍管理是后勤部门的一个重要工作。但是现在很多后勤部门都还是在使用最原始的宿舍管理方法。而且在学生入住的过程中学生住宿的信息得不到有效的更新，同时学生经常会更换宿舍等等。', '已审批', '已被选择', '计算机科学与技术');

-- ----------------------------
-- View structure for midcheckinfo
-- ----------------------------
DROP VIEW IF EXISTS `midcheckinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `midcheckinfo` AS select `mid_check`.`m_id` AS `m_id`,`mid_check`.`f_id` AS `f_id`,`mid_check`.`s_id` AS `s_id`,`mid_check`.`agree` AS `agree`,`myfile`.`f_name` AS `f_name`,`myfile`.`f_path` AS `f_path`,`myfile`.`upload_datetime` AS `upload_datetime`,`myfile`.`f_type` AS `f_type`,`teacher`.`t_id` AS `t_id`,`teacher`.`t_name` AS `t_name`,`student`.`s_name` AS `s_name`,`select_title`.`seltitl_state` AS `seltitl_state`,`title`.`titl_name` AS `titl_name`,`student`.`major` AS `major`,`student`.`batch` AS `batch` from (((((`mid_check` join `myfile` on((`mid_check`.`f_id` = `myfile`.`f_id`))) join `teacher`) join `student` on((`mid_check`.`s_id` = `student`.`s_id`))) join `select_title` on((`select_title`.`s_id` = `mid_check`.`s_id`))) join `title` on(((`select_title`.`titl_id` = `title`.`titl_id`) and (`title`.`t_id` = `teacher`.`t_id`))));

-- ----------------------------
-- View structure for openreportinfo
-- ----------------------------
DROP VIEW IF EXISTS `openreportinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `openreportinfo` AS select `open_report`.`r_id` AS `r_id`,`open_report`.`f_id` AS `f_id`,`open_report`.`s_id` AS `s_id`,`open_report`.`agree` AS `agree`,`myfile`.`f_name` AS `f_name`,`myfile`.`f_path` AS `f_path`,`myfile`.`upload_datetime` AS `upload_datetime`,`myfile`.`f_type` AS `f_type`,`teacher`.`t_id` AS `t_id`,`teacher`.`t_name` AS `t_name`,`student`.`s_name` AS `s_name`,`select_title`.`seltitl_state` AS `seltitl_state`,`title`.`titl_name` AS `titl_name`,`student`.`major` AS `major`,`student`.`batch` AS `batch` from (((((`open_report` join `myfile` on((`open_report`.`f_id` = `myfile`.`f_id`))) join `teacher`) join `student` on((`open_report`.`s_id` = `student`.`s_id`))) join `select_title` on((`select_title`.`s_id` = `open_report`.`s_id`))) join `title` on(((`select_title`.`titl_id` = `title`.`titl_id`) and (`title`.`t_id` = `teacher`.`t_id`))));

-- ----------------------------
-- View structure for projbookinfo
-- ----------------------------
DROP VIEW IF EXISTS `projbookinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `projbookinfo` AS select `proj_book`.`p_id` AS `p_id`,`proj_book`.`f_id` AS `f_id`,`proj_book`.`s_id` AS `s_id`,`proj_book`.`agree` AS `agree`,`myfile`.`f_name` AS `f_name`,`myfile`.`f_path` AS `f_path`,`myfile`.`upload_datetime` AS `upload_datetime`,`myfile`.`f_type` AS `f_type`,`teacher`.`t_id` AS `t_id`,`teacher`.`t_name` AS `t_name`,`student`.`s_name` AS `s_name`,`select_title`.`seltitl_state` AS `seltitl_state`,`title`.`titl_name` AS `titl_name`,`student`.`major` AS `major`,`student`.`batch` AS `batch` from (((((`proj_book` join `myfile` on((`proj_book`.`f_id` = `myfile`.`f_id`))) join `teacher`) join `student` on((`proj_book`.`s_id` = `student`.`s_id`))) join `select_title` on((`select_title`.`s_id` = `proj_book`.`s_id`))) join `title` on(((`select_title`.`titl_id` = `title`.`titl_id`) and (`title`.`t_id` = `teacher`.`t_id`))));

-- ----------------------------
-- View structure for reviewscore
-- ----------------------------
DROP VIEW IF EXISTS `reviewscore`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `reviewscore` AS select `thesisinfo`.`f_id` AS `f_id`,`review`.`review_score` AS `review_score`,`review`.`review_comments` AS `review_comments`,`review`.`reply_id` AS `reply_id`,`thesisinfo`.`agree` AS `agree`,`review`.`member_t_id` AS `member_t_id`,`thesisinfo`.`t_id` AS `t_id`,`thesisinfo`.`titl_name` AS `titl_name`,`thesisinfo`.`major` AS `major`,`thesisinfo`.`batch` AS `batch`,`thesisinfo`.`titl_id` AS `titl_id`,`thesisinfo`.`s_name` AS `s_name`,`thesisinfo`.`t_name` AS `t_name`,`thesisinfo`.`f_name` AS `f_name`,`teacher`.`t_name` AS `member_t_name`,`review`.`review_type` AS `review_type`,`reply_group`.`reply_leader` AS `reply_leader`,`thesisinfo`.`s_id` AS `s_id`,`select_title`.`reply_score` AS `reply_score` from ((((`thesisinfo` join `review` on((`review`.`s_id` = `thesisinfo`.`s_id`))) join `teacher` on((`review`.`member_t_id` = `teacher`.`t_id`))) join `reply_group` on((`review`.`reply_id` = `reply_group`.`reply_id`))) join `select_title` on(((`select_title`.`s_id` = `thesisinfo`.`s_id`) and (`select_title`.`titl_id` = `thesisinfo`.`titl_id`))));

-- ----------------------------
-- View structure for seltitleinfo
-- ----------------------------
DROP VIEW IF EXISTS `seltitleinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `seltitleinfo` AS select `title`.`titl_id` AS `titl_id`,`title`.`titl_name` AS `titl_name`,`title`.`t_id` AS `t_id`,`title`.`titl_source` AS `titl_source`,`title`.`titl_type` AS `titl_type`,`title`.`titl_describe` AS `titl_describe`,`title`.`titl_state` AS `titl_state`,`title`.`sel_state` AS `sel_state`,`select_title`.`seltitl_state` AS `seltitl_state`,`teacher`.`t_name` AS `t_name`,`select_title`.`s_id` AS `s_id`,`title`.`major` AS `major`,`student`.`s_name` AS `s_name` from (((`title` join `select_title` on((`select_title`.`titl_id` = `title`.`titl_id`))) join `teacher` on((`title`.`t_id` = `teacher`.`t_id`))) join `student` on((`select_title`.`s_id` = `student`.`s_id`)));

-- ----------------------------
-- View structure for ss
-- ----------------------------
DROP VIEW IF EXISTS `ss`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `ss` AS select `select_title`.`s_id` AS `s_id`,`select_title`.`titl_id` AS `titl_id`,`select_title`.`t_score` AS `t_score`,`select_title`.`t_comments` AS `t_comments`,`select_title`.`reply_score` AS `reply_score`,`select_title`.`reply_comments` AS `reply_comments`,`select_title`.`seltitl_state` AS `seltitl_state`,`student`.`s_name` AS `s_name`,`student`.`s_pwd` AS `s_pwd`,`student`.`s_class` AS `s_class`,`student`.`sex` AS `sex`,`student`.`age` AS `age`,`student`.`dept` AS `dept`,`student`.`major` AS `major`,`student`.`phone` AS `phone`,`student`.`email` AS `email`,`student`.`batch` AS `batch` from (`select_title` join `student` on((`student`.`s_id` = `select_title`.`s_id`)));

-- ----------------------------
-- View structure for sss
-- ----------------------------
DROP VIEW IF EXISTS `sss`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `sss` AS select `teacher`.`t_name` AS `t_name`,`title`.`titl_id` AS `titl_id`,`title`.`titl_name` AS `titl_name`,`title`.`t_id` AS `t_id`,`title`.`titl_source` AS `titl_source`,`title`.`titl_type` AS `titl_type`,`title`.`titl_describe` AS `titl_describe`,`title`.`titl_state` AS `titl_state`,`title`.`sel_state` AS `sel_state`,`title`.`major` AS `major` from (`title` join `teacher` on((`title`.`t_id` = `teacher`.`t_id`)));

-- ----------------------------
-- View structure for studentscore
-- ----------------------------
DROP VIEW IF EXISTS `studentscore`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `studentscore` AS select `title`.`titl_name` AS `titl_name`,`select_title`.`reply_comments` AS `reply_comments`,`select_title`.`reply_score` AS `reply_score`,`select_title`.`t_comments` AS `t_comments`,`select_title`.`t_score` AS `t_score`,`select_title`.`seltitl_state` AS `seltitl_state`,`select_title`.`titl_id` AS `titl_id`,`select_title`.`s_id` AS `s_id`,`teacher`.`t_id` AS `t_id`,`teacher`.`t_name` AS `t_name`,`student`.`s_name` AS `s_name`,`student`.`batch` AS `batch`,`student`.`major` AS `major` from (((`select_title` join `title` on((`title`.`titl_id` = `select_title`.`titl_id`))) join `teacher` on((`teacher`.`t_id` = `title`.`t_id`))) join `student` on((`select_title`.`s_id` = `student`.`s_id`)));

-- ----------------------------
-- View structure for thesisattachmentinfo
-- ----------------------------
DROP VIEW IF EXISTS `thesisattachmentinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `thesisattachmentinfo` AS select `teacher`.`t_id` AS `t_id`,`teacher`.`t_name` AS `t_name`,`title`.`titl_name` AS `titl_name`,`select_title`.`seltitl_state` AS `seltitl_state`,`thesis_attachment`.`a_id` AS `a_id`,`thesis_attachment`.`f_id` AS `f_id`,`thesis_attachment`.`s_id` AS `s_id`,`student`.`s_name` AS `s_name`,`student`.`s_class` AS `s_class`,`student`.`major` AS `major`,`myfile`.`f_name` AS `f_name`,`myfile`.`f_path` AS `f_path`,`myfile`.`upload_datetime` AS `upload_datetime`,`myfile`.`f_type` AS `f_type`,`student`.`batch` AS `batch` from (((((`thesis_attachment` join `student` on((`student`.`s_id` = `thesis_attachment`.`s_id`))) join `myfile` on((`myfile`.`f_id` = `thesis_attachment`.`f_id`))) join `select_title` on((`thesis_attachment`.`s_id` = `select_title`.`s_id`))) join `title` on((`select_title`.`titl_id` = `title`.`titl_id`))) join `teacher` on((`title`.`t_id` = `teacher`.`t_id`)));

-- ----------------------------
-- View structure for thesisinfo
-- ----------------------------
DROP VIEW IF EXISTS `thesisinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `thesisinfo` AS select `thesis`.`thesis_id` AS `thesis_id`,`thesis`.`f_id` AS `f_id`,`thesis`.`s_id` AS `s_id`,`thesis`.`agree` AS `agree`,`thesis`.`titl_id` AS `titl_id`,`myfile`.`f_name` AS `f_name`,`myfile`.`f_path` AS `f_path`,`myfile`.`upload_datetime` AS `upload_datetime`,`myfile`.`f_type` AS `f_type`,`teacher`.`t_id` AS `t_id`,`teacher`.`t_name` AS `t_name`,`student`.`s_name` AS `s_name`,`select_title`.`seltitl_state` AS `seltitl_state`,`title`.`titl_name` AS `titl_name`,`student`.`major` AS `major`,`student`.`batch` AS `batch` from (((((`thesis` join `myfile` on((`thesis`.`f_id` = `myfile`.`f_id`))) join `teacher`) join `student` on((`thesis`.`s_id` = `student`.`s_id`))) join `select_title` on((`select_title`.`s_id` = `thesis`.`s_id`))) join `title` on(((`select_title`.`titl_id` = `title`.`titl_id`) and (`title`.`t_id` = `teacher`.`t_id`))));

-- ----------------------------
-- View structure for titleinfo
-- ----------------------------
DROP VIEW IF EXISTS `titleinfo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `titleinfo` AS select `teacher`.`t_name` AS `t_name`,`title`.`titl_id` AS `titl_id`,`title`.`titl_name` AS `titl_name`,`title`.`t_id` AS `t_id`,`title`.`titl_source` AS `titl_source`,`title`.`titl_type` AS `titl_type`,`title`.`titl_describe` AS `titl_describe`,`title`.`titl_state` AS `titl_state`,`title`.`sel_state` AS `sel_state`,`title`.`major` AS `major` from (`title` join `teacher` on((`teacher`.`t_id` = `title`.`t_id`)));

SET FOREIGN_KEY_CHECKS = 1;
