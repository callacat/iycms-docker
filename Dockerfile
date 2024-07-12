# 选择一个更小的基础镜像
FROM alpine:latest

# 设置工作目录
WORKDIR /iycms

# 安装必要的工具
RUN apk add --no-cache wget unzip

# 检测架构并下载相应架构的CMS包
RUN arch=$(uname -m) && \
    if [ "$arch" = "x86_64" ]; then \
        wget https://iycms.com/api/static/version/main/linux/cms-linux_x86-64-v3.3.44.zip -O cms.zip; \
    elif [ "$arch" = "aarch64" ]; then \
        wget https://iycms.com/api/static/version/main/linux/cms-linux_arm64-v3.3.44.zip -O cms.zip; \
    else \
        echo "Unsupported architecture: $arch" && exit 1; \
    fi && \
    unzip cms.zip && \
    rm cms.zip

# 进入iycms目录
WORKDIR /iycms

# 添加执行权限
RUN chmod +x cms

# 暴露端口
EXPOSE 21007

# 启动CMS程序
CMD ["./cms"]
