var os = require('os');

var toMB = function(v) {
    return(Math.round(((v/1024/1024)*100)/100));
}

console.log('Hostname: '+os.hostname);

console.log('Uptime:' +os.totalmem);

console.log('User Info: '+os.userInfo);

console.log('Total Memory: '+ toMB(os.totalmem));
