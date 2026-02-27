FROM python:3.10-alpine

WORKDIR /app

COPY . .

# 第一步：以 root 权限安装所有依赖和设置权限
RUN apk update && apk --no-cache add openssl bash curl && \
    chmod +x app.py && \
    pip install -r requirements.txt

# 第二步：安装完成后，再创建并切换到非 root 用户
RUN adduser -D choreouser
USER choreouser

EXPOSE 3000

CMD ["python3", "app.py"]
