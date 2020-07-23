FROM node:12-alpine

ENV PORT 8080

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json yarn.lock /usr/src/app/
RUN yarn install

COPY . /usr/src/app

RUN yarn build

EXPOSE 8080
CMD ["yarn", "start", "-p", "8080"]
