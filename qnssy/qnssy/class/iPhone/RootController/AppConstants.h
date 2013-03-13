
//测试环境
//#define  MBSHTTPURL @"http://202.101.47.84/iPlatMBS/AgentService"
//#define  MBSHTTPSURL @"http://202.101.47.84/iPlatMBS/LoginService"
//#define UPDATEWITHURL @"http://202.101.47.84/iPlatMBS/appstore/release/iPadCoOffice/iPadCoOffice.plist"
//#define IPLAT4M_URL @"http://202.101.47.84/iPlatMBS/appstore/release/iPlat4M_iPad/iPlat4M_iPad.plist" //基座应用更新下载地址

//正式环境
//#define  MBSHTTPURL @"http://mobile.baosteel.com/iPlatMBS/AgentService"
//#define  MBSHTTPSURL @"http://mobile.baosteel.com/iPlatMBS/LoginService"
//#define UPDATEWITHURL @"http://mobile.baosteel.com/iPlatMBS/appstore/release/iPadCoOffice/iPadCoOffice.plist"
//#define IPLAT4M_URL @"http://mobile.baosteel.com/iPlatMBS/appstore/release/iPlat4M_iPad/iPlat4M_iPad.plist" //基座应用更新下载地址

//============================================================================================

#define app ((BSAppDelegate *)[[UIApplication sharedApplication] delegate])

#define SYSTEM_VERSION __IPHONE_4_3 || __IPHONE_4_2 || __IPHONE_4_1 || __IPHONE_4_0
//对话框类型
//网络异常
#define NET_ERR_LOGIN               1200    //登录时网路异常
#define NET_ERR_SYNUNTREATED        1201    //同步待审批网路异常
#define NET_ERR_SYNPROCESSED        1202    //同步已审批网路异常
#define NET_ERR_APPROVECOMMIT       1203    //提交处理出差结果网路异常
#define NET_ERR_DEVICE              1204    //驱动绑定请求网路异常
#define NET_ERR_SERVER_ERR          1205    //服务器检修中

#define DEVICEID_ERROR_ALERT        1206    //未绑定驱动
#define LOGIN_ERROR_ALERT           1207    //登录异常
#define DEVICE_REG_SUCCEEDED        1208    //驱动绑定成功
#define DEVICE_REG_FAILED           1209    //驱动绑定失败
#define DEVICE_SUCCEED_UNLOCK       1210    //设备绑定成功请联系管理员解锁

#define NET_ERR_SERVER_STATUS       1211    //服务器状态请求网路异常

//屏幕宽高ipad
#define WIDTH_HORIZONTAL        1024.0      //横屏宽
#define HEIGHT_HORIZONTAL       748.0       //横屏高
#define WIDTH_VERTIVAL          768.0       //竖屏宽
#define HEIGHT_VERTIVAL         1004.0      //竖屏高

//屏幕宽高iphoe
#define WIDTH_IPHONE_HORIZONTAL        480.0     //横屏宽
#define HEIGHT_IPHONE_HORIZONTAL       320.0       //横屏高
#define WIDTH_IPHONE_VERTIVAL          320.0       //竖屏宽
#define HEIGHT_IPHONE_VERTIVAL         480.0      //竖屏高


//同步定时器的时间
#define SYS_TIME 60

//常量
#define CCZL @"仓储总量"
#define KCL @"仓储量(宝钢)"
#define WTL @"未提量(客户)"
#define WWJGL @"委外加工量"

#define CCZL_NDQS @"仓储总量 年度趋势"
#define KCL_NDQS @"仓储量(宝钢) 年度趋势"
#define WTL_NDQS @"未提量(客户) 年度趋势"
#define WWJGL_NDQS @"委外加工量 年度趋势"

#define CCZL_QYFB @"仓储总量 区域分布"
#define KCL_QYFB @"仓储量(宝钢) 区域分布"
#define WTL_QYFB @"未提量(客户) 区域分布"
#define WWJGL_QYFB @"委外加工量 区域分布"

#define WL_JZRQ @"截止："

#define Date_Format @"MM/dd";//月日格式
#define Date_Y_MFormat @"yy/MM";//年月格式
#define Date_YFormat @"yyyy";//年格式


#define HT_JD_dyjd_gspm @"当月接单 公司排名"
#define HT_JD_dyjd_pzpm @"当月接单 品种排名"

#define HT_JD_DY @"接单预案当月完成率情况"
#define HT_JD_LJY @"接单预案累计月完成率情况"
#define HT_JD_ND @"接单预案年度完成率情况"

#define HT_JD_QB @"全部产品年度接单预案完成趋势"
#define HT_JD_TG @"碳钢年度接单预案完成趋势"
#define HT_JD_BXG @"不锈钢年度接单预案完成趋势"
#define HT_JD_TEG @"特钢年度接单预案完成趋势"

#define HT_YXLR_bnxs_gspm @"本年销售 公司排名"
#define HT_YXLR_bnxs_pzpm @"本年销售 品种排名"

//中间件服务器


#define LICENSE_KEY @"VMavLPP0UCVi3Y6MjAxMzAzMjlpbmZvQHNoaW5vYmljb250cm9scy5jb20=XM/1l979srww27FNrCaz7saX4maWzpw37qFIofRFxGpSTKYXZC0NwkgHFAafUZBKhDPvcd4RXRbbkS5s1hiSm2kbBJ16+gq7dJyyEctqP31Od8NM7ANzTq5Qbo5sB5lrhIP5DqfRuqUUO4bE/zEgkp5YbcK4=BQxSUisl3BaWf/7myRmmlIjRnMU2cA7q+/03ZX9wdj30RzapYANf51ee3Pi8m2rVW6aD7t6Hi4Qy5vv9xpaQYXF5T7XzsafhzS3hbBokp36BoJZg8IrceBj742nQajYyV7trx5GIw9jy/V6r0bvctKYwTim7Kzq+YPWGMtqtQoU=PFJTQUtleVZhbHVlPjxNb2R1bHVzPnh6YlRrc2dYWWJvQUh5VGR6dkNzQXUrUVAxQnM5b2VrZUxxZVdacnRFbUx3OHZlWStBK3pteXg4NGpJbFkzT2hGdlNYbHZDSjlKVGZQTTF4S2ZweWZBVXBGeXgxRnVBMThOcDNETUxXR1JJbTJ6WXA3a1YyMEdYZGU3RnJyTHZjdGhIbW1BZ21PTTdwMFBsNWlSKzNVMDg5M1N4b2hCZlJ5RHdEeE9vdDNlMD08L01vZHVsdXM+PEV4cG9uZW50PkFRQUI8L0V4cG9uZW50PjwvUlNBS2V5VmFsdWU+"

//应用id
//测试环境com.baosight.spes.BSBaointlControlBeta
//正式环境iphone：com.baosight.spes.BSBaointlControl
//正式环境iPad:com.baosight.spes.BSBaointlControlForiPad


//#define SYSTEM_IP @"http://10.30.91.12/data1/release/mobile/" //正式环境
//#define APP_TITLE @"国际管理在线"//正式环境

#define SYSTEM_IP @"http://10.30.91.12/data1/test/mobile/" //测试环境
#define APP_TITLE @"国际管理在线  测试" //测试环境

