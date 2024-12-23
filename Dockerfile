# Step 1: Use a Gradle image to build the application
FROM gradle:8.3-jdk17 AS builder

# Set the working directory
WORKDIR /app

# Copy only build-related files
COPY build.gradle settings.gradle gradlew ./
COPY gradle gradle

# Download dependencies
RUN ./gradlew dependencies --no-daemon

# Copy application source code
COPY src src

# Build the application
RUN ./gradlew bootJar --no-daemon

# Step 2: Use a slim JDK image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built jar from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
