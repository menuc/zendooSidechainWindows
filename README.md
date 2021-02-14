# zendooSidechainWindows
基于windows的zen侧链发行指南

系统环境：win10 64 in vmware15

本文是基于windows的zen侧链发行指南，本文参考了项目：https://github.com/chainaccelerator/eazen，如果你想在linux下发行侧链，请参考原者的项目，谢谢。

首先，下载相关安装软件：链接：https://pan.baidu.com/s/1i5QQ_seXNU_WRAGVEA97SQ 
提取码：aofj 
```
python-3.9.1-amd64.exe
jdk-8u271-windows-x64.exe
apache-maven-3.6.3-bin.zip
Git-2.30.0-64-bit.exe
7z1900-x64.exe
jq.exe
sleep.vbs
sceaZen.bat
```
安装全部exe软件，采用默认的设置。

在c:的根目录新建zen文件夹，复制apache-maven-3.6.3-bin.zip jq.exe sleep.vbs sceaZen.bat Zen_Win_binaries_v2.1.0-beta4.zip 到zen目录如下图（如果你的c盘空间紧张，请更换到其他驱动器）

鼠标右点击apache-maven-3.6.3-bin.zip，选择“全部解压缩”。

设置环境变量(如图)：
```
JAVA_HOME=C:\Program Files\Java\jdk1.8.0_271
M2_HOME=C:\zen\apache-maven-3.6.3
PATH=PATH;%JAVA_HOME%\bin;%M2_HOME%\bin;C:\zen;C:\zen\Zen_Win_binaries_v2.1.0-beta4;C:\Program Files\Git\usr\bin
```

验证软件安装：
java -version
```
********系统返回:（所有系统返回都有这个标识）
java version "1.8.0_271"
Java(TM) SE Runtime Environment (build 1.8.0_271-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.271-b09, mixed mode)
```
mvn -version
```
********系统返回:
Apache Maven 3.6.3 (cecedd343002696d0abb50b32b541b8a6ba2883f)
Maven home: C:\zen\apache-maven-3.6.3\bin\..
Java version: 1.8.0_271, vendor: Oracle Corporation, runtime: C:\Program Files\Java\jdk1.8.0_271\jre
Default locale: zh_CN, platform encoding: GBK
OS name: "windows 10", version: "10.0", arch: "amd64", family: "windows"
```
下载最新的侧链代码，点击Git CMD图标，输入cd /zen,切换到工作目录，输入git clone https://github.com/ZencashOfficial/Sidechains-SDK.git 下载最新的代码；
```
********系统返回:
Cloning into 'Sidechains-SDK'...
remote: Enumerating objects: 237, done.
remote: Counting objects: 100% (237/237), done.
remote: Compressing objects: 100% (170/170), done.
remote: Total 20705 (delta 66), reused 146 (delta 36), pack-reused 20468 eceiving objects: 100% (20705/20705), 94.11 MiBReceiving objects: 100% (20705/20705), 95.97 MiB | 2.35 MiB/s, done.

Resolving deltas: 100% (11645/11645), done.
Updating files: 100% (552/552), done.
```
输入以下命令，编译代码：
cd Sidechains-SDK
mvn package
```
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
```
以上信息标识编译成功！

将文件ZcashParams.zip解压缩到：C:\Users\{用户名}\AppData\Roaming\ZcashParams

