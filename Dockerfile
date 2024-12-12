# 베이스 이미지로 OpenJDK 사용
FROM openjdk:17-jdk-slim

# JAR 파일을 컨테이너의 /app 디렉토리에 복사
COPY build/libs/DuoSync-0.0.1-SNAPSHOT.jar /app/DuoSync.jar


# 컨테이너의 8080 포트를 열어줍니다.
EXPOSE 8080

# JAR 파일을 실행
ENTRYPOINT ["java", "-jar", "/app/DuoSync.jar"]