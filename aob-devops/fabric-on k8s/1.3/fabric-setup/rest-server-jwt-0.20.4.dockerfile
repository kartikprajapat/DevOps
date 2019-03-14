FROM hyperledger/composer-rest-server:0.20.4

RUN npm install --production loopback-connector-mongodb passport-jwt && \
    npm cache clean --force && \
    ln -s node_modules .node_modules

COPY custom-jwt.js node_modules/custom-jwt.js
