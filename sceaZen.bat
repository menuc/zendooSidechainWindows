set BOOTSTRAP=java -jar Sidechains-SDK\tools\sctool\target\original-sidechains-sdk-scbootstrappingtools-0.2.6.jar

for /F %%i in ('openssl rand -hex 16') do ( set SEED1=%%i)
echo SEED1 = %SEED1%> keys.txt
for /F %%i in ('openssl rand -hex 16') do ( set SEED2=%%i)
echo SEED2 = %SEED2% >> keys.txt
for /F %%i in ('openssl rand -hex 16') do ( set SEED3=%%i)
echo SEED3 = %SEED3% >> keys.txt
for /F %%i in ('openssl rand -hex 16') do ( set SEED4=%%i)
echo SEED4 = %SEED4% >> keys.txt
for /F %%i in ('openssl rand -hex 16') do ( set SEED5=%%i)
echo SEED5 = %SEED5% >> keys.txt

zen-cli -regtest generate 220

for /F %%i in ('%BOOTSTRAP% generatekey {\"seed\": \"%SEED1%\"}') do ( set GK1=%%i)
echo %GK1% >key1.txt
for /F %%i in ('type key1.txt^|jq -r .secret') do ( set GKSECRET=%%i)
echo GKSECRET = %GKSECRET% >>keys.txt
for /F %%i in ('type key1.txt^|jq -r .publicKey') do ( set GKPUBLIC=%%i)
echo GKPUBLIC = %GKPUBLIC% >>keys.txt

for /F %%i in ('%BOOTSTRAP% generateVrfKey {\"seed\": \"%SEED2%\"}') do ( set GVK=%%i)
echo %GVK% >key1.txt
for /F %%i in ('type key1.txt^|jq -r .vrfSecret') do ( set GVKSECRET=%%i)
echo GVKSECRET = %GVKSECRET% >>keys.txt
for /F %%i in ('type key1.txt^|jq -r .vrfPublicKey') do ( set GVKPUBLIC=%%i)
echo GVKPUBLIC = %GVKPUBLIC% >>keys.txt

for /F %%i in ('%BOOTSTRAP% generateProofInfo {\"seed\": \"%SEED5%\"^,\"keyCount\":7^,\"threshold\":5}^>key1.txt') do (%%i)
for /F %%i in ('type key1.txt^|jq -r .genSysConstant') do ( set GPIGENSYS=%%i)
echo GPIGENSYS = %GPIGENSYS% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .verificationKey') do ( set GPIVK=%%i)
echo GPIVK = %GPIVK% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[0].schnorrSecret') do ( set GPISCHSEC1=%%i)
echo GPISCHSEC1 = %GPISCHSEC1% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[0].schnorrPublicKey') do ( set GPISCHPUB1=%%i)
echo GPISCHPUB1 = %GPISCHPUB1% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[1].schnorrSecret') do ( set GPISCHSEC2=%%i)
echo GPISCHSEC2 = %GPISCHSEC2% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[1].schnorrPublicKey') do ( set GPISCHPUB2=%%i)
echo GPISCHPUB2 = %GPISCHPUB2% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[2].schnorrSecret') do ( set GPISCHSEC3=%%i)
echo GPISCHSEC3 = %GPISCHSEC3% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[2].schnorrPublicKey') do ( set GPISCHPUB3=%%i)
echo GPISCHPUB3 = %GPISCHPUB3% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[3].schnorrSecret') do ( set GPISCHSEC4=%%i)
echo GPISCHSEC4 = %GPISCHSEC4% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[3].schnorrPublicKey') do ( set GPISCHPUB4=%%i)
echo GPISCHPUB4 = %GPISCHPUB4% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[4].schnorrSecret') do ( set GPISCHSEC5=%%i)
echo GPISCHSEC5 = %GPISCHSEC5% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[4].schnorrPublicKey') do ( set GPISCHPUB5=%%i)
echo GPISCHPUB5 = %GPISCHPUB5% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[5].schnorrSecret') do ( set GPISCHSEC6=%%i)
echo GPISCHSEC6 = %GPISCHSEC6% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[5].schnorrPublicKey') do ( set GPISCHPUB6=%%i)
echo GPISCHPUB6 = %GPISCHPUB6% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[6].schnorrSecret') do ( set GPISCHSEC7=%%i)
echo GPISCHSEC7 = %GPISCHSEC7% >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .schnorrKeys[6].schnorrPublicKey') do ( set GPISCHPUB7=%%i)
echo GPISCHPUB7 = %GPISCHPUB7% >> keys.txt


echo { > key1.txt
for /F %%i in ('zen-cli sc_create 10 "%GKPUBLIC%" 10 "%GPIVK%" "%GVKPUBLIC%" "%GPIGENSYS%"^|findstr :^>^>key1.txt') do ( %%i)
echo } >> key1.txt
Wscript sleep.vbs

for /F %%i in ('type key1.txt^|jq -r .txid') do ( set TXID=%%i)
echo TXID=%TXID%  >> keys.txt
for /F %%i in ('type key1.txt^|jq -r .scid') do ( set SCID=%%i)
echo SCID=%SCID%  >> keys.txt

for /F %%i in ('zen-cli generate 1 ^>key1.txt') do (%%i)
for /F %%i in ('type key1.txt^|jq -r .[0]') do ( set GENERATE=%%i)
echo GENERATE=%GENERATE%  >> keys.txt
Wscript sleep.vbs

