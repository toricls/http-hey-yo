#!/bin/sh

Body="Hey, Yo!"

trap HandleSigTerm SIGINT SIGTERM

HandleSigTerm () {
  Output "Shutting down"
  exit 0
}

Output () {
  msg="$1"
  ts=$(date -I'seconds')
  echo "${ts} ${msg}"
}

ResponseCode=200
if [ "x${RESPONSE_HTTP_STATUS_CODE}" != "x" ]; then
  ResponseCode=${RESPONSE_HTTP_STATUS_CODE}
fi

ListenPort=8080
if [ "x${LISTEN_PORT}" != "x" ]; then
  ListenPort=${LISTEN_PORT}
fi

# TODO: Should respect HTTP methods maybe?
case ${ResponseCode} in 
  # 2xx
  200) t="OK" ;;
  201) t="Created" ;;
  202) t="Accepted" ;;
  203) t="Non-Authoritative Information" ;;
  204) t="No Content" ;;
  205) t="Reset Content" ;;
  # 3xx
  300) t="Multiple Choices" ;;
  301) t="Moved Permanently" ;; # TODO: Support location header
  302) t="Found" ;;
  303) t="See Other" ;;
  304) t="Not Modified" ;;
  305) t="Use Proxy" ;;
  307) t="Temporary Redirect" ;; # TODO: Support location header
  # 4xx
  400) t="Bad Request" ;;
  401) t="Unauthorized" ;;
  402) t="Payment Required" ;;
  403) t="Forbidden" ;;
  404) t="Not Found" ;;
  405) t="Method Not Allowed" ;;
  406) t="Not Acceptable" ;;
  407) t="Proxy Authentication Required" ;;
  408) t="Request Timeout" ;;
  409) t="Conflict" ;;
  410) t="Gone" ;;
  411) t="Length Required" ;;
  412) t="Precondition Failed" ;;
  413) t="Payload Too Large" ;;
  414) t="URI Too Long" ;;
  415) t="Unsupported Media Type" ;;
  416) t="Range Not Satisfiable" ;;
  417) t="Expectation Failed" ;;
  # 5xx
  500) t="Internal Server Error" ;;
  501) t="Not Implemented" ;;
  502) t="Bad Gateway" ;;
  503) t="Service Unavailable" ;;
  504) t="Gateway Timeout" ;;
  505) t="HTTP Version Not Supported" ;;
  *)   ResponseCode=400 && t="Bad Request" && Body="Whoa! I've never heard such HTTP status code!" ;;
esac

Output "RESPONSE_HTTP_STATUS_CODE: ${ResponseCode}"
Output "LISTEN_PORT              : ${ListenPort}"
Output "HTTP server being ready"
while true
do
  { echo -e "HTTP/1.1 ${ResponseCode} ${t}\r\n"; Output "${Body}"; } | nc -l -k -w 1 -p ${ListenPort} 2> /dev/null;
done
