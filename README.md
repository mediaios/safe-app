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

崩溃原因： 调用了一个对象不存在的方法

解决方法： 利用`runtime`修改消息转发逻辑

### 关于使用foundation中的方法所导致的crash

在使用Foundation中的各种类的方法时，有可能会导致应用崩溃。我们下面详细说明。 

#### NSString及NSMutableString

关于字符串(包含可变字符串)引起应用crash的问题，一般可以总结为以下几点： 

* 初始化时crash(参数非法) 
* 字符串操作crash，一般的字符串操作有截取，查找，追加(参数越界等)

所以我们可以通过利用`runtime`机制重写原生的方法实现。但是在进行方法替换是，我们要清楚的知道当你创建一个字符串对象时，它所属的`class`是谁。因为OC在运行时对NSString对象做了很多内存的优化。下面我们验证一下： 

```
// 以下代码最后的输出都是打印对象的class即 [obj class]
NSString *str1 = [NSString alloc];        // 打印[str1 class]的结果是NSPlaceholderString
NSString *str2 = [[NSString alloc] init];  // __NSCFConstantString 
NSString *str3 = [NSString string];       // __NSCFConstantString
NSString *str4 = [str3 copy];
NSString *str5  = @"1234";
NSString *str6  = [NSString stringWithFormat:@"123456789"];   // NSTaggedPointerString 
NSString *str7 = [NSString stringWithFormat:@"1234567890"];   // __NSCFString 
NSMutableString *mutaStr1  = [NSMutableString alloc];         // NSPlaceholderMutableString
NSMutableString *mutaStr2 = [[NSMutableString alloc] init];   // __NSCFString
```

 * `__NSPlaceholderString` : NSString只alloc，没有init
 * `__NSCFConstantString` : init后或使用类方法创建的NSString。不可变字符，可节省内存提高性能。
 * `NSTaggedPointerString`: 数字、英文、符号等的ASCII字符组成字符串，长度小于等于9的时候会自动成为NSTaggedPointerString类型,其专门用来存储小对象
 * `__NSCFString` : NSCFString对象是一种NSString子类，存储在堆上，不属于字符串常量对象。该对象创建之后和其他的Obj对象一样引用计数为1，对其执行retain和release将改变其retainCount。
 * `NSPlaceholderMutableString`: NSMutableString只alloc没有init

由此，我们得出以下结论： 

* 替换NSString中的方法时，只需要替换`NSPlaceholderString`,`__NSCFConstantString`,`NSTaggedPointerString`这几个类。
* 替换NSMutableString中的方法时，只需要替换`NSPlaceholderMutableString `和`__NSCFString `两个类。

`MISafeApp`替换了NSString和NSMutableString中的下列方法，因此可以防止这些方法的崩溃:

* NSString
	* `- (instancetype)initWithString:(NSString *)aString`
	* `- (NSString *)substringFromIndex:(NSUInteger)from`
	* `- (NSString *)substringToIndex:(NSUInteger)to`
	* `- (NSString *)substringWithRange:(NSRange)range`
	* `- (unichar)characterAtIndex:(NSUInteger)index`
	* `- (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange`
	* `- (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement`
	* `- (BOOL)hasPrefix:(NSString *)str`
	* `- (BOOL)hasSuffix:(NSString *)str`
* NSMutableString
	* `- (BOOL)hasPrefix:(NSString *)str`
	* `- (BOOL)hasSuffix:(NSString *)str`
	* `- (NSString *)substringFromIndex:(NSUInteger)from`
	* `- (NSString *)substringToIndex:(NSUInteger)to`
	* `- (NSString *)substringWithRange:(NSRange)range`
	* `- (unichar)characterAtIndex:(NSUInteger)index`
	* `- (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange`
	* `- (NSString *)stringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement`
	* `- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString`
	* `- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange`
	* `- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc`
	* `- (void)deleteCharactersInRange:(NSRange)range`
	* `- (void)appendString:(NSString *)aString`
	* `- (void)setString:(NSString *)aString`

#### NSAttributedString及NSMutableAttributedString

同理，对于NSAttributedString和NSMutableAttributedString我们用同样的方式验证，得出以下结论： 

* 替换NSAttributedString中的方法时，只需要替换`NSConcreteAttributedString`
* 替换NSMutableAttributedString中的方法时，只需要替换`NSConcreteMutableAttributedString`

`MISafeApp`替换了NSAttributedString和NSMutableAttributedString中的下列方法，因此可以防止这些方法的崩溃:

