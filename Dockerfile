FROM python:3.10-alpine

WORKDIR /app

COPY . .

# 1. 以 root 权限安装依赖（必须在切换用户之前完成）
RUN apk update && apk --no-cache add openssl bash curl && \
    chmod +x app.py && \
    pip install -r requirements.txt

# 2. 创建一个 UID 在 10000-20000 之间的用户
# -u 10001 指定用户 ID 为 10001，满足 CKV_CHOREO_1 的要求
RUN adduser -D -u 10001 choreouser
USER 10001

EXPOSE 3000

CMD ["python3", "app.py"]
