chcp 65001
@echo off
echo ipconfig 信息如下
ipconfig
echo ===============================================================
echo 路由信息如下
route print -4
set /p type=请选择设置双路由or恢复（1 or 2）: 
echo ===============================================================
if %type% == 1 (
  goto A
) else if %type% == 2 (
  goto B
) else (
  echo "输入错误"
  goto end
)
:A
echo 删除默认配置......
route delete 0.0.0.0
echo 删除成功
echo ===============================================================
set /p kid=请输入外网网卡id: 
echo 新增外网路由......
:C
route add 0.0.0.0 mask 0.0.0.0 192.168.43.1 IF %kid%
set add=""
set /p add=外网路由添加成功，请输入下一个外网网卡id，若没有则直接回车: 
if not %add% == "" (
  set kid=%add%
  goto C
) else (
  echo 外网路由全部添加完毕
)
echo 新增内网路由......
route add 10.10.0.0 mask 255.255.0.0 10.170.240.1 IF 12
route add 10.30.0.0 mask 255.255.0.0 10.170.240.1 IF 12
route add 10.170.0.0 mask 255.255.0.0 10.170.240.1 IF 12
route add 202.107.0.0 mask 255.255.0.0 10.170.240.1 IF 12
route add 192.168.0.0 mask 255.255.0.0 10.170.240.1 IF 12
echo ===============================================================
goto end
:B
echo 删除默认配置......
route delete 0.0.0.0
echo 删除成功
echo ===============================================================
echo 新增内网路由......
route add 0.0.0.0 mask 0.0.0.0 10.170.240.1 IF 12
echo ===============================================================
goto end
:end
echo 路由信息如下
route print -4
echo 按任意键退出
pause
