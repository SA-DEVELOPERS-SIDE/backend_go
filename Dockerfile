# Stage 1: Build
FROM golang:1.24.3-alpine AS builder

WORKDIR /app

# Only copy go.mod (and go.sum if you ever need it later)
COPY go.mod ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Build the Go binary
RUN go build -o server .

# Stage 2: Minimal runtime
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/server .

EXPOSE 5000

CMD ["./server"]
