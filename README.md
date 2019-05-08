## 前言

在APP的开发中，如何防止APP崩溃是我们必须要面对的问题。当应用正在运行的过程中突然崩溃的话会让用户超级不爽，用户因此有可能会卸载应用进而导致我们的客户流失。所以，我们开发人员应该足够重视应用崩溃这一比较常见有时候又比较难以定位的问题。 

当应用崩溃时，我们一般情况下有以下几种处理方式： 

* 开发的过程中发现应用crash
	*  此时本地有符号表，可以连着XCode定位到大部分的crash堆栈信息
* 已经提测时(发布到testflight)测试人员发现应用crash
	* 首先想到的是通过xcode查看苹果反馈的crash信息，但是有时候可能没有。
	* 拿着QA部门的手机，直接查看系统的crash log，然后利用命令行定位crash堆栈
	* 如果crash不是必现的，并且上述两个步骤都不能解决，那么你可能需要大量的重复测试来复现。
* 当应用已经发布后出现crash
	* 此时的crash就是非常严重了，因为这样的crash直面的是客户。我们此时只能通过苹果反馈的crash信息来定位崩溃原因，但是此时崩溃已经无法避免。 

以上是我们在开发中常见的应对应用崩溃的处理方式。但是有时候我们在研发和测试的时候从来没有遇到过应用crash，但是发布应用后应用却频繁崩溃(这是非常常见的问题)原因是服务器返回数据异常(某一字段非法，或者数据错乱等)。

当然，如果客户端做很多的异常容错机制(字段非法校验比较完整；try crash容错机制完善)也可以避免这些问题。但是开发人员总可能有想不到的crash情况发生。

## MISafeApp介绍

`MISafeApp`框架是为了尽可能的防止应用Crash，简单概括如下： 

* 尽可能的防止`APP Crash`
	* 并不是说该库能防止所有原因引起的应用崩溃，它只能防止它所支持的防止崩溃的类型。
	* 当按照原有逻辑发生崩溃时，该库针对原生的方法做了修改，会在crash信息里面显示库防止应用崩溃所采取的策略。
* 获取原本导致`APP Crash`的堆栈信息，你可以自己来处理这些信息。(可本地存储；也可以发送到自己的服务器做线上分析)
* 该框架利用了`runtime`技术，对开发中常用的容易导致崩溃的方法做了特别处理，进而有效防止应用崩溃。

### 支持防止崩溃的类别

* NSArray
* NSMutableArray
* NSDictionary
* NSMutableDictionary
* NSString
* NSMutableString
* NSAttributedString
* KVC
* KVO
* NSUserDefaults
* NSSet
* NSOrderedSet
* NSMutableOrderedSet
* NSData
* NSMutableData
* NSNotification
* NSTimer
* unRecognizedSelector

具体到类中的哪些方法，稍后详细介绍。 

### 防止崩溃的信息 

首先我们制造一个崩溃：构造数组时添加一个空元素 

![](https://ws1.sinaimg.cn/large/006tNc79gy1g2tytso5bij30ph03e3z6.jpg)

我们运行上面代码会直接发生崩溃。 

![](https://ws1.sinaimg.cn/large/006tNc79gy1g2tyvitowbj30qu0a40u4.jpg)

使用`MISafeApp`框架来防止`APP Crash`,此时同样运行上面的代码日志如下： 

![](https://ws3.sinaimg.cn/large/006tNc79gy1g2u0wlqm6sj311m0minaf.jpg)

从上图可以看到，我们打印刚刚的那个会引起崩溃的数组，发现其移除了空元素。数据功能异常不可用相较与App崩溃而言，肯定是前者比较好。

框架所打印的Crash信息： 

* 崩溃名称
* 崩溃原因
* 崩溃发生的位置
* 框架为了避免应用崩溃，所采取的策略
* 崩溃的堆栈信息

### 环境要求 

* iOS >= 9.0
* XCode >= 7.0

## 安装使用 

### 通过pod方式 

```
pod 'MISafeApp'
```

### 手动导入

![](https://ws4.sinaimg.cn/large/006tNc79gy1g2u1avghffj30bt0b4ta0.jpg)

把上面的文件夹中的所有类都导入到你的项目中，然后`#import "MiSafeApp.h"`使用框架。

### 快速开始 

首先在你的项目中导入框架：

```
#import <MISafeApp/MiSafeApp.h>
```
手动导入的话这样引入： `#import "MiSafeApp.h"`

另外，你需要将-ObjC，$(inherited)添加到项目的Build Setting->other links flags中。 如下所示：

![](https://ws3.sinaimg.cn/large/006tNc79gy1g2u1iitl9nj30uw0c1413.jpg)

#### 设置针对哪些类的操作避免崩溃

该框架是一个插拔式的库，举例说如果你的APP没有用到通知，那么你没必要利用框架关于避免通知崩溃的逻辑。下面的设置就是仅仅利用框架的`NSString(包括其子类)`类型避免崩溃，从而避免应用中关于对`NSString`及其子类的操作所引起的崩溃。

```
 [MiSafeApp openAvoidCrashWithType:MiSafeCrashType_NSString];
```

eg： 为应用设置避免`NSString`，`NSArray`，`KVO`操作的Crash

```
[MiSafeApp openAvoidCrashWithType:MiSafeCrashType_NSString];
[MiSafeApp openAvoidCrashWithType:MiSafeCrashType_NSArray];
[MiSafeApp openAvoidCrashWithType:MiSafeCrashType_KVO];
```

当然，你也可以直接为应用设置`MISafeApp`框架所支持的所有避免崩溃的类型。 

```
[MiSafeApp openAvoidCrashWithType:MiSafeCrashType_All];
```

#### 接收Crash信息 

你可以通过实现`MISafeApp`框架的`MiSafeAppDelegate`提供的一个代理方法`- (void)miSafeApp:(MiSafeApp *)msApp crashInfo:(MiSafeCrashInfo *)msCrashInfo`来接收应用原有的Crash信息。接收到Crash信息之后你可以上传到服务器或者自己构建自己想要的日志等一系列操作。 

```
@interface ViewController ()<MiSafeAppDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MiSafeApp shareInstance].delegate =  self;
}

#pragma mark -MiSafeAppDelegate
- (void)miSafeApp:(MiSafeApp *)msApp crashInfo:(MiSafeCrashInfo *)msCrashInfo
{
    if (msCrashInfo) {
        NSLog(@"%@",msCrashInfo);
    }
}

@end
```


#### 设置Crash信息打印 

框架默认不打印应用原有崩溃信息，但是你可以通过设置日志级别来控制其日志输出。 

```
[MiSafeApp setLogLevel:MiSafeLogLevel_Display];   
```

如果不添加以上调用，则框架不会有任何的日志输出。 

## MISafeApp对各种崩溃类型避免的实现细节

### unrecognized selector

### NSString

### NSMutableString

### NSAttributedString

### NSMutableString

### NSArray 

### NSMutableArray

### NSDictionary
### NSMutableDictionary

### KVC

### KVO

### NSUserDefaults
### NSSet
### NSOrderedSet
### NSMutableOrderedSet
### NSData
### NSMutableData
### NSNotification
### NSTimer

## 联系我们

* 如果你有任何问题或需求，请提交[issue](https://github.com/mediaios/safe-app/issues)
* 如果你要提交代码，欢迎提交 pull request
* 欢迎点星
