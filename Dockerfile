# Build a JAR File
FROM alpine AS stage1
RUN apk add --no-cache maven
WORKDIR /home/app
COPY . .
RUN mvn -f /home/app/pom.xml clean package

# Create an Image
FROM alpine
RUN apk add --no-cache openjdk17-jre
EXPOSE 5000
COPY --from=stage1 /home/app/target/hello-world-java.jar hello-world-java.jar
ENTRYPOINT ["sh", "-c", "java -jar /hello-world-java.jar"]
