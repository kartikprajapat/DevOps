var maxTime = 1000;
//if even then double else error

var evenDoubler = function(v, callback) {
    if (v%2==0) {
        const data = v*2
        callback(null, data, new Date)
    } else {
        console.log("Error as we given odd number")
    }
    
};


var handleResults = function (err, result) {
    if (err) {
        console.log(err.message);
    } else {
        console.log("Result: " + result);
        //console.log("Time: " + time)
    }
};

for (let i = 0; i < 10; i++) {
    console.log("Loop called for: "+ i)
    evenDoubler(i, handleResults);
}

// evenDoubler(2, handleResults);
// evenDoubler(3, handleResults);
// evenDoubler(4, handleResults);
// evenDoubler(5, handleResults);

console.log("-------------------------------Program started-------------------------------")
