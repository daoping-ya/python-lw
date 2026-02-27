FROM python:3.10-alpine

WORKDIR /app
COPY . .

# 1. 以 root 权限安装依赖
RUN apk update && apk --no-cache add openssl bash curl && \
    pip install --no-cache-dir -r requirements.txt && \
    chmod +x app.py

# 2. 核心修复：直接在镜像里注入环境变量
# 将运行目录设为 /tmp 解决权限崩溃问题
ENV FILE_PATH=/tmp
# 强制程序使用 3000 端口
ENV SERVER_PORT=3000
ENV PORT=3000

# 3. 设置 Choreo 要求的非 root 用户
RUN adduser -D -u 10005 choreouser
USER 10005

EXPOSE 3000

CMD ["python3", "app.py"]