访问以下网址，下载最新的文件：
https://bootstraps.ultimatenodes.io/horizen/masternode-sc/
这个网址会显示三个打包文件，下载最新的就可以，我下载的是[https://bootstraps.ultimatenodes.io/horizen/masternode-sc/horizen_masternode_sidechains_blockchain_2021-02-13_07-00-02_UTC.tar.gz]。

解压Zen_Win_binaries_v2.1.0-beta4.zip文件

运行zend
```
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
```
这是没有配置文件的提示，将zen.conf复制到C:\Users\{用户名}\AppData\Roaming\zen目录，再次运行zend
看到以下界面，显示区块正在同步，新开一个命令行窗口，输入以下命令：
cd C:\zen\Zen_Win_binaries_v2.1.0-beta4
zen-cli stop
停止同步后将最新下载的horizen_masternode_sidechains_blockchain_2021-02-13_07-00-02_UTC.tar.gz文件解压缩到C:\Users\{用户名}\AppData\Roaming\zen\testnet3 目录，再次运行zend，等待测试网数据同步完成。
```
********系统返回:
Messages:
- : You need to rebuild the database using -reindex to change -txindex.
Please restart with -reindex to recover.

Init message: Loading block index...

['zen-cli.exe stop' to exit] [Set 'showmetrics=0' to hide]
```
使用-reindex参数重新运行zend
zend -reindex
等待系统同步完成，大约需要几小时。
同步完成后，点击Git CMD图标，运行以下命令：
cd /zen
sceaZen.bat
这个批处理文件将自动生成配置文件参数，并启动侧链，如果没有问题，你将看到如下界面：

现在，我们已经声明了侧链，并锁定10个zen到侧链，下面我们来进行转账操作：

查看主链余额：
zen-cli -regtest getbalance
```
********系统返回:
1335.24997893
```
查看侧链余额：
curl -X POST "http://127.0.0.1:9085/wallet/balance" -H "accept: application/json" -H "Content-Type: application/json"
```
********系统返回:
cation/json"
{
  "result" : {
    "balance" : 1000000000
  }
}
```

发送到侧链

zen-cli -regtest sc_send “publicKey” “数量” “scid”
type keys.txt|findstr GKPUBLIC
type keys.txt|findstr SCID
```
********系统返回:
GKPUBLIC = 83bc9e525cfe39dd840af977c93666052039c3b693a385f31235cccc695be534
SCID=39435209f33ab13af5ba1788934543ca8e7d4f169e65f8d46c7d2d3b5ff04c10
```

zen-cli -regtest sc_send "83bc9e525cfe39dd840af977c93666052039c3b693a385f31235cccc695be534" 50 "39435209f33ab13af5ba1788934543ca8e7d4f169e65f8d46c7d2d3b5ff04c10"
```
********系统返回:
f9b0f4ff182a8c4f7462809bb54ccd7ff5690be991ec045a16a51061c4a85073
```

在主链中生成一个新区块
zen-cli -regtest generate 1
```
********系统返回:
[
  "04a94094916bb2e3a8104cb1b07e31b2c3e71cc67e9823e5c33f3c22f4e86e50"
]
```

验证区块信息

zen-cli -regtest getblock "04a94094916bb2e3a8104cb1b07e31b2c3e71cc67e9823e5c33f3c22f4e86e50"
```
********系统返回:
{
  "hash": "04a94094916bb2e3a8104cb1b07e31b2c3e71cc67e9823e5c33f3c22f4e86e50",
  "confirmations": 1,
  "size": 1256,
  "height": 222,
  "version": 3,
  "merkleroot": "9e2a02e45483a7dfd0496d9d02bc66d212ef78a85b7666237f3bcb022969048a",
  "scTxsCommitment": "294b07476cd1dc6c9e84ed8d480b41263e068aef854d24e611d48e3b2c4e09f0",
  "tx": [
    "a3a54e3c876faedb7ab0dc6c595e088638a098fb7a8c8509677ebf3b52f504ff",
    "f9b0f4ff182a8c4f7462809bb54ccd7ff5690be991ec045a16a51061c4a85073"
  ],
  "cert": [
  ],
  "time": 1613319713,
  "nonce": "00003efce4f776520904dac948995aa803269042cf6327f2fa3f6884688c000d",
  "solution": "07ff493ee6bec631c614658c7469762ab9b90871d4977202ca9de8151587b381c5a6b791",
  "bits": "200f0f02",
  "difficulty": 1.000013172800801,
  "chainwork": "0000000000000000000000000000000000000000000000000000000000000ecf",
  "anchor": "59d2cde5e65c1414c32ba54f0fe4bdb3d67618125286e6a191317917c812c6d7",
  "valuePools": [
    {
      "id": "sprout",
      "monitored": true,
      "chainValue": 0.00000000,
      "chainValueZat": 0,
      "valueDelta": 0.00000000,
      "valueDeltaZat": 0
    }
  ],
  "previousblockhash": "0177865c0e08395afcda364369fef2eba8658840f5b49e11e9464bd0badf2b33"
}
```
curl -X POST "http://127.0.0.1:9085/block/forgingInfo" -H "accept: application/json" -H "Content-Type: application/json"

```
********系统返回:
{
  "result" : {
    "consensusSecondsInSlot" : 120,
    "consensusSlotsInEpoch" : 720,
    "bestEpochNumber" : 1,
    "bestSlotNumber" : 720
  }
}
```
生成下一个开始下一个纪元
curl -X POST "http://127.0.0.1:9085/block/generate" -H "accept: application/json"  -H "Content-Type: application/json" -d "{\"epochNumber\":2,\"slotNumber\":1}"
```
********系统返回:
{
  "result" : {
    "blockId" : "3d5d38cf2f22b0286f7ce20815632e73f7999eb26aba763f0201115aab4fd6b6"
  }
```
验证侧链余额
curl -X POST "http://127.0.0.1:9085/wallet/balance" -H "accept: application/json"
```
********系统返回:
{
  "result" : {
    "balance" : 600000000
  }
}
```
侧链中进行转移,创建一个新地址
curl -X POST "http://127.0.0.1:9085/wallet/createPrivateKey25519" -H "accept: application/json"
```
********系统返回:
{
  "result" : {
    "proposition" : {
      "publicKey" : "a61b1bd64ae1e75964eb1ea1e24fb234411844292f3862c6c8091334e9639fe7"
    }
  }
}
```
通过调用/transaction/sendCoinsToAddressAPI完成发送
curl -X POST "http://127.0.0.1:9085/transaction/sendCoinsToAddress" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"outputs\":[{\"publicKey\":\""83bc9e525cfe39dd840af977c93666052039c3b693a385f31235cccc695be534 "\",\"value\":90000000}],\"fee\":0}"
```
********系统返回:
{
  "result" : {
    "transactionId" : "f343b4ed982a599657afe64ffb0cf482472ce84a554f5c7380d0685e1125e14e"
  }
}
```
返回所有钱包余额：
curl -X POST "http://127.0.0.1:9085/wallet/allBoxes" -H "accept: application/json" -H "Content-Type: application/json"
```
********系统返回:
{
  "result" : {
    "boxes" : [ {
      "nonce" : -983576366876204082,
      "id" : "5994084524ab3d5dfc6f005579a586c1f9d4b8b6be5628e9434630939db575fe",
      "typeId" : 3,
      "blockSignProposition" : {
        "publicKey" : "d5b0be8cf2f6f4ac1ebf2ecdc95b9cd59cfc3c7183b87981433879fd1462a000"
      },
      "vrfPubKey" : {
        "valid" : true,
        "publicKey" : "09e4f5e989f0f5a86e7bed8892689f8afd127f4deec8d33f90a70ea4f1dfa9f137f851e0b5bc06ead6b2112c26ebc776091673b57d56f98410c6286ef08a7ae02f90ab7613d8e8ad94506526602f14a75220f9dc24d33ec92bbc7e9aeaf50000585973242db72deeb26c5a5628b9d6d04f4936d67410c846a95deaab5093774df176d6422e6466809010224fba10799641a16a740284949a22bac3ca4b861f274391ab6c5926975b807dcf00071670a66ace90c2d53cd9ee931ccfbe3b92000000"
      },
      "proposition" : {
        "publicKey" : "d5b0be8cf2f6f4ac1ebf2ecdc95b9cd59cfc3c7183b87981433879fd1462a000"
      },
      "value" : 100000000
    }, {
      "nonce" : 7949309364074298765,
      "id" : "d6f234a7cce52b1d3e5daee4b7bdd54513f09e956ed74ae3d5cfcf6e7aecfa79",
      "typeId" : 1,
      "proposition" : {
        "publicKey" : "d5b0be8cf2f6f4ac1ebf2ecdc95b9cd59cfc3c7183b87981433879fd1462a000"
      },
      "value" : 90000000
    } ]
  }
}
```
向后转移：从侧链到主链
zen-cli -regtest getnewaddress
```
********系统返回:
ztnYjrMciojb5HV8f5MPjg4Zw9DFY326BT9
```
curl -X POST "http://127.0.0.1:9085/transaction/withdrawCoins" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"outputs\":[{\"publicKey\":\"ztnYjrMciojb5HV8f5MPjg4Zw9DFY326BT9\",\"value\":1000000000}],\"fee\":0}"
```
********系统返回:

{
  "result" : {
    "transactionId" : "3199edf22976083e1102c5486f6244c26f069512f0ed3ac6f420aab9aa2c81a5"
  }
}
```

生成区块：
curl -X POST "http://127.0.0.1:9085/block/generate" -H "accept: application/json" -H "Content-Type: application/json" -d "{\"epochNumber\":2,\"slotNumber\":3}"

```
********系统返回:
{
  "result" : {
    "blockId" : "6367fca4f291a9aa69799d241dc04ef45d72231d1349bdd3373a894835743ad2"
  }
}
```
zen-cli -regtest generate 1

获得响应:
[
  "0b5d72770e69dce926263863a839f8711fed2d45edbdabcbbd6797d0eeecc834"
]

产生更多区块
zen-cli -regtest generate 1000

查看余额
zen-cli -regtest listaddressgroupings
```
********系统返回:
[
  [
    [
      "ztnYjrMciojb5HV8f5MPjg4Zw9DFY326BT9",
      7.50000891
    ],
    [
      "ztZUY391qcU4SvLY8CPDFmHLW2p91AZaKgY",
      1245.24996711
    ]
  ],
  [
    [
      "ztqKkULoPPoMWmKNuL8JPjBdbTofXF6i64P",
      0.00000000
    ]
  ],
  [
    [
      "ztqsWqPSmphGXf6kSMoc5z6Jfm1CySNkUqd",
      0.00000000,
      ""
    ]
  ]
]

```











