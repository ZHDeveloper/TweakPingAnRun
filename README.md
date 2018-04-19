# iOS 平安金管家 Hook

平安金管家修改步数，无需越狱~

## 思路分析

PARSPedometerInfo是存储步数、心率的模型类，通过Hook该类的属性的getter方法来实现修改步数。

```
@interface PARSPedometerInfo : PARSBaseInfo
{
    long long _iPhoneSteps;
    long long _iWatchSteps;
    long long _healthMergeSteps;
    long long _otherDeviceSteps;
    long long _integratedSteps;
    long long _heartRate;
    NSDate *_startDate;
    NSDate *_endDate;
    NSDate *_syncDate;
    double _stepFrequency;
}

@property(nonatomic) double stepFrequency;
@property(retain, nonatomic) NSDate *syncDate; 
@property(retain, nonatomic) NSDate *endDate;
@property(retain, nonatomic) NSDate *startDate;
@property(nonatomic) long long heartRate; 
@property(nonatomic) long long integratedSteps; //iOS 11步数存储
@property(nonatomic) long long otherDeviceSteps;
@property(nonatomic) long long healthMergeSteps;
@property(nonatomic) long long iWatchSteps; 
@property(nonatomic) long long iPhoneSteps; // iOS 8步数存储
- (void).cxx_destruct;
- (id)description;
- (id)init;

@end
```

## 使用

#### 1、安装MonkeyDev(如已安装，跳过)

- 安装最新的theos

```
sudo git clone --recursive https://github.com/theos/theos.git /opt/theos
```

- 安装ldid(如安装theos过程安装了ldid，跳过)

```
brew install ldid
```

- 指定的Xcode

```
sudo xcode-select -s /Applications/Xcode.app
```

- 执行安装命令

```
sudo /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/AloneMonkey/MonkeyDev/master/bin/md-install)"
```

#### 2、运行工程

- 由于包名冲突，需先删除测试机平安金管家。
- 由于github限制100M上传，需从PP助手下载平安金管家越狱版本ipa
- 将ipa放到TweakPingAnRun/TargetApp/目录下
- 打开工程 TweakPingAnRun/TweakPingAnRun.xcodeproj 
- 选择证书：Targets-General-Signing
- 真机运行
- 效果见截图。


## 版权及免责声明

- iOS逆向实践，不可使用于商业和个人其他意图。一切问题均由个人承担，与本人无关。
- 感谢MonkeyDev的作者。
- 如内容对您的权利造成了影响，请[issues](https://github.com/ZHDeveloper/TweakPingAnRun/issues), 我会在第一时间进行删除。


## 截图


![img02](./ScreenCapture.gif)








