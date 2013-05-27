

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

#define publicColor [UIColor colorWithRed:247.f/255 green:232.f/255 blue:232.f/255 alpha:1.f]
//同步定时器的时间
#define SYS_TIME 60

#define IMAGE_PATH @"image"



#define DEFAULT_PAGE_NUMBER 1
#define PAGE_COUNT          10


