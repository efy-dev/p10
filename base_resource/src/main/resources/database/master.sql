/*****************已同步sql***********************/

DROP TABLE IF EXISTS `master_work`;
CREATE TABLE `master_work` (
  `id` char(16) NOT NULL DEFAULT '',
  `name` varchar(32) DEFAULT NULL,
  `serial` varchar(32) DEFAULT NULL,
  `picture_url` varchar(128) DEFAULT NULL,
  `tenant_id` char(16) DEFAULT NULL,
  `category_id` char(16) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `product_description_id` char(16) DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `project_id` char(16) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL COMMENT '添加创建时间和修改时间',
  `create_datetime` datetime DEFAULT NULL,
  `sort` int(16) DEFAULT NULL,
  `recommended_index` int(5) DEFAULT NULL,
  `master_id` char(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of master_work
-- ----------------------------
INSERT INTO `master_work` VALUES ('001', '青花瓷', '12', 'background/favicon.png', '1', '001', '1000', '1', '1', '001', '2015-07-03 14:55:44', '2015-08-17 17:34:38', null, null, '91', '100001');
INSERT INTO `master_work` VALUES ('002', '青铜器', '13', 'background/favicon.png', '1', '001', '10000', 'icii8mhq00009vvg', '1', '001', '2015-08-18 17:34:30', '2015-08-17 17:34:34', null, null, '92', null);
INSERT INTO `master_work` VALUES ('003', '刺绣', '', '', 'id02jtsd0000c5t1', '001', '3', '100000000008', '1', '001', '2015-08-06 16:33:18', '2015-08-06 16:34:11', '2015-08-06 16:34:23', null, '30', null);
INSERT INTO `master_work` VALUES ('100000000009', '青铜器', null, 'background/favicon.png', '1', '001', '555', null, '1', '001', '2015-07-02 14:56:41', null, null, null, '93', null);
INSERT INTO `master_work` VALUES ('100002', '2', null, 'background/favicon.png', '1', '001', '452', null, '0', '001', null, null, null, null, '50', null);
INSERT INTO `master_work` VALUES ('13', '2', null, 'background/favicon.png', '1', '001', '288', null, '1', '001', null, null, null, null, '60', null);
INSERT INTO `master_work` VALUES ('14', '2', null, null, '1', '001', '388', null, '0', '002', null, null, null, null, '70', null);
INSERT INTO `master_work` VALUES ('15', '2', null, 'background/favicon.png', '1', '001', '388', null, '0', '002', null, null, null, null, '80', null);
INSERT INTO `master_work` VALUES ('16', '2', null, null, '1', '001', '588', null, '0', '002', null, null, null, null, '90', null);
INSERT INTO `master_work` VALUES ('17', '2', null, null, '1', '001', '699', null, '0', '006', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('18', '2', null, null, '1', '001', '1000', null, '0', '008', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('19', '2', null, null, '1', '001', '599', null, '0', '009', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('2', '2', '2', '2', '2', '001', '2', '2', '0', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('20', '2', null, null, '1', '001', null, null, '0', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('21', '2', null, null, '1', '001', null, null, '0', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('22', '2', null, null, '1', '001', null, null, '0', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('23', '2', null, null, '1', '001', null, null, '0', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('24', '2', null, null, '1', '001', null, null, '0', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('4', '2', null, null, '1', '001', null, null, '0', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('5', '2', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('6', '2', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('7', '2', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('dfg', '2', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('dv', '2', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibsqmoof0000ip3s', '12345678', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibu4n4ue0000gz6h', '哈哈哈', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibu9prre00009msf', '哈哈哈', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibu9q2r700004q73', '哈哈哈', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibucelbd0000ksn0', '哈哈哈', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibucn4530000kwk9', 'jhlkhhk', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibudctls00007zn6', 'qwedsa', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibvj2jdg000079hu', 'hahaha', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibvj4xtw0000ei4k', '哈哈哈哈', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ibvjzslc00009gg7', 'hahaha', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ic78ayqi0000dfqz', '111', null, null, '1', '001', '111', null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ic78enkv0000962p', 'zzc', null, null, '1', '001', '123', null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ic7kk2tj000008md', '123', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ic7lcyea00005rnt', '111', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ic7ljm180000c240', '111', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ic7ll3pe0000b3fa', '111', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icbwl0dm00007r84', '1', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icbwmbuq0000jyn1', '1', null, null, '1', '001', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ice4dp8e00005f12', '123', null, null, 'icbneztn000049jb', '001', '123', null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ice4p8360000kxix', '123123', null, 'work/icbneztn000049jb/img2.png', 'icbneztn000049jb', '001', '123123', 'ice4pkw60000chsa', '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ice4ukrp00006zzn', '123123', null, 'work/icbneztn000049jb/img2.png', 'icbneztn000049jb', '001', '13123', 'ice4ukrs0000e4vj', '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ice4zr0d000002x3', '123123', null, 'work/icbneztn000049jb/img2.png', 'icbneztn000049jb', '001', '123123', 'ice4zr0r00006qlb', '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ice7gns10000267w', '123123', null, 'work/icbneztn000049jb/QQ图片20150721115521.png', 'icbneztn000049jb', '001', '123123', 'ice7gns20000atsb', '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icfj2chu00005j4b', '123123123', null, 'work//img2.png', '1', '001', null, 'icfj2cid00001wy6', '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icfjbgri000060za', '123123', null, 'work/icbneztn000049jb/img2.png', 'icbneztn000049jb', '001', null, 'icfjbgs40000e9oe', '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icfjfl6700001p2m', '123123', null, 'work/icbneztn000049jb/img2.png', 'icbneztn000049jb', '001', null, 'icfjfl6900006tcc', '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icimw12k00008pzc', '123123', null, 'work/1/', '1', '001', '123123', 'icintqg600008n32', '1', 'ichkz9tj0000685c', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icis4akz00006kbc', 'dadadd', null, null, '1', '001', '22', 'icis4al600002t8z', '1', '2', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icis8h3p0000b0df', '123', null, 'work/1/QQ图片20150721115521.png', '1', '001', '123123', 'icis8h3v0000blly', '1', 'ichkz9tj0000685c', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icisf6c700004z0n', 'ddss', null, 'background/favicon.png', '1', '001', '11', 'icisf6cg0000k1aq', '1', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icisg2ho0000eayg', 'dd', null, null, '1', '001', '22', 'icitq3hi0000b1sq', '1', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icisk66w00008cfp', 'ddss', null, 'background/favicon.png', '1', '001', '2', 'icisk66x0000618p', '1', 'ichk98ii0000b77k', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icislpy4000005o0', 'ddss', null, 'background/favicon.png', '1', '001', '2', 'icislpy400005rl8', '1', 'ichk98ii0000b77k', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icisr9xc0000gzue', 'fdfd', null, null, '1', '001', '33', 'icisr9xd0000h0kk', '1', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icisue2x0000jl2g', 'ss', null, 'background/favicon.png', '1', '001', '1', 'icisue3300000d41', '1', 'ichk98ii0000b77k', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icittmo900004kwr', 'dadadd', null, null, '1', '001', null, 'icittmoa0000ae4y', '0', 'ichk98ii0000b77k', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icitx5x100002egr', 'aaag', null, null, '1', '001', null, 'iciz8jsq000088s2', '0', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iciu0dg90000cbpy', 'zzz', null, null, '1', '001', null, 'iciu0t570000kag8', '0', 'ichk98ii0000b77k', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iciv13f90000eyno', 'sf', null, null, '1', '001', null, 'iciv13fg0000dicz', '0', 'ichk98ii0000b77k', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icivhgaj0000bsni', 'ffffdddddddddddddd', null, null, '1', '001', null, 'icivhw7p00009uta', '0', 'ichk98ii0000b77k', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iciz9e2k0000gezn', '测试作品', null, 'background/favicon.png', '1', '001', null, 'iciz9e2l000097h3', '0', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icjzs6oc0000jh7x', '123', null, 'work/1/QQ图片20150721115521.png', '1', '001', '1231', 'icimv2le0000eg67', '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('ickb5lj60000e78f', 's', null, 'background/favicon.png', '1', '001', null, 'ickb5lj60000340j', '0', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icmqgysk0000aw46', '西游记', null, 'work/icmpc22600003fhj/233389.jpg', 'icmpc22600003fhj', '001', null, 'icmynuj30000jqsz', '0', 'icjzs6oc0000jh7x', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icqzvows0000h6a3', 'tttt', null, 'work/icmpc22600003fhj/233389.jpg', 'icmpc22600003fhj', '001', null, 'icqzvowt0000jja6', '4', 'icjzs6oc0000jh7x', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icwzr0530000de', 'gg', null, null, '1', '001', '44', 'icisx4fb0000kn6r', '0', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icwzr0530000dei1', '电商测试项目', null, null, 'icmpc22600003fhj', 'ibx1qaz200009cp2', null, null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icwzr0530000deiw', 'ssss', null, 'work/icmpc22600003fhj/233389.jpg', 'icmpc22600003fhj', '001', null, 'icqzwd750000copu', '0', 'ichk6qsi0000frl6', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iczmdn8j0000fey5', 'ds', null, null, 'icmpc22600003fhj', '001', null, 'iczmdn8j0000csgt', '0', 'icjzs6oc0000jh7x', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iczseq8e000066u1', 'yy', null, null, 'icmpc22600003fhj', '001', null, 'iczseq8f0000lbz1', '0', 'icjzs6oc0000jh7x', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('icztrk8z0000f3tb', 'gf', null, 'work/icmpc22600003fhj/233389.jpg', 'icmpc22600003fhj', '001', null, 'icztrk9a00008nox', '0', 'icjzs6oc0000jh7x', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iczvqmey0000g29k', 'eess', null, null, 'iciyn39o0000cykr', '001', null, 'iczwfj6h0000azki', '0', 'icjzs6oc0000jh7x', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iczvxy8y0000dyrm', 'ww', null, null, 'iciyn39o0000cykr', '001', null, 'iczvxy940000bnol', '0', 'icjzs6oc0000jh7x', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iczwg6yo0000hrzu', 's', null, null, 'iciyn39o0000cykr', '001', null, 'iczwg6yp0000ld74', '0', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('iczxoocb0000bjz5', 'ee', null, null, 'iciyn39o0000cykr', '001', null, 'iczxoocc00002dt7', '1', 'icinve5e0000bw6a', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('id0358ie00006f2s', '普哦吧的的的', null, null, 'id02jtsd0000c5t1', '001', null, 'id037a6l00000xir', '0', 'icfy2sao0000adyk', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('id03bty40000h0tb', '滴滴顺风车', null, null, 'id02jtsd0000c5t1', '001', null, 'id03e81r00007932', '0', 'icfy2sao0000adyk', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('id17yjc40000khw9', '22', null, 'product/20150812164422.jpg', 'iciyn39o0000cykr', '001', null, 'id17yjcc00000t4l', '0', 'icjzs6oc0000jh7x', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('id17yydj000099k4', '毛笔', null, 'product/20150816164421.jpg', 'iciyn39o0000cykr', '001', '1000', 'id17yydk0000h48l', '1', 'ichky55b00000ubs', null, null, null, null, null, '100001');
INSERT INTO `master_work` VALUES ('id17zvcc0000deyp', '微软', null, 'product/20150816164422.jpg', 'iciyn39o0000cykr', '001', '888', 'id17zvcd0000doqj', '1', 'ichky55b00000ubs', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('id180bup00006kax', '百度', null, 'product/20150817164421.jpg', 'iciyn39o0000cykr', '001', '25000', 'id180bup0000jmnf', '1', 'ichky55b00000ubs', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('id18z5z200008d82', '水瓶', null, 'product/20150817164423.jpg', 'iciyn39o0000cykr', '001', '1000', 'id18z5z900002s9e', '1', 'ichky55b00000ubs', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('id1facnc00000jyb', '金山', null, 'product/20150817164423.jpg', 'id02jtsd0000c5t1', '001', '999', 'id1fasly0000himg', '1', 'ichky55b00000ubs', null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('idjj6myc0000ewsn', 'hot summer', null, 'work/20150817164424.jpg', null, null, null, 'idjj6myd0000dsiq', '1', 'ichk98ii0000b77k', null, null, null, null, null, 'idjixy3x000085yn');
INSERT INTO `master_work` VALUES ('idjzvdrd2vdon8jg', 'ss', 'ss', null, null, null, '1', null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('idjzz35b19768lo1', 'ddddddddddd', 'dd', null, null, null, '22', null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('idkz861r5ehhcnue', '    金箍棒', '0000001', null, 'icmpc22600003fhj', null, '11', null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('idkzan7r26y1hlvq', '青龙偃月刀', '000002', null, 'icmpc22600003fhj', null, '11', null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('idkzc7g33cfesw37', '青釭剑', '000003', null, 'icmpc22600003fhj', null, '11', null, '1', null, null, null, null, null, null, null);
INSERT INTO `master_work` VALUES ('idl22t9h189v5r96', '6', '6', null, null, null, '6', null, '1', null, null, null, null, null, null, null);


DROP TABLE IF EXISTS `master_work_picture`;
CREATE TABLE `master_work_picture` (
  `id` char(16) NOT NULL DEFAULT '',
  `product_id` char(16) NOT NULL,
  `picture_url` varchar(128) NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of master_work_picture
-- ----------------------------
INSERT INTO `master_work_picture` VALUES ('1', '1', '/scripts/assets/images/img14.jpg', '1');
INSERT INTO `master_work_picture` VALUES ('ice75jnh0000gc1e', 'ice4zr0d000002x3', 'work/icbneztn000049jb/ice4zr0d000002x3/img2.png', '1');
INSERT INTO `master_work_picture` VALUES ('ice774hg00006i1c', 'ice4zr0d000002x3', 'work/icbneztn000049jb/ice4zr0d000002x3/img2.png', '1');
INSERT INTO `master_work_picture` VALUES ('ice77d7v000092d5', 'ice4zr0d000002x3', 'work/icbneztn000049jb/ice4zr0d000002x3/QQ图片20150716112636.png', '1');
INSERT INTO `master_work_picture` VALUES ('icms7dox000077mk', 'icmqgysk0000aw46', 'work/icmpc22600003fhj/icmqgysk0000aw46/233389.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('icmynewg0000gjsn', 'icmqgysk0000aw46', 'work/icmpc22600003fhj/icmqgysk0000aw46/233389.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('icmyoa53000009y0', 'icmqgysk0000aw46', 'work/icmpc22600003fhj/icmqgysk0000aw46/233389.jpg', '1');
INSERT INTO `master_work_picture` VALUES ('iczw24sy000041kz', 'iczvqmey0000g29k', 'work/iciyn39o0000cykr/iczvqmey0000g29k/', '0');
INSERT INTO `master_work_picture` VALUES ('iczw29v000000nsw', 'iczvqmey0000g29k', 'work/iciyn39o0000cykr/iczvqmey0000g29k/', '0');
INSERT INTO `master_work_picture` VALUES ('ididy4iq0000d5vk', 'id1facnc00000jyb', 'product/3f0047d7848d572518527ec093a55c4420150819141542.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idie6wwx00002g4p', 'id1facnc00000jyb', 'product/3f0047d7848d572518527ec093a55c4420150819142232.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idie93gn0000ex5t', 'id1facnc00000jyb', 'product/3f0047d7848d572518527ec093a55c4420150819142414.jpg', '1');
INSERT INTO `master_work_picture` VALUES ('idigavkf00008hfv', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819152104.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idigbnrf0000jsuq', 'id17zvcc0000deyp', 'product/026f64c1b254766e7a5e7b101011ae8c20150819152211.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idigbzrv0000fjg4', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819152215.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idighsgj00000hc9', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819152658.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idighuid0000l0xm', 'id17zvcc0000deyp', 'product/026f64c1b254766e7a5e7b101011ae8c20150819152701.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idighyfw00002vdy', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819152702.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idigi4ze00002g31', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819152711.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idigt4lz00001m04', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819153544.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idigtbiw0000eye0', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819153556.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idigzwom0000aeja', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819154104.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idigzwvb00007tfg', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819154104.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idih8jfp0000g9qj', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819154746.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idih8js7000077y7', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819154747.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idih8kfy00009zyy', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819154747.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiibmt500007xdf', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819161810.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiibn0a0000ccuy', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819161811.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiibn67000028n4', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819161811.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiieb350000jtpt', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819162015.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiiecaa0000kizg', 'id17zvcc0000deyp', 'product/026f64c1b254766e7a5e7b101011ae8c20150819162016.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiieesb0000cth6', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819162017.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiief0200004yaq', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819162020.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiipnh700006f1j', 'id17zvcc0000deyp', 'product/bd670fb0b27d02ab1e891aa1b50da71720150819162901.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiiprxz00002ovk', 'id17zvcc0000deyp', 'product/7ade3e9f755d338c31472b3dde0231e020150819162909.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiipzrs0000b5mn', 'id17zvcc0000deyp', 'product/026f64c1b254766e7a5e7b101011ae8c20150819162917.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idiiqdwm0000eihe', 'id17zvcc0000deyp', 'product/43acca4c3305b4e976acad640a044c8120150819162935.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idij0gsx00001d70', 'id17zvcc0000deyp', 'product/43acca4c3305b4e976acad640a044c8120150819163729.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idij0jiy0000bpwh', 'id17zvcc0000deyp', 'product/148b1463b1976d15a531e7607cee231720150819163733.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idik3pb800000euh', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819170756.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idik5gzp0000cdd8', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819170919.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idim1nh000007psk', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819180223.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idim3cd60000ecm5', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819180342.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idim3cjv0000ejrh', 'id17zvcc0000deyp', 'product/7ade3e9f755d338c31472b3dde0231e020150819180342.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idim3cqs00000uu1', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819180343.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimc2li0000kotu', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819181029.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimc30g0000ffcl', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819181030.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimevnk000040eo', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819181240.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimevvq0000e7su', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819181241.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimew900000bs79', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819181241.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimh2kh000049ti', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819181423.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimh2rk0000i8wd', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819181423.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimh2xm00005ahp', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819181423.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimior3000087as', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819181538.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimiox400009dre', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819181538.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimip250000eryj', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819181539.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimmftg00005n23', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819181833.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimmfyl00003eci', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819181833.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimop230000640c', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819182018.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimoppf0000capa', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819182019.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimsviy00001f4a', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819182333.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimwn1r00003rb4', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819182625.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idimydwv0000342m', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819182748.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idin1ccy0000kfi3', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819183008.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idin3f470000279t', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819183145.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idin3rfm0000epec', 'id17zvcc0000deyp', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150819183201.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idin437a000082b8', 'id17zvcc0000deyp', 'product/1213965148102714_file20150819183215.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idio7quh0000auf6', 'id17zvcc0000deyp', 'product/3f0047d7848d572518527ec093a55c4420150819190307.jpg', '2');
INSERT INTO `master_work_picture` VALUES ('idjj75pl00004qu3', 'idjj6myc0000ewsn', 'work/idjixy3x000085yn/idjj6myc0000ewsn/798b00b003ea71f1c7bbdebeb1f1d7e9.jpg', '1');
INSERT INTO `master_work_picture` VALUES ('idkzdvajbl5twzby', 'idkzc7g33cfesw37', 'product/3f0047d7848d572518527ec093a55c4420150821095119.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkze20uou4xff8o', 'idkzc7g33cfesw37', 'product/026f64c1b254766e7a5e7b101011ae8c20150821095129.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkze28x27u2u9r3', 'idkzc7g33cfesw37', 'product/1213965148102714_file20150821095130.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkze8933f2t9jtp', 'idkzc7g33cfesw37', 'product/3f0047d7848d572518527ec093a55c4420150821095137.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkzsgbr47wril2y', 'idkzc7g33cfesw37', 'product/3f0047d7848d572518527ec093a55c4420150821100241.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkzsgs01txt6bj1', 'idkzc7g33cfesw37', 'product/026f64c1b254766e7a5e7b101011ae8c20150821100241.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkzsh6j7pd2fjip', 'idkzc7g33cfesw37', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150821100242.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkzshm57sadxhbc', 'idkzc7g33cfesw37', 'product/1213965148102714_file20150821100242.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkzsokk6rffaajt', 'idkzc7g33cfesw37', 'product/3f0047d7848d572518527ec093a55c4420150821100252.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkzsp0lx6m06qhf', 'idkzc7g33cfesw37', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150821100252.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idkzspfx2lwxvcu3', 'idkzc7g33cfesw37', 'product/1213965148102714_file20150821100253.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idl2ca962fijcydk', 'idkzc7g33cfesw37', 'product/3f0047d7848d572518527ec093a55c4420150821111405.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idl2cafdgcyo4uqb', 'idkzc7g33cfesw37', 'product/798b00b003ea71f1c7bbdebeb1f1d7e920150821111406.jpg', '0');
INSERT INTO `master_work_picture` VALUES ('idl2calf3hdns2pi', 'idkzc7g33cfesw37', 'product/1213965148102714_file20150821111406.jpg', '0');


ALTER TABLE `tenant`
ADD COLUMN `tenant_type`  varchar(2) NULL AFTER `logo_url`;


CREATE TABLE `tenant_enterprise` (
`id`  char(16) NOT NULL
)
;


CREATE TABLE `tenant_private` (
`id`  char(16) NOT NULL
)
;


CREATE TABLE `tenant_personal` (
`id`  char(16) NOT NULL
)
;



----------------------------------------------
--2015-8-26 曹廷杰 修改优惠券和优惠券批次 表名 未执行
--------------------------------------
ALTER TABLE coupon RENAME TO purchase_coupon;
ALTER TABLE coupon_batch RENAME TO purchase_coupon_batch;
----------------------------------------------
--2015-8-27 杨洪全 暂时增加一个物流公司的字段 可能要改为实体类、
ALTER TABLE `purchase_order_delivery`
ADD COLUMN `logistics_company`  varchar(64) NOT NULL AFTER `status`;
-------------------------------------------------------------------
--2015-8-29 赵志崇 修改tenant表字段 未执行
ALTER TABLE `tenant`
DROP COLUMN `origin_province_id`,
DROP COLUMN `full_name`,
DROP COLUMN `brief`,
DROP COLUMN `title`,
DROP COLUMN `favicon`,
DROP COLUMN `sex`,
DROP COLUMN `present_address`,
DROP COLUMN `level`,
DROP COLUMN `background_url`,
DROP COLUMN `birthday`,
ADD COLUMN `identity`  char(18) NULL AFTER `tenant_type`,
ADD COLUMN `front_photo_url`  varchar(255) NULL AFTER `identity`,
ADD COLUMN `verso_photo_url`  varchar(255) NULL AFTER `front_photo_url`,
ADD COLUMN `address_province_id`  varchar(255) NULL AFTER `verso_photo_url`;
-- ADD COLUMN `operator_name`  varchar(25) NULL AFTER `address_province_id`,
-- ADD COLUMN `in_date_begin`  datetime NULL AFTER `operator_name`,
-- ADD COLUMN `in_date_end`  datetime NULL AFTER `in_date_begin`,
-- ADD COLUMN `business_scope`  varchar(255) NULL AFTER `in_date_end`,
-- ADD COLUMN `business_license`  varchar(255) NULL AFTER `business_scope`,
-- ADD COLUMN `tax_registration_attachment`  varchar(255) NULL AFTER `business_license`,
-- ADD COLUMN `registered_assets`  varchar(255) NULL AFTER `tax_registration_attachment`,
-- ADD COLUMN `organization_attachment`  varchar(255) NULL AFTER `registered_assets`,
-- ADD COLUMN `bank_attachment`  varchar(255) NULL AFTER `organization_attachment`;

-------------------------------------------------------------------------------------------
--2015-8-29 赵志崇 tenant_enterprise 未执行
ALTER TABLE `tenant_enterprise`
ADD COLUMN `registered_assets`  varchar(255) NULL AFTER `id`,
ADD COLUMN `legal_name`  varchar(255) NULL AFTER `registered_assets`,
ADD COLUMN `organization_attachment`  varchar(255) NULL AFTER `registered_assets`,
ADD COLUMN `bank_attachment`  varchar(255) NULL AFTER `organization_attachment`,
ADD COLUMN `business_license`  varchar(255) NULL AFTER `bank_attachment`,
ADD COLUMN `business_scope`  varchar(255) NULL AFTER `bank_attachment`,
ADD COLUMN `tax_registration_attachment`  varchar(255) NULL AFTER `business_license`;

-------------------------------------------------------------------------------------------
--2015-8-29 赵志崇 tenant_enterprise 未执行

ALTER TABLE `tenant_personal`
ADD COLUMN `identity_photo_url`  char(18) NULL AFTER `id`;



ALTER TABLE `tenant_private`
ADD COLUMN `operator_name`  varchar(255) NULL AFTER `id`,
ADD COLUMN `indate_begin`  datetime NULL AFTER `operator_name`,
ADD COLUMN `indate_end`  datetime NULL AFTER `indate_begin`,
ADD COLUMN `business_scope`  varchar(255) NULL AFTER `indate_end`,
ADD COLUMN `business_license`  varchar(255) NULL AFTER `business_scope`,
ADD COLUMN `tax_registration_attachment`  varchar(255) NULL AFTER `business_license`;


-------------------------------------------------------------------------------------------
CREATE TABLE `base_auto_serial` (
	`id` varchar(50) NOT NULL COMMENT '0',
	`serial` bigint(10) NULL COMMENT '0',
	`groupName` varchar(25) NULL COMMENT '0',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `core_p_auto_serial` (
	`id` varchar(50) NOT NULL,
	`serial` bigint(10) NULL,
	`groupName` varchar(25) NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB;4


CREATE TABLE `tenant_master` (
`id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`tenant_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`master_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`status`  char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`id`)
)
;

=================================================以上 已执行======================================================


ALTER TABLE `tenant`
ADD COLUMN `address_city_id`  char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `create_datetime`;


ALTER TABLE `tenant`
ADD COLUMN `serial`  varchar(32) NULL AFTER `address_city_id`;

ALTER TABLE `tenant_project`
	CHANGE COLUMN `master_id` `project_id` char(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `tenant_id`;

=================================================以上 已执行======================================================
--------------------------------------未执行-------------------------

CREATE TABLE `tenant_category` (
`id`  char(16) NOT NULL ,
`tenant_id`  char(16) NULL ,
`value`  varchar(255) NULL ,
`status`  varchar(2) NULL ,
PRIMARY KEY (`id`)
)
;

ALTER TABLE `product_description`
MODIFY COLUMN `content`  longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL AFTER `id`;

//自定义属性
ALTER TABLE `product_model`
ADD COLUMN `custom_property`  varchar(255) NULL AFTER `product_description_id`;
//设置规格图片
ALTER TABLE `product_picture`
ADD COLUMN `product_model_id`  char(16) NULL AFTER `status`;

ALTER TABLE `project`
	ADD COLUMN `district_id` char(16) NULL AFTER `description`;
=================================================以上 已执行======================================================
--------------------------------------未执行-------------------------
ALTER TABLE `wiki_project_content`
	ADD COLUMN `type` varchar(5) NULL AFTER `create_datetime`,
	ADD COLUMN `project_id` char(16) NOT NULL AFTER `type`,
	ADD COLUMN `city_id` char(16) NULL AFTER `project_id`;

=================================================以上 已执行======================================================
	ALTER TABLE `product_model`
ADD COLUMN `product_picture_id`  char(16) NULL AFTER `custom_property`;
=================================================以上 已执行======================================================
ALTER TABLE `subject`
ADD COLUMN `name`  varchar(255) NULL AFTER `index`;

ALTER TABLE `subject_description`
ADD COLUMN `subject_id`  char(16) NULL AFTER `content`;

ALTER TABLE `subject`
CHANGE COLUMN `index` `subject_index`  int(11) NULL DEFAULT NULL AFTER `status`;

CREATE TABLE `subject_product` (
`id`  char(16) NOT NULL ,
`subject_id`  char(16) NULL ,
`product_id`  char(16) NULL
)
;

ALTER TABLE `tenant`
ADD COLUMN `picture_url`  varchar(255) NULL AFTER `serial`;

CREATE TABLE `project_category_product_model` (
`id`  char(16) NOT NULL ,
`project_category_id`  char(16) NULL ,
`product_model_id`  char(16) NULL ,
`status`  varchar(8) NULL ,
PRIMARY KEY (`id`)
)
;
=================================================以上 已执行======================================================

ALTER TABLE `project`
ADD COLUMN `fansAmout`  bigint(20) NULL AFTER `district_id`;

ALTER TABLE `product`
MODIFY COLUMN `name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `id`,
ADD COLUMN `sub_name`  varchar(255) NULL AFTER `master_id`;

ALTER TABLE `tenant`
ADD COLUMN `address`  varchar(255) NULL AFTER `picture_url`;

----------20150923--------
------20150908-----
----------dev-efc------AC丶man----start
CREATE TABLE `master_message` (
`id`  char(16) NOT NULL ,
`content`  varchar(255) NULL ,
`type`  varchar(2) NULL ,
`master_id`  char(16) NULL ,
`project_id`  char(16) NULL ,
`author`  varchar(255) NULL ,
`create_datetime`  datetime NULL ,
PRIMARY KEY (`id`)
)
;
CREATE TABLE `master_message_attachment` (
  `id`  char(16) NOT NULL ,
  `file_name`  varchar(255) NULL ,
  `picture_url`  varchar(255) NULL ,
  `video_path`  varchar(255) NULL ,
  `master_message_id`  char(16) NULL,
  PRIMARY KEY (`id`)
)
;
----------dev-efc------


------------20150909-------------
----------dev-efc------
CREATE TABLE `master_followed` (
  `id`  char(16) NOT NULL ,
  `master_id`  char(16) NULL ,
  `user_id`  char(16) NULL ,
  `status`  varchar(20) NULL ,
  `create_datetime`  datetime(6) NULL ,
  PRIMARY KEY (`id`)
)
;
---------------20150918--------
----------------dev-efc---------
CREATE TABLE `master_comment` (
  `id`  char(16) NOT NULL ,
  `master_message_id`  char(16) NULL ,
  `content`  varchar(500) NULL ,
  `status`  varchar(20) NULL ,
  `user_id`  char(16) NULL ,
  `create_datetime`  datetime(6) NULL ,
  PRIMARY KEY (`id`)
)
;
-----------20150921-----------
-----------dev-efc------------
CREATE TABLE `master_message_praise` (
  `id`  char(16) NOT NULL ,
  `master_message_id`  char(16) NULL ,
  `user_id`  char(16) NULL ,
  `praise_number`  int NULL ,
  PRIMARY KEY (`id`)
)
;

-----------start-----------
------------20150923----------
ALTER TABLE `master`
ADD COLUMN `fansAmount`  bigint(20) NULL AFTER `master_speech`;
ALTER TABLE `master`
CHANGE COLUMN `fansAmount` `fans_amount`  bigint(20) NULL DEFAULT NULL AFTER `master_speech`;

ALTER TABLE `project`
CHANGE COLUMN `fansAmout` `fans_amount`  bigint(20) NULL DEFAULT NULL AFTER `district_id`;

-----------20150925------------
ALTER TABLE `product`
ADD COLUMN `type`  char(2) NULL AFTER `sub_name`;

--------------20150929---------
ALTER TABLE `master_news`
ADD COLUMN `praise_number`  bigint(20) NULL AFTER `project_id`;
ALTER TABLE `master_message_praise`
DROP COLUMN `praise_number`;

--------------20151008---------
CREATE TABLE `master_message_store` (
  `id`  char(16) NOT NULL ,
  `message_id`  char(16) NULL ,
  `user_id`  char(16) NULL ,
  `status`  varchar(20) NULL ,
  PRIMARY KEY (`id`)
)
;
---------------20151009----------
ALTER TABLE `master_introduction_attachment`
ADD COLUMN `video_path`  varchar(64) NULL AFTER `master_news_id`;

---------------------20151012---------
CREATE TABLE `master_work_praise` (
  `id`  char(16) NOT NULL ,
  `user_id`  char(16) NULL ,
  `work_id`  char(16) NULL ,
  `status`  varchar(20) NULL ,
  `create_datetime`  datetime(6) NULL ,
  PRIMARY KEY (`id`)
)
;
CREATE TABLE `master_work_store` (
  `id`  char(16) NOT NULL ,
  `user_id`  char(16) NULL ,
  `work_id`  char(16) NULL ,
  `status`  varchar(16) NULL ,
  `create_datetime`  datetime(6) NULL ,
  PRIMARY KEY (`id`)
)
;



CREATE TABLE `product_model_record` (
  `id`  char(16) NOT NULL ,
  `amount`  integer(255) NULL ,
  `creator`  varchar(255) NULL ,
  `product_model_id`  char(16) NULL ,
  `create_datetime`  datetime NULL ,
  PRIMARY KEY (`id`)
)
;
ALTER TABLE `product_model_record`
ADD COLUMN `status`  varchar(2) NULL AFTER `create_datetime`;

--------------20151013----------
ALTER TABLE `master_comment`
ADD COLUMN `father_id`  char(16) NULL AFTER `create_datetime`;

ALTER TABLE `master_comment`
ADD COLUMN `comment_number`  int(20) NULL AFTER `father_id`;

ALTER TABLE `master_comment`
ADD COLUMN `master_work_id`  char(16) NULL AFTER `id`;

ALTER TABLE `master_work`
ADD COLUMN `comment_number`  int(20) NULL AFTER `master_id`;

ALTER TABLE `master_work_praise`
ADD COLUMN `comment_id`  char(16) NULL AFTER `create_datetime`;

ALTER TABLE `master_work`
ADD COLUMN `fans_amount`  int(20) NULL AFTER `comment_number`;

ALTER TABLE `master_news`
ADD COLUMN `fans_amount`  int(20) NULL AFTER `type`,
ADD COLUMN `amount`  int(20) NULL AFTER `fans_amount`;

ALTER TABLE `master_message_praise`
ADD COLUMN `comment_id`  char(16) NULL AFTER `user_id`,
ADD COLUMN `status`  varchar(20) NULL AFTER `comment_id`,
ADD COLUMN `create_datetime`  datetime(6) NULL AFTER `status`;

ALTER TABLE `master_message_store`
ADD COLUMN `create_datetime`  datetime(6) NULL AFTER `status`;

---------------------已执行 ------------------------------

ALTER TABLE `purchase_coupon_batch`
ADD COLUMN `type`  char(8) NULL AFTER `picture_url`,
ADD COLUMN `range`  char(8) NULL AFTER `type`,
ADD COLUMN `project_id`  char(16) NULL AFTER `range`,
ADD COLUMN `tenant_id`  char(16) NULL AFTER `project_id`,
ADD COLUMN `product_id`  char(16) NULL AFTER `tenant_id`,
ADD COLUMN `cdkey`  char(128) NULL AFTER `product_id`,
ADD COLUMN `deliver_type`  char(8) NULL AFTER `cdkey`;




CREATE TABLE `advertisement` (
`id`  char(16) NOT NULL ,
`name`  varchar(64) NULL ,
`img`  varchar(255) NULL ,
`redirect`  varchar(255) NULL ,
`order`  int(11) NULL ,
PRIMARY KEY (`id`)
)
;


ALTER TABLE `advertisement`
CHANGE COLUMN `order` `ads_order`  int(11) NULL DEFAULT NULL AFTER `redirect`,
ADD COLUMN `status`  varchar(8) NULL AFTER `ads_order`;

---------------------未执行 ------------------------------

-------------------------------2015-10-27------------------------已执行
alter table purchase_coupon_batch add start_receive_time datetime default null;
alter table purchase_coupon_batch add end_receive_time datetime default null;
alter table purchase_coupon add column isbind char(1);
alter table purchase_coupon add column bind_time datetime;
-------------------------------------------------------------------------





CREATE TABLE `base_document_picture` (
  `id`  char(16) NOT NULL ,
  `document_id`  char(16) NULL ,
  `picture_url`  varchar(255) NULL ,
  PRIMARY KEY (`id`)
)
;
ALTER TABLE `advertisement`
ADD COLUMN `price`  varchar(32) NULL AFTER `status`;

ALTER TABLE `master`
ADD COLUMN `remark`  varchar(50) NULL AFTER `fans_amount`;
=================================
ALTER TABLE `master`
DROP COLUMN `remark`;

ALTER TABLE `master_news`
ADD COLUMN `remark`  varchar(50) NULL AFTER `type`;

CREATE TABLE `base_operation_record` (
  `id`  char(16) NOT NULL ,
  `username`  varchar(255) NULL ,
  `target_name`  varchar(255) NULL ,
  `create_time`  datetime NULL ,
  PRIMARY KEY (`id`)
)
;
ALTER TABLE `base_operation_record`
ADD COLUMN `operation`  varchar(255) NULL AFTER `create_time`;


===========================================2015/11/5=========================================



ALTER TABLE `master_message`
ADD COLUMN `data_source`  varchar(255) NULL AFTER `author`;

ALTER TABLE `master_work`
ADD COLUMN `store_amount`  int(16) NULL AFTER `tenant_id`;

===========================================2015/11/11=========================================

ALTER TABLE `subject`
ADD COLUMN `type`  varchar(255) NULL AFTER `name`,
ADD COLUMN `show`  varchar(255) NULL AFTER `type`,
ADD COLUMN `template`  varchar(255) NULL AFTER `show`,
ADD COLUMN `create_datetime`  datetime NULL AFTER `template`;

ALTER TABLE `product_picture`
ADD COLUMN `sort`  integer(16) NULL AFTER `product_model_id`;

ALTER TABLE `product`
ADD COLUMN `show_datetime`  datetime NULL AFTER `fans_amount`;

ALTER TABLE `project`
ADD COLUMN `context`  varchar(255) NULL AFTER `picture_pc_url`;

ALTER TABLE `advertisement`
ADD COLUMN `group_name`  varchar(255) NULL AFTER `price`;


ALTER TABLE `base_banner`
MODIFY COLUMN `group_name`  varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `direct_url`;

ALTER TABLE `subject`
CHANGE COLUMN `create_datetime` `start_datetime`  datetime NULL DEFAULT NULL AFTER `template`,
ADD COLUMN `end_datetime`  datetime NULL AFTER `start_datetime`;
======================11.16===============================
ALTER TABLE `project_category`
ADD COLUMN `context`  varchar(255) NULL AFTER `picture_url`;

ALTER TABLE `project`
DROP COLUMN `context`;

=======================11.17===================
CREATE TABLE `master_comment_praise` (
  `id`  char(16) NOT NULL ,
  `comment_id`  char(16) NULL ,
  `user_id`  char(16) NULL ,
  `author_id`  char(16) NULL ,
  `create_datetime`  datetime(6) NULL ,
  `status`  varchar(2) NULL ,
  PRIMARY KEY (`id`)
)
;

======================11.18 未同步=======================
ALTER TABLE `advertisement`
ADD COLUMN `wap_redirect`  varchar(255) NULL AFTER `group_name`;

ALTER TABLE `base_banner`
ADD COLUMN `wap_url`  varchar(255) NULL AFTER `the_status`;


ALTER TABLE `organization_role`
ADD COLUMN `code`  varchar(255) NULL AFTER `thestatus`;

ALTER TABLE `organization_role`
CHANGE COLUMN `code` `role_code`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `thestatus`;

ALTER TABLE `organization_role`
CHANGE COLUMN `role_code` `c_name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `thestatus`;



--------------------------11.26--------------------
ALTER TABLE `master_news`
MODIFY COLUMN `remark`  varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `type`;ADD COLUMN `create_datetime`  datetime NULL AFTER `template`;


CREATE TABLE `wx_called_record` (
`id`  char(16) NOT NULL ,
`data_key`  varchar(128) NULL ,
`data`  varchar(255) NULL ,
`access_token`  varchar(128) NULL ,
`callback`  varchar(128) NULL ,
`request_source`  varchar(128) NULL ,
`create_datetime`  datetime NULL ,
`consumer_id`  char(16) NULL ,
PRIMARY KEY (`id`)
)
;

----------------------------12.02-----------------------
ALTER TABLE `master_comment`
ADD COLUMN `author_id`  char(16) NULL AFTER `comment_number`;


-------------12.9-------------
CREATE TABLE `tenant_review` (
`id`  char(16) NOT NULL ,
`content`  varchar(255) NULL ,
`tenant_id`  char(16) NULL ,
`review_status`  char(2) NULL ,
`create_datetime`  datetime NULL ,
PRIMARY KEY (`id`)
)
;
------------订单增加运费字段-----------------
ALTER TABLE `purchase_order`
ADD COLUMN `freight`  decimal(10,2) NULL AFTER `address_city_id`;
