# 'as' <name> - tags the stage. 
# this is the  'builder' stage

FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build

# /app/build <-- has all relevant files

FROM nginx

# only copies over the result of the npm run build command
# everything else is dumped.
COPY --from=builder /app/build /usr/share/nginx/html

# default command in nginx container is to start it up so we can leave it off


