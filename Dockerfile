# Use official Golang image as a build environment
FROM golang:1.24.3 as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy everything from the current directory to the working directory
COPY . .

# Download dependencies
RUN go mod tidy

# Build the Go app
RUN go build -o main .

# Start a new stage from a smaller image (debian)
FROM debian:bullseye-slim

WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/main .

# Expose port 8080
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