for /F %%i in ('zen-cli getscgenesisinfo "%SCID%"') do ( set SCGENESISINFO=%%i)
echo SCGENESISINFO = %SCGENESISINFO% >> keys.txt
Wscript sleep.vbs

for /F %%i in ('%BOOTSTRAP% genesisinfo {\"info\": \"%SCGENESISINFO%\"^, \"secret\": \"%GKSECRET%\"^, \"vrfSecret\": \"%GVKSECRET%\"}^>key1.txt') do (%%i)
Wscript sleep.vbs

for /F %%i in ('type key1.txt^|jq -r .scGenesisBlockHex') do ( set BLOCKHEX=%%i)
echo BLOCKHEX=%BLOCKHEX%>> keys.txt
for /F %%i in ('type key1.txt^|jq -r .powData') do ( set POWDATA=%%i)
echo POWDATA=%POWDATA%>> keys.txt
for /F %%i in ('type key1.txt^|jq -r .mcBlockHeight') do ( set MCBH=%%i)
echo MCBH=%MCBH%>> keys.txt
for /F %%i in ('type key1.txt^|jq -r .mcNetwork') do ( set MCNT=%%i)
echo MCNT=%MCNT%>> keys.txt
for /F %%i in ('type key1.txt^|jq -r .withdrawalEpochLength') do ( set EPOCH=%%i)
echo EPOCH=%EPOCH%>> keys.txt

cd Sidechains-SDK

copy examples\simpleapp\src\main\resources\settings_basic.conf examples\simpleapp\src\main\resources\my-sidechain.conf /y

sed -i -e "s/\"seed1\"/\"%SEED4%\"/" examples\simpleapp\src\main\resources\my-sidechain.conf

sed -i -e "s/signersPublicKeys =/signersPublicKeys = [\"%GPISCHPUB1%\",\r\n\"%GPISCHPUB2%\",\r\n\"%GPISCHPUB3%\",\r\n\"%GPISCHPUB4%\",\r\n\"%GPISCHPUB5%\",\r\n\"%GPISCHPUB6%\",\r\n\"%GPISCHPUB7%\"\r\n]\r\n/" examples\simpleapp\src\main\resources\my-sidechain.conf
sed -i -e "s/signersSecrets =/signersSecrets = [\"%GPISCHSEC1%\",\r\n\"%GPISCHSEC2%\",\r\n\"%GPISCHSEC3%\",\r\n\"%GPISCHSEC4%\",\r\n\"%GPISCHSEC5%\",\r\n\"%GPISCHSEC6%\",\r\n\"%GPISCHSEC7%\"\r\n]\r\n/" examples\simpleapp\src\main\resources\my-sidechain.conf
sed -i -e "s/signersThreshold =/signersThreshold = 5\r\n/" examples\simpleapp\src\main\resources\my-sidechain.conf
sed -i -e "s/zencliCommandLine = \"\"/zencliCommandLine = \"zen-cli\"/" examples\simpleapp\src\main\resources\my-sidechain.conf
sed -i -e "s/verificationKeyFilePath = \"..\/..\/sdk\/src\/test\/resources\/sample_vk_7_keys_with_threshold_5\"/verificationKeyFilePath = \"sdk\/src\/test\/resources\/sample_vk_7_keys_with_threshold_5\"/" examples\simpleapp\src\main\resources\my-sidechain.conf
sed -i -e "s/provingKeyFilePath = \"..\/..\/sdk\/src\/test\/resources\/sample_proving_key_7_keys_with_threshold_5\"/provingKeyFilePath = \"sdk\/src\/test\/resources\/sample_proving_key_7_keys_with_threshold_5\"/" examples\simpleapp\src\main\resources\my-sidechain.conf
sed -i -e "s/genesisSecrets =/genesisSecrets =[\"%GKSECRET%\",\r\n\"%GVKSECRET%\"\r\n]\r\n/" examples\simpleapp\src\main\resources\my-sidechain.conf
sed -i "$ d" examples/simpleapp/src/main/resources/my-sidechain.conf
sed -i -e "s/submitterIsEnabled =/submitterIsEnabled = true\r\n/" examples\simpleapp\src\main\resources\my-sidechain.conf

echo genesis { >> examples\simpleapp\src\main\resources\my-sidechain.conf
echo scGenesisBlockHex = "%BLOCKHEX%" >> examples\simpleapp\src\main\resources\my-sidechain.conf
echo scId = "%SCID%" >> examples\simpleapp\src\main\resources\my-sidechain.conf

echo powData = "%POWDATA%" >> examples\simpleapp\src\main\resources\my-sidechain.conf
echo mcBlockHeight = %MCBH% >> examples\simpleapp\src\main\resources\my-sidechain.conf
echo mcNetwork = %MCNT% >> examples\simpleapp\src\main\resources\my-sidechain.conf
echo withdrawalEpochLength = %EPOCH% >> examples\simpleapp\src\main\resources\my-sidechain.conf
echo } >> examples\simpleapp\src\main\resources\my-sidechain.conf
echo } >> examples\simpleapp\src\main\resources\my-sidechain.conf
sed -i -e "s/seed1/%SEED4%/" examples\simpleapp\src\main\resources\my-sidechain.conf

java -cp .\examples\simpleapp\target\sidechains-sdk-simpleapp-0.2.6.jar;.\examples\simpleapp\target\lib\* com.horizen.examples.SimpleApp .\examples\simpleapp\src\main\resources\my-sidechain.conf
