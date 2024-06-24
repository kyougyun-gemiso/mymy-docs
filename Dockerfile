# Nginx 이미지 기반
FROM nginx:alpine

# MkDocs 빌드된 파일들을 Nginx html 디렉토리에 복사
COPY site /usr/share/nginx/html
