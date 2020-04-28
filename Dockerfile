FROM golang:1.13.5-alpine3.10 as builder
COPY go.* /modbuild/
WORKDIR /modbuild
ENV GOPROXY=https://proxy.golang.org
RUN go mod download
COPY *.go /modbuild/
RUN go build -o /sparge *.go

FROM alpine:3.10
EXPOSE 8080
COPY --from=builder /sparge /sparge
ADD public public
CMD [ "./sparge", "start" ]