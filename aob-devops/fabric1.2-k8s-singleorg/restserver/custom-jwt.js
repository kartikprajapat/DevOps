'use strict';

const passportJwt = require('passport-jwt');
const util = require('util');

function CustomJwtStrategy(options, verify) {
    options.jwtFromRequest = passportJwt.ExtractJwt.fromAuthHeaderAsBearerToken();
    passportJwt.Strategy.call(this, options, verify);
}
util.inherits(CustomJwtStrategy, passportJwt.Strategy);

module.exports = {
    Strategy: CustomJwtStrategy
};
/*
console.log(CustomJwtStrategy.super_ === passportJwt.Strategy);

var newStrategy = new CustomJwtStrategy({secretOrKey:'asd'},() => console.log('Inside'));

console.log('Hello world');
*/
