
FROM golang:1.24.3-buster as builder  

WORKDIR /app
COPY . .

RUN go mod tidy
RUN go build -o main .

FROM debian:bullseye-slim

WORKDIR /root/
COPY --from=builder /app/main .

RUN apt-get update && apt-get install -y libc6

EXPOSE 8080
CMD ["./main"]
