# 选择一个更小的基础镜像
FROM alpine:latest

# 设置工作目录
WORKDIR /iycms

# 安装必要的工具
RUN apk add --no-cache wget unzip

# 下载并解压相应架构的CMS包
ARG ARCH=amd64
RUN if [ "$ARCH" = "amd64" ]; then \
        wget https://iycms.com/api/static/version/main/linux/cms-linux_x86-64-v3.3.44.zip -O cms.zip; \
    else \
        wget https://iycms.com/api/static/version/main/linux/cms-linux_arm64-v3.3.44.zip -O cms.zip; \
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
