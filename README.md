# xianDun

Flutter module 版弦盾sdk

## Android 本地依赖步骤

### 本项目
1. 执行命令：flutter build aar
2. 留意命令行输出内容，找到 aar 文件路径，以及本地 maven 版本号(xxx.pom文件内)

### Android 原生项目
1. 拷贝 aar 文件 到 libs 文件夹内
2. 在 app/build.gradle 文件内新增如下内容
```
android {
    //...
    // 使用 1.8 (可选)
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = '1.8'
    }
    
    
    sourceSets {
        main {
            jni.srcDirs = []
            jniLibs.srcDirs = ['libs']
        }
    }
}

//dependencies
dependencies {
    //...
     implementation fileTree(include: ['*.jar','*.aar'], dir: 'libs')
     // 以 debug 为例
     implementation 'io.flutter:flutter_embedding_debug:本地 maven 版本'
     
     // flutter 引擎 cpu 架构
     implementation 'io.flutter:armeabi_v7a_debug:本地 maven 版本'
     implementation 'io.flutter:arm64_v8a_debug:本地 maven 版本'
     implementation 'io.flutter:x86_64_debug:本地 maven 版本'
     
}
```
3. 在 setting.gradle 文件内新增如下内容
```
repositories {
    //...
    // 可 copy 到浏览器不能打开的话就换成国内镜像 https://mirrors.tuna.tsinghua.edu.cn/flutter/download.flutter.io
    maven { url 'https://storage.googleapis.com/download.flutter.io'}
}
```
4. (未验证)如果 arr 内含有第三方 so 库，需在项目下的 build.gradle 文件内新增如下内容
```
// ...
buildscript {
    dependencies {
        classpath libs.protobuf.gradle.plugin
    }
}

```

## Ios 依赖步骤

##使用的第三方库汇总
1. [permission_handler](https://pub.dev/packages/permission_handler)
2. [GetX](https://pub.dev/packages/get)
3. [SharedPreferences](https://pub.dev/packages/shared_preferences)
4. [badges](https://pub.dev/packages/badges)
5. [webview_flutter](https://pub.dev/packages/webview_flutter)
6. [flutter_screenutil](https://github.com/flutter/flutter)
7. [qr_code_scanner_plus](https://pub.dev/packages/qr_code_scanner_plus)
8. [mobile_scanner(待定)](https://pub.dev/packages/mobile_scanner)：包太大 (测试使用该库的 release_apk = 34.4 M；使用 qr_code_scanner_plus 的 release_apk = 24.9M)
9. [flutter_svg(待定)](https://pub.dev/packages/flutter_svg)：项目目前没使用 svg

### 踩坑记录
1. Android AndroidManifest.xml 配置
```
    <!-- 允许网络请求 -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <!-- 允许访问文件 -->
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <!-- 允许访问摄像头 -->
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.hardware.camera.autofocus" />

    <uses-feature
        android:name="android.hardware.camera.autofocus"
        android:required="true" />
    <uses-feature
        android:name="android.hardware.camera.front"
        android:required="true" />
    <uses-feature
        android:name="android.hardware.camera.front.autofocus"
        android:required="true" />


<application
    android:usesCleartextTraffic="true" // 允许 http 请求
>
</application>
```
2. mobile_scanner 使用非捆绑版本
```
// 1. 在 /android/gradle.propertie 内新增
// ...
dev.steenbakker.mobile_scanner.useUnbundled=true

// 2. 在 app/build.gradle 新增依赖
implementation com.google.mlkit:barcode-scanning:17.2.0
```

