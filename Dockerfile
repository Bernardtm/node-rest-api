# ---- Base Node ----
FROM node:8 AS base
# install node
#RUN apk add --no-cache nodejs-current tini
# set working directory
WORKDIR /nodejs
# copy project file
COPY package.json .

#
# ---- Dependencies ----
FROM base AS dependencies
# install ALL node_modules, including 'devDependencies'
RUN npm install
# install nodemon globally
RUN npm install nodemon

# ---- Release ----
FROM base AS release
# copy production node_modules
COPY --from=dependencies /nodejs/node_modules ./node_modules
# copy app sources
COPY . .
# expose port and define CMD
EXPOSE 3333
# CMD
CMD npm run dev