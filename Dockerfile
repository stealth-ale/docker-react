# 1. Build phase

FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# 2. Run phase

# A phase can only have one FROM command
FROM nginx
# This happens to be the directory that nginx serves as default
COPY --from=builder /app/build /usr/share/nginx/html

# NOTE: nginx container's default command starts it so we don't have to specify it