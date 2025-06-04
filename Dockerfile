# Base image with Java 8 (required by Forge 1.12.2)
FROM openjdk:8-jdk-alpine

# Add bash and other basic tools
RUN apk add --no-cache bash tzdata

# Set working directory inside the container
WORKDIR /minecraft

# Copy server files into the container
COPY . /minecraft

# Set environment variable so EULA doesn't get rejected
ENV EULA=true

# Expose default Minecraft port
EXPOSE 25565

# Optional: set timezone (replace with your own if desired)
ENV TZ=America/Los_Angeles

# Start the Forge server
CMD ["java", "-Xms2G", "-Xmx4G", "-jar", "forge-1.12.2-14.23.5.2860.jar", "nogui"]

