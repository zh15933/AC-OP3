#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# 针对 x86 & ImmortalWrt 25 深度优化版 (已集成最新 PassWall 与全新官方 Nikki)

# 后台IP设置
export Ipv4_ipaddr="192.168.5.1"            # 修改openwrt后台地址(填0为关闭)
export Netmask_netm="255.255.255.0"         # IPv4 子网掩码(填0为不作修改)
export Op_name="0"                          # 修改主机名称(填0为不作修改)

# 内核和系统分区大小 (x86 软路由大分区)
export Kernel_partition_size="64"            # 内核分区大小(MB)
export Rootfs_partition_size="1024"          # 系统分区大小(MB)

# 默认主题设置
export Mandatory_theme="argon"              
export Default_theme="argon"                

# 旁路由选项
export Gateway_Settings="192.168.5.3"       
export DNS_Settings="223.5.5.5 114.114.114.114"                     
export Broadcast_Ipv4="192.168.5.255"       
export Disable_DHCP="1"                     
export Disable_Bridge="1"                   
export Create_Ipv6_Lan="0"                  

# IPV6、IPV4 选择
export Enable_IPV6_function="0"             
export Enable_IPV4_function="1"             

# 替换OpenClash的源码(默认master分支)
export OpenClash_branch="0"                 

# 个性签名
export Customized_Information="灵梦 $(TZ=UTC-8 date "+%Y.%m.%d")"  

# 更换固件内核
export Replace_Kernel="0"                    

# 设置免密码登录
export Password_free_login="1"               

# 增加AdGuardHome插件和核心
export AdGuardHome_Core="0"                  

# === 编译特性（Imm 25 默认 FW4 架构） ===
export Enable_FW4="1"                    
export Preload_GeoData="1"               

# 开启NTFS格式盘挂载
export Automatic_Mount_Settings="0"          

# 去除网络共享
export Disable_autosamba="1"                 

# 其他
export Ttyd_account_free_login="1"           
export Delete_unnecessary_items="0"          
export Disable_53_redirection="0"            
export Cancel_running="0"                    


# =========================================================
# ⚡ 核心修复一：清理所有冲突、失效的旧版插件（斩草除根）
# =========================================================
rm -rf package/passwall-packages package/passwall-luci package/nikki package/custom/nikki

# 彻底清理 datout 真实源码目录中的冲突和旧依赖
if [ -d "feeds/datout" ]; then
  echo "正在从 feeds 真实源码目录中清理 datout 冲突组件..."
  rm -rf feeds/datout/luci-app-ssr-plus
  rm -rf feeds/datout/luci-app-passwall
  rm -rf feeds/datout/nikki
  rm -rf feeds/datout/xray-core
  rm -rf feeds/datout/shadowsocks-rust
fi

# 彻底清理 package/feeds 下对应的软链接快捷方式
if [ -d "package/feeds/datout" ]; then
  echo "正在清理 package 软链接中的对应组件..."
  rm -rf package/feeds/datout/luci-app-ssr-plus
  rm -rf package/feeds/datout/luci-app-passwall
  rm -rf package/feeds/datout/nikki
  rm -rf package/feeds/datout/xray-core
  rm -rf package/feeds/datout/shadowsocks-rust
fi

# =========================================================
# ⚡ 核心修复二：克隆最新适配的 PassWall 源码
# =========================================================
echo "正在拉取最新官方 PassWall 源码..."
[ -d "feeds/packages" ] && rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,mic}
[ -d "feeds/luci" ] && rm -rf feeds/luci/applications/luci-app-passwall

git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages package/passwall-packages || true
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall package/passwall-luci || true


# =========================================================
# ⚡ 核心修复三：拉取官方正版、适配全新 FW4 与 25 版本的 Nikki
# =========================================================
echo "正在从官方主分支拉取最新版本的 Nikki 源码..."
# 将官方最新版 OpenWrt-nikki 克隆到自定义 package 目录
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-nikki.git package/custom/nikki || true


# =========================================================
# ⚡ 核心修复四：依赖清理与自定义额外插件
# =========================================================
if [ -d "feeds/packages" ]; then
  rm -rf feeds/packages/net/cloudreve
  rm -rf feeds/packages/net/filebrowser
  rm -rf feeds/packages/multimedia/sub-web
fi

# 克隆自定义 LuCI 界面（luci-app-fakehttp）
git clone --depth=1 https://github.com/yingziwu/luci-app-fakehttp package/custom/luci-app-fakehttp || true


# =========================================================
# 汉化与菜单名称美化 (已过滤排除安全关键字，保证渲染不报 JavaScript 错)
# =========================================================
echo "针对 Imm 25 客户端渲染资源进行汉化美化..."
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