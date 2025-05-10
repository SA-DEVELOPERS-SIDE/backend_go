# Stage 1: Build
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Only copy go.mod
COPY go.mod ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the Go binary
RUN go build -o server .

# Stage 2: Lightweight runtime
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/server .

EXPOSE 5000

CMD ["./server"]
