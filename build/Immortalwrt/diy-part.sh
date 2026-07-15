#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# 针对 x86 & ImmortalWrt 25 终极优化版 (已集成最新 PassWall + 全新官方 Nikki + 修复版 FakeHTTP)

# 后台IP设置
export Ipv4_ipaddr="192.168.5.1"            # 修改openwrt后台地址(填0为关闭)
export Netmask_netm="255.255.255.0"         # IPv4 子网掩码（默认：255.255.255.0）(填0为不作修改)
export Op_name="OpenWrt"                # 修改主机名称为OpenWrt-123(填0为不作修改)

# 内核和系统分区大小(不是每个机型都可用)
export Kernel_partition_size="32"            # 内核分区大小,每个机型默认值不一样 (填写您想要的数值,默认一般16,数值以MB计算，填0为不作修改),如果你不懂就填0
export Rootfs_partition_size="500"            # 系统分区大小,每个机型默认值不一样 (填写您想要的数值,默认一般300左右,数值以MB计算，填0为不作修改),如果你不懂就填0

# 默认主题设置
export Mandatory_theme="argon"              # 将bootstrap替换您需要的主题为必选主题(可自行更改您要的,源码要带此主题就行,填写名称也要写对) (填写主题名称,填0为不作修改)
export Default_theme="argon"                # 多主题时,选择某主题为默认第一主题 (填写主题名称,填0为不作修改)

# 旁路由选项
export Gateway_Settings="192.168.5.3"                 # 旁路由设置 IPv4 网关(填入您的网关IP为启用)(填0为不作修改)
export DNS_Settings="223.5.5.5 114.114.114.114"                     # 旁路由设置 DNS(填入DNS，多个DNS要用空格分开)(填0为不作修改)
export Broadcast_Ipv4="0"                   # 设置 IPv4 广播(填入您的IP为启用)(填0为不作修改)
export Disable_DHCP="1"                     # 旁路由关闭DHCP功能(1为启用命令,填0为不作修改)
export Disable_Bridge="1"                   # 旁路由去掉桥接模式(1为启用命令,填0为不作修改)
export Create_Ipv6_Lan="0"                  # 爱快+OP双系统时,爱快接管IPV6,在OP创建IPV6的lan口接收IPV6信息(1为启用命令,填0为不作修改)

# IPV6、IPV4 选择
export Enable_IPV6_function="0"             # 编译IPV6固件(1为启用命令,填0为不作修改)(如果跟Create_Ipv6_Lan一起启用命令的话,Create_Ipv6_Lan命令会自动关闭)
export Enable_IPV4_function="1"             # 编译IPV4固件(1为启用命令,填0为不作修改)(如果跟Enable_IPV6_function一起启用命令的话,此命令会自动关闭)

# 替换OpenClash的源码(默认master分支)
export OpenClash_branch="0"                 # OpenClash的源码分别有【master分支】和【dev分支】(填0为关闭,填1为使用master分支,填2为使用dev分支,填入1或2的时候固件自动增加此插件)

# 个性签名,默认增加年月日[$(TZ=UTC-8 date "+%Y.%m.%d")]
export Customized_Information="灵梦 $(TZ=UTC-8 date "+%Y.%m.%d")"  # 个性签名,你想写啥就写啥，(填0为不作修改)

# 更换固件内核
export Replace_Kernel="0"                    # 更换内核版本,在对应源码的[target/linux/架构]查看patches-x.x,看看x.x有啥就有啥内核了(填入内核x.x版本号,填0为不作修改)

# 设置免密码登录(个别源码本身就没密码的)
export Password_free_login="1"               # 设置首次登录后台密码为空（进入openwrt后自行修改密码）(1为启用命令,填0为不作修改)

# 增加AdGuardHome插件和核心
export AdGuardHome_Core="0"                  # 编译固件时自动增加AdGuardHome插件和AdGuardHome插件核心,需要注意的是一个核心20多MB的,小闪存机子搞不来(1为启用命令,填0为不作修改)

# === 可选开关（编译特性） ===
export Enable_FW4="1"                    # 启用 fw4(nftables) 防火墙：1=启用（需要源码支持/会自动尝试拉取 firewall4 包），0=默认 iptables/firewall3
export Preload_GeoData="1"               # 预置 GeoIP/GeoSite 数据：1=编译时下载写入固件（约30MB），0=不预置

