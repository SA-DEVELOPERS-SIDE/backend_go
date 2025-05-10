# Step 1: Build the Go application
FROM golang:1.24.3-buster as builder  # Use Go version 1.24.3 and Debian Buster

WORKDIR /app
COPY . .

RUN go mod tidy
RUN go build -o main .

# Step 2: Create a smaller image for running the application
FROM debian:bullseye-slim

WORKDIR /root/
COPY --from=builder /app/main .

# Install necessary libraries
RUN apt-get update && apt-get install -y libc6

EXPOSE 8080
CMD ["./main"]
