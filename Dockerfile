FROM busybox

COPY . .
RUN chmod +x ./http-hey-yo.sh

ENTRYPOINT [ "./http-hey-yo.sh" ]
