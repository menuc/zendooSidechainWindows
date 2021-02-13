# zendooSidechainWindows
基于windows的zen侧链发行指南

本文是基于windows的zen侧链发行指南，本文参考了：xxx，如果你想在linux下发行侧链，请参考原者的项目，谢谢。

首先，下载相关软件：
python-3.9.1-amd64.exe
jdk-8u271-windows-x64.exe
apache-maven-3.6.3-bin.zip
Git-2.30.0-64-bit.exe
7z1900-x64.exe

安装全部exe软件，采用默认的设置。

在c:的根目录新建zen文件夹，复制apache-maven-3.6.3-bin.zip到zen目录（如果你的c盘空间紧张，请更换到其他驱动器）

鼠标右点击apache-maven-3.6.3-bin.zip，选择“全部解压缩”。

设置环境变量：
JAVA_HOME=C:\Program Files\Java\jdk1.8.0_271
M2_HOME=C:\zen\apache-maven-3.6.3
PATH=PATH;%JAVA_HOME%\bin;%M2_HOME%\bin;C:\zen

验证软件安装：
java -version
********系统返回:（所有系统返回都有这个标识）
java version "1.8.0_271"
Java(TM) SE Runtime Environment (build 1.8.0_271-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.271-b09, mixed mode)

mvn -version
********系统返回:
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: C:\zen\apache-maven-3.6.3\bin\..
Java version: 1.8.0_271, vendor: Oracle Corporation, runtime: C:\Program Files\Java\jdk1.8.0_271\jre
Default locale: zh_CN, platform encoding: GBK
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"

下载最新的侧链代码，点击Git CMD图标，输入cd /zen,切换到工作目录，输入git clone https://github.com/ZencashOfficial/Sidechains-SDK.git 下载最新的代码；
********系统返回:
Cloning into 'Sidechains-SDK'...
remote: Enumerating objects: 237, done.
remote: Counting objects: 100% (237/237), done.
remote: Compressing objects: 100% (170/170), done.
remote: Total 20705 (delta 66), reused 146 (delta 36), pack-reused 20468 eceiving objects: 100% (20705/20705), 94.11 MiBReceiving objects: 100% (20705/20705), 95.97 MiB | 2.35 MiB/s, done.

Resolving deltas: 100% (11645/11645), done.
Updating files: 100% (552/552), done.

输入以下命令，编译代码：
cd Sidechains-SDK
mvn package

********系统返回:

[INFO] -----------------------< com.horizen:Sidechains >-----------------------
[INFO] Building Sidechains 0.2.6                                          [4/4]
[INFO] --------------------------------[ pom ]---------------------------------
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary for Sidechains 0.2.6:
[INFO]
[INFO] io.horizen:sidechains-sdk .......................... SUCCESS [02:03 min]
[INFO] sidechains-sdk-simpleapp ........................... SUCCESS [01:41 min]
[INFO] sidechains-sdk-scbootstrappingtools ................ SUCCESS [ 36.297 s]
[INFO] Sidechains ......................................... SUCCESS [  0.000 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  04:22 min
[INFO] Finished at: 2021-02-13T20:34:38+08:00
[INFO] ------------------------------------------------------------------------

编译成功！

将文件ZcashParams.zip解压缩到：C:\Users\{用户名}\AppData\Roaming\ZcashParams


访问以下网址，下载最新的文件：
https://bootstraps.ultimatenodes.io/horizen/masternode-sc/
这个网址会显示三个打包文件，下载最新的就可以，我下载的是[https://bootstraps.ultimatenodes.io/horizen/masternode-sc/horizen_masternode_sidechains_blockchain_2021-02-13_07-00-02_UTC.tar.gz]。

解压Zen_Win_binaries_v2.1.0-beta4.zip文件

运行zend
********系统返回:
------------------------------------------------------------------
                        ERROR:
 The configuration file zen.conf is missing.
 Please create a valid zen.conf in the application data directory.
 The default application data directories are:

 Windows (pre Vista): C:\Documents and Settings\Username\Application Data\Zen
 Windows (Vista and later): C:\Users\Username\AppData\Roaming\Zen

 You can find the default configuration file at:
 https://github.com/ZencashOfficial/zen/blob/master/contrib/debian/examples/zen.conf

                        WARNING:
 Running the default configuration file without review is considered a potential risk, as zend
 might accidentally compromise your privacy if there is a default option that you need to change!

 Please create a valid zen.conf and restart to zend continue.
------------------------------------------------------------------

这是没有配置文件的提示，将zen.conf复制到C:\Users\{用户名}\AppData\Roaming\zen目录，再次运行zend
看到以下界面，显示区块正在同步，新开一个命令行窗口，输入以下命令：
cd C:\zen\Zen_Win_binaries_v2.1.0-beta4
zen-cli stop
停止同步后将最新下载的horizen_masternode_sidechains_blockchain_2021-02-13_07-00-02_UTC.tar.gz文件解压缩到C:\Users\{用户名}\AppData\Roaming\zen\testnet3 目录，再次运行zend，等待测试网数据同步完成。

