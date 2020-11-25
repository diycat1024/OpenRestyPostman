## OpenRestyPostMan
### 项目概述
这是一个用openresty制作的可以用来发送post请求的工具。后面我会把postman的功能添加进来。

## 目录说明
```
/
├── conf/nginx.conf 配置文件
├── logs
├── lua/tpl     模板目录  
├── lua/web     控制器
├── lualib      三方库
├── mvc.lua     入口文件/解析uri
├── reload.sh
├── start.sh    
```
## 使用方式
### 安装OpenResty
```
$ sudo apt-get -y install --no-install-recommends wget gnupg ca-certificates
$ echo  "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"  | sudo tee /etc/apt/sources.list.d/openresty.list
$ sudo apt-get update
$ sudo apt-get -y install openresty
```
设置环境变量
```
$ sudo vim ~/.bashrc
/usr/local/openresty/nginx/sbin/

$ source ~/.bashrc
```
### 下载OpenRestyPostMan
```
git clone https://github.com/diycat1024/OpenRestyPostman.git
```
### 启动　& 重启　脚本
```
start.sh
reload.sh
```

### 项目依赖
 [lua-resty.http](https://github.com/ledgetech/lua-resty-http)
 
 [lua-resty.template](https://github.com/bungle/lua-resty-template)
 