# 开启NTFS格式盘挂载
export Automatic_Mount_Settings="0"          # 编译时加入开启NTFS格式盘挂载的所需依赖(1为启用命令,填0为不作修改)

# 去除网络共享(autosamba)
export Disable_autosamba="1"                 # 去掉源码默认自选的luci-app-samba或luci-app-samba4(1为启用命令,填0为不作修改)

# 其他
export Ttyd_account_free_login="1"           # 设置ttyd免密登录(1为启用命令,填0为不作修改)
export Delete_unnecessary_items="0"          # 个别机型内一堆其他机型固件,删除其他机型的,只保留当前主机型固件(1为启用命令,填0为不作修改)
export Disable_53_redirection="0"            # 删除DNS强制重定向53端口防火墙规则(个别源码本身不带此功能)(1为启用命令,填0为不作修改)
export Cancel_running="0"                    # 取消路由器每天跑分任务(个别源码本身不带此功能)(1为启用命令,填0为不作修改)

# 晶晨CPU系列打包固件设置(不懂请看说明)
export amlogic_model="s905d"
export amlogic_kernel="6.1.120_6.12.15"
export auto_kernel="true"
export rootfs_size="512/2560"
export kernel_usage="stable"


# =========================================================
# 🛡️ 安全检查：要求执行位置在 OpenWrt/LEDE 源码根目录
# =========================================================
if [ ! -d "package" ]; then
  echo "ERROR: diy-part.sh 当前目录不是源码根目录（未找到 package/）。"
  echo "PWD=$(pwd)"
  exit 1
fi

mkdir -p package/custom


# =========================================================
# ⚡ 核心修复一：清理 datout 源中过时冲突的科学上网插件
# =========================================================
rm -rf package/passwall-packages package/passwall-luci package/nikki package/custom/nikki

# 1. 清理 feeds 真实下载目录
if [ -d "feeds/datout" ]; then
  echo "正在从 feeds 真实源码目录中清理 datout 冲突组件..."
  rm -rf feeds/datout/luci-app-ssr-plus
  rm -rf feeds/datout/luci-app-passwall
  rm -rf feeds/datout/nikki
  rm -rf feeds/datout/xray-core
  rm -rf feeds/datout/shadowsocks-rust
fi

# 2. 清理 package 映射快捷方式目录
if [ -d "package/feeds/datout" ]; then
  echo "正在清理 package 软链接中的对应组件..."
  rm -rf package/feeds/datout/luci-app-ssr-plus
  rm -rf package/feeds/datout/luci-app-passwall
  rm -rf package/feeds/datout/nikki
  rm -rf package/feeds/datout/xray-core
  rm -rf package/feeds/datout/shadowsocks-rust
fi


# =========================================================
# ⚡ 核心修复二：全面擦除引发 Node 编译报错的僵尸包 (解决 node-pnpm / node-yarn 警告)
# =========================================================
echo "双重保险：正在物理切除 packages 源中残留的 node 僵尸依赖包..."
# 彻底清理真实 feeds 树
rm -rf feeds/packages/net/cloudreve
rm -rf feeds/packages/net/filebrowser
rm -rf feeds/packages/multimedia/sub-web

# 彻底清理 package 软链接映射，防止警告残留
rm -rf package/feeds/packages/cloudreve
rm -rf package/feeds/packages/filebrowser
rm -rf package/feeds/packages/sub-web


# =========================================================
# ⚡ 核心修复三：安全注入最新 PassWall & 官方 Nikki 源码
# =========================================================
echo "正在拉取最新官方 PassWall 源码..."
[ -d "feeds/packages" ] && rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,mic}
[ -d "feeds/luci" ] && rm -rf feeds/luci/applications/luci-app-passwall

git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages || true
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall package/passwall-luci || true

echo "正在从官方主分支拉取最新版本的 Nikki 源码..."
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/custom/nikki || true


# =========================================================
# ⚡ 核心修复四：注入正确的 openwrt-fakehttp 依赖包（解决 fakehttp 缺失警告）
# =========================================================
echo "正在拉取符合 OpenWrt 编译规范的 FakeHTTP 核心及界面..."
rm -rf package/custom/fakehttp package/custom/luci-app-fakehttp

