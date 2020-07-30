FROM node:current-alpine

WORKDIR /usr/src/app

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash git openssh && \
    apk add curl

RUN npm install -g pm2

RUN git clone https://github.com/domenester/logeasy-frontend.git
RUN git clone https://github.com/domenester/logeasy-backend.git

# COPY ./logeasy-backend ./logeasy-backend
# COPY ./logeasy-frontend ./logeasy-frontend

COPY config.json /var/log/logeasy/
COPY process.yml .

RUN cd logeasy-backend && npm i && npm run build && \
    cd ../logeasy-frontend && npm i && npm run build

EXPOSE 3666 3665

CMD ["pm2-runtime", "process.yml"]