* NSAttributedString
	* `- (instancetype)initWithString:(NSString *)str;`
	* `- (instancetype)initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;`
	* `- (instancetype)initWithAttributedString:(NSAttributedString *)attrStr;` 
*  NSMutableAttributedString
	* `- (instancetype)initWithString:(NSString *)str;`
	* `- (instancetype)initWithString:(NSString *)str attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs;`
	* `- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str;`
	* `- (void)setAttributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;`
	* `- (void)addAttribute:(NSAttributedStringKey)name value:(id)value range:(NSRange)range;`
	* `- (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range;`
	* `- (void)removeAttribute:(NSAttributedStringKey)name range:(NSRange)range;`
	* `- (void)replaceCharactersInRange:(NSRange)range withAttributedString:(NSAttributedString *)attrString;`

#### NSArray及NSMutableArray

对于NSArray:

* `__NSPlaceholderArray` 是`NSArray` alloc 之后所得的类
* `__NSArray0` 是`NSArray`初始化后只有0个元素所得的类
* `__NSSingleObjectArrayI` 当数组仅有一个元素时
* `__NSArrayI` 当数组大于一个元素时

对于`NSMutableArray`:

* `__NSPlaceholderArray` 是`NSMutableArray` alloc 之后所得的类
* `__NSArrayM` 是init之后所得到的类

结论：

* 替换NSArray中的方法时，需要替换`__NSPlaceholderArray`,`__NSArray0 `,`__NSSingleObjectArrayI `,`__NSArrayI `
* 替换NSMutableArray中的方法时，需要替换`__NSPlaceholderArray `,`__NSArrayM `

`MISafeApp`替换了NSArray和NSMutableArray中的下列方法，因此可以防止这些方法的崩溃:

* NSArray
	* `- (instancetype)initWithObjects:(const ObjectType _Nonnull [_Nullable])objects count:(NSUInteger)cnt`
	* `- (ObjectType)objectAtIndex:(NSUInteger)index;`
	* `- (ObjectType)objectAtIndexedSubscript:(NSUInteger)idx`
	* `- (void)getObjects:(ObjectType _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range`
* NSMutableArray
	* `- (ObjectType)objectAtIndex:(NSUInteger)index;`
	* `- (ObjectType)objectAtIndexedSubscript:(NSUInteger)idx`
	* `- (void)getObjects:(ObjectType _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range`
	* `- (void)setObject:(ObjectType)obj atIndexedSubscript:(NSUInteger)idx`
	* `- (void)insertObject:(ObjectType)object atIndex:(NSUInteger)idx`
	* `- (void)removeObjectsInRange:(NSRange)range;`
	* `- (void)removeObject:(ObjectType)anObject inRange:(NSRange)range;`
	* `- (void)removeObjectIdenticalTo:(ObjectType)anObject inRange:(NSRange)range;`
	* `- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;`
	* `- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;`
	* `- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<ObjectType> *)otherArray range:(NSRange)otherRange;`
	* `- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<ObjectType> *)otherArray;`
	* `- @property (readonly) NSInteger integerValue`

#### NSDictionary及NSMutableDictionary

针对于NSDictionary:

* `__NSPlaceholderDictionary` : 只alloc，没有init 
* `__NSDictionary0` : 字典没有元素时
* `__NSSingleEntryDictionaryI` : 只有一个元素 
* `__NSDictionaryI` : 字典又多个元素时(普通的字典)

对于NSMutableDictionary:
* `__NSPlaceholderDictionary`: 只alloc，没有init 
* `__NSDictionaryM` : NSMutableDictionary实例化之后
* `__NSFrozenDictionaryM`: 对NSMutableDict做拷贝，拷贝之后字典的类型

结论：

