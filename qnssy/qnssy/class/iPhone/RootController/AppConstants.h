
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

#define IMAGE_PATH @"image"

//#define SYSTEM_IP @"http://10.30.91.12/data1/release/mobile/" //正式环境
//#define APP_TITLE @"国际管理在线"//正式环境

#define SYSTEM_IP @"http://10.30.91.12/data1/test/mobile/" //测试环境
#define APP_TITLE @"国际管理在线  测试" //测试环境

