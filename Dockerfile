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

# normally, in dev, used for developer communication purposes 
# elasticbeanstalk will use this though and create a mapping for traffic on this port.
EXPOSE 80

# only copies over the result of the npm run build command
# everything else is dumped.
COPY --from=builder /app/build /usr/share/nginx/html

# default command in nginx container is to start it up so we can leave it off