* 替换NSDictionary中的方法时，需要替换`__NSPlaceholderDictionary `,`__NSDictionary0 `,`__NSSingleEntryDictionaryI `,`__NSDictionaryI `
* 替换NSMutableArray中的方法时，需要替换`__NSPlaceholderArray `,`__NSArrayM ,`__NSCFDictionary`

`MISafeApp`替换了NSDictionary和NSMutableDictionary中的下列方法，因此可以防止这些方法的崩溃:

* NSDictionary
	* `- (instancetype)initWithObjects:(const ObjectType _Nonnull [_Nullable])objects forKeys:(const KeyType <NSCopying> _Nonnull [_Nullable])keys count:(NSUInteger)cnt`
	* `- (instancetype)initWithObjects:(NSArray<ObjectType> *)objects forKeys:(NSArray<KeyType <NSCopying>> *)keys;`
	* `+ (instancetype)dictionaryWithObjects:(const ObjectType _Nonnull [_Nullable])objects forKeys:(const KeyType <NSCopying> _Nonnull [_Nullable])keys count:(NSUInteger)cnt;`
	* `- (nullable id)valueForUndefinedKey:(NSString *)key;`
* NSMutableDictionary
	* `- (void)setObject:(nullable id)value forKey:(NSString *)defaultName;`
	* `- (void)setObject:(nullable ObjectType)obj forKeyedSubscript:(KeyType <NSCopying>)key`
	* `- (void)removeObjectForKey:(KeyType)aKey;`

#### NSSet及NSMutableSet

* NSSet
 * `- (instancetype)initWithObjects:(const ObjectType _Nonnull [_Nullable])objects count:(NSUInteger)cnt`
* NSMutableSet
	* `- (void)addObject:(ObjectType)object;`
	* `- (void)removeObject:(ObjectType)object;`

#### NSOrderedSet及NSMutableOrderedSet

* NSOrderedSet
	* `- (instancetype)initWithObjects:(const ObjectType _Nonnull [_Nullable])objects count:(NSUInteger)cnt`
	* `- (ObjectType)objectAtIndex:(NSUInteger)idx;`
* NSMutableOrderedSet
	* `- (ObjectType)objectAtIndex:(NSUInteger)idx;`
	* `- (void)insertObject:(ObjectType)object atIndex:(NSUInteger)idx;`
	* `- (void)removeObjectAtIndex:(NSUInteger)idx;`
	* `- (void)replaceObjectAtIndex:(NSUInteger)idx withObject:(ObjectType)object;`
	* `- (void)addObject:(ObjectType)object;`

### NSData及NSMutableData

* NSData
	* `- (NSData *)subdataWithRange:(NSRange)range;`
	* `- (NSRange)rangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange`
* NSMutableData
	* `- (NSData *)subdataWithRange:(NSRange)range;`
	* `- (NSRange)rangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange`
	* `- (void)resetBytesInRange:(NSRange)range;`
	* `- (void)replaceBytesInRange:(NSRange)range withBytes:(const void *)bytes;`
	* `- (void)replaceBytesInRange:(NSRange)range withBytes:(nullable const void *)replacementBytes length:(NSUInteger)replacementLength;`

### KVC

原因： 给不存在的key设置value。 

`MISafeApp`替换了NSObject的下列方法，因此可以防止KVC操作的崩溃:

* `- (void)setValue:(id)value forKey:(NSString *)key` 
* `- (void)setValue:(id)value forKeyPath:(NSString *)keyPath`
* `- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues`
* `- (void)setValue:(id)value forUndefinedKey:(NSString *)key`


### KVO

崩溃发生的情况有： 

1. 移除未注册的观察者
2. 重复移除观察者
3. 添加了观察者但是没有实现observeValueForKeyPath:ofObject:change:context方法
4. 添加移除keypath=nil
5. 添加移除observer = nil
6. dealloc是自动移除观察者，俗称KVO释放

### NSUserDefaults

* `- (void)setObject:(nullable id)value forKey:(NSString *)defaultName;`
* `- (NSInteger)integerForKey:(NSString *)defaultName;`
* `- (BOOL)boolForKey:(NSString *)defaultName;`
* `- (nullable id)objectForKey:(NSString *)defaultName;`


### NSNotification

触发时机： 

一个对象注册了通知，但是在对象销毁时没有取消注册。

注册通知的最合适时机就是在init方法里面注册，在dealloc方法中取消注册。

从ios9.0开始，如果没有移除注册的通知，则也不会引起crash。 

### NSTimer

原因： 

在使用`NSTimer`的以`scheduleTimer`开头的方法创建的NSTimer对象，会强引用target，target又会强引用timer。在我们没有正确关闭timer的时候，timer会一直持有target导致内存泄漏等问题。

解决方案： 

利用runtime新创建一个代理将target和selector信息保存到Proxy里，修改引用target的方式为weak。当target为nil时，如果再执行timer的时候，如果发现此时target为nil，则自动停止timer。 

## 联系我们

* 如果你有任何问题或需求，请提交[issue](https://github.com/mediaios/safe-app/issues)
* 如果你要提交代码，欢迎提交 pull request
* 欢迎点星
