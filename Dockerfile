FROM gradle:8.3-jdk17 AS builder
WORKDIR /app

# 복사
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle

# gradlew에 실행 권한 추가
RUN chmod +x gradlew

# 의존성 다운로드
RUN ./gradlew dependencies --no-daemon

# 애플리케이션 소스 복사
COPY src ./src

# 애플리케이션 빌드
RUN ./gradlew build -x test --no-daemon

FROM openjdk:17-jdk-slim
WORKDIR /app

# 빌드된 JAR 복사
COPY --from=builder /app/build/libs/*.jar app.jar

# 애플리케이션 실행
CMD ["java", "-jar", "app.jar"]
