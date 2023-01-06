FROM node:14-alpine3.15

ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

# Create app directory
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# If you are building your code for production
RUN npm install --production

# Bundle app source
COPY . .

EXPOSE 4000
CMD [ "node", "server.js" ]