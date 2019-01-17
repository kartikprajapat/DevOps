# Node Modules

Modules are the way to include external functionality in your node application.

       Modules can export :    
        1. Variable
        2. Functions
        3. Objects


There are three main sources of the modules:

       1. Built-in Modules
       2. Your Project files
       3. 
 
 
# Built-in Modules

1. They come pre packaged with the Node.

2. Are require()'d by a simple string identifier.
       
       var fs =require('fs')
       
3. Below are some Built-in Modules

       fs  --->  accessing file system
       http  ---> creating and responding http request
       crypto  --->  for cryptographic operations
       os  


# Project files

1. In node each .js file is its own module
2. This is used to modulerize the application's code.
3. Each file is require()'d with the file-system like semantics:

       var data = require('./data');  //we can require file in the same directory
       
       var foo = require('./other/foo'); // require file in the sub directory
       
       var bar = require('../anyother/bar') // require file in any other directory
       
 
 Note: Here ./ prefix is required in every file's name and .js suffix is not needed (e.x: ./data)
 
4. Single variable require() is still valid here:
 
       var justOnce = require(./data).justOnce; // here we are aquiring the single variable from the another file.
       
5. For assigning the value of variable from one file to the another can be done through "module.exports".

Say there are 2 files one.js and two,js

       one.js
       
       var count = 2
       var v = function(i, callback){
              //do something
       }
       
       module.exports.v = v;
       module.exports.foo = bar;
       
       
       
       
       two.js
       
       var one = require('./one')
       var v = one.v(23, function(err, result)){
              //do something
       }
       console.log(one.count) // this will throw error as we have not expored this in one.js
