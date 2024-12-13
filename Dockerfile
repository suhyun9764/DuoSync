FROM openjdk:17-jdk-slim

# Gradle 설치
RUN apt-get update && apt-get install -y gradle

# 프로젝트 파일 복사
COPY . /app

# 작업 디렉토리 설정
WORKDIR /app

# Gradle 빌드
RUN gradle build

# JAR 파일 복사
COPY build/libs/DuoSync-0.0.1-SNAPSHOT.jar /app/DuoSync.jar

EXPOSE 8080

# JAR 파일 실행
ENTRYPOINT ["java", "-jar", "/app/DuoSync.jar"]
