### Clone composer binaries

git clone https://github.com/hyperledger/composer.git

### go to composer-common packages and add to private npm registry

1.  cd npm-modules/composer/packages/composer-common

2. npm adduser --registry  <rgistry-url>

3. npm publish --registry  <rgistry-url>