# FakeHTTP 本体核心（采用正确的 openwrt 专属打包库）
git clone --depth=1 https://github.com/yingziwu/openwrt-fakehttp package/custom/fakehttp || true

# LuCI 界面
git clone --depth=1 https://github.com/yingziwu/luci-app-fakehttp package/custom/luci-app-fakehttp || true

# =========================================================
# ⚡ 核心修复五：强制注入“大气层”自动更新环境变量 (完美支持他人 Fork 动态识别)
# =========================================================
echo "正在为自动更新脚本强制注入兼容的‘大气层’动态环境变量..."

# 1. 动态获取当前编译的 GitHub 仓库名称（如果本地为空则回退到你的默认仓库）
CURRENT_REPO="${GIT_REPOSITORY:-zh15933/AC-OP3}"
echo "当前检测到的构建仓库为: ${CURRENT_REPO}"

# 2. 清理系统默认 openwrt_release 中可能冲突的旧自定义变量
if [ -f "package/base-files/files/etc/openwrt_release" ]; then
    sed -i '/AUTOBUILD_FIRMWARE/d' package/base-files/files/etc/openwrt_release
    sed -i '/TARGET_PROFILE/d' package/base-files/files/etc/openwrt_release
    sed -i '/FIRMWARE_SUFFIX/d' package/base-files/files/etc/openwrt_release
    sed -i '/GITHUB_REPOSITORY/d' package/base-files/files/etc/openwrt_release
fi

# 3. 强行追加写入系统默认 release 文件，喂饱 autoupdate 的第一层检测
mkdir -p package/base-files/files/etc
cat >> package/base-files/files/etc/openwrt_release <<-EOF
AUTOBUILD_FIRMWARE="Immortalwrt"
TARGET_PROFILE="x86-64"
FIRMWARE_SUFFIX=".img.gz"
GITHUB_REPOSITORY="${CURRENT_REPO}"
EOF

# 4. 创建独立备份环境文件，确保任何时候都能通过全局内存变量读取
cat > package/base-files/files/etc/openwrt_version_custom <<-EOF
export AUTOBUILD_FIRMWARE="Immortalwrt"
export TARGET_PROFILE="x86-64"
export FIRMWARE_SUFFIX=".img.gz"
export GITHUB_REPOSITORY="${CURRENT_REPO}"
EOF

# 5. 让系统终端启动时，强制自动加载该全局变量
if [ -f "package/base-files/files/etc/profile" ]; then
    sed -i '/openwrt_version_custom/d' package/base-files/files/etc/profile
    echo "[ -f /etc/openwrt_version_custom ] && . /etc/openwrt_version_custom" >> package/base-files/files/etc/profile
fi

# =========================================================
# 汉化与菜单名称美化 (针对 Imm 25 渲染优化)
# =========================================================
echo "针对 Imm 25 客户端资源进行菜单汉化美化..."
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"终端"?"TTYD"?g' 2>/dev/null || true
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"TTYD 终端"?"TTYD"?g' 2>/dev/null || true
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"网络存储"?"NAS"?g' 2>/dev/null || true
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"实时流量监测"?"流量"?g' 2>/dev/null || true
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"KMS 服务器"?"KMS激活"?g' 2>/dev/null || true
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"USB 打印服务器"?"打印服务"?g' 2>/dev/null || true
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"Web 管理"?"Web管理"?g' 2>/dev/null || true
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"管理权"?"改密码"?g' 2>/dev/null || true
find ./package/ -type f \( -name "*.js" -o -name "*.json" -o -name "*.htm" \) 2>/dev/null | xargs -r sed -i 's?"带宽监控"?"监控"?g' 2>/dev/null || true


# 整理固件包过滤设置
if [ -n "$CLEAR_PATH" ]; then
cat >"$CLEAR_PATH" <<-EOF
packages
config.buildinfo
feeds.buildinfo
sha256sums
version.buildinfo
profiles.json
openwrt-x86-64-generic-kernel.bin
openwrt-x86-64-generic.manifest
openwrt-x86-64-generic-squashfs-rootfs.img.gz
EOF
fi

if [ -n "$DELETE" ]; then
cat >>$DELETE <<-EOF
EOF
fi