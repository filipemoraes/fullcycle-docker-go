FROM golang:alpine AS build
RUN apk add --no-cache upx
WORKDIR /app
COPY . .
RUN go mod init fullcycle
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o main .
RUN upx --best main
# RUN go build -o main .

FROM scratch
COPY --from=build /app/main /app/main
ENTRYPOINT ["/app/main"]