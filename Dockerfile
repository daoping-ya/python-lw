FROM python:3.10-alpine

WORKDIR /app

COPY . .

# 添加以下两行：创建并切换到非 root 用户
RUN adduser -D choreouser
USER choreouser

EXPOSE 3000

RUN apk update && apk --no-cache add openssl bash curl && \
    chmod +x app.py && \
    pip install -r requirements.txt

CMD ["python3", "app.py"]
