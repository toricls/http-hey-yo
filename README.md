# http-hey-yo

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)][license]
[![Hey, Yo!](https://img.shields.io/badge/Hey-Yo!-orange.svg?style=flat-square)][hey-yo]

[license]: https://github.com/toricls/http-hey-yo/blob/master/LICENSE
[hey-yo]: https://github.com/topics/hey-yo
Returns any HTTP status code you want, as a simple http server

## Usage

```shell
$ docker run -p 1500:1500 \
  -e RESPONSE_HTTP_STATUS_CODE=503 \
  -e LISTEN_PORT=1500 \
  toricls/http-hey-yo
```

then, you'll see a simple HTTP server launched.

```shell
2020-08-13T09:11:22+0000 RESPONSE_HTTP_STATUS_CODE: 503
2020-08-13T09:11:22+0000 LISTEN_PORT              : 1500
2020-08-13T09:11:22+0000 HTTP server being ready

```

Let's curl to it.

```shell
$ curl -i http://localhost:1500
HTTP/1.1 503 Service Unavailable

2020-08-13T08:58:39+0000 Hey, Yo!

$ curl -i http://localhost:1500/meaninglesspath
HTTP/1.1 503 Service Unavailable

2020-08-13T08:59:04+0000 Hey, Yo!
```

## Runtime options (as container environment variables)

### 1. `RESPONSE_HTTP_STATUS_CODE`

The default value is `200`. Set this value to change the HTTP response status code of http-hey-yo.

### 2. `LISTEN_PORT`

The default value is `8080`. Set this value to change the listen port of http-hey-yo.

## Contribution

1. Fork ([https://github.com/toricls/http-hey-yo/fork](https://github.com/toricls/http-hey-yo/fork))
1. Create a feature branch
1. Commit your changes
1. Rebase your local changes against the master branch
1. Create a new Pull Request

## Licence

[MIT](LICENSE)

## Author

[Tori](https://github.com/toricls)
