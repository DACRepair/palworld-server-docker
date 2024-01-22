FROM cm2network/steamcmd:root

LABEL maintainer="thijs@loef.dev"
LABEL maintainer="dacrepair@gmail.com"

ENV PORT=8211
ENV PLAYERS=16
ENV MULTITHREADING false
ENV COMMUNITY false
ENV PUBLIC_IP ''
ENV PUBLIC_PORT ''
ENV SERVER_PASSWORD ''
ENV SERVER_NAME 'A Cool Docker Palworld Server'
ENV ADMIN_PASSWORD topsecret
ENV UPDATE_ON_BOOT true

RUN apt-get update && apt-get install -y --no-install-recommends xdg-user-dirs=0.17-2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./scripts/* /home/steam/server/
RUN chmod +x /home/steam/server/*.sh

WORKDIR /home/steam/server

EXPOSE ${PORT}
ENTRYPOINT ["/home/steam/server/init.sh"]