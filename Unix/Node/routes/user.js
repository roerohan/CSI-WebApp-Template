//user.js

//Require express and express-router
var express = require('express');
var router = express.Router();

//For password hashing
var bcrypt = require('bcrypt');

//Import the model
var User = require('../models/user.model');

//Verify if the password is valid (8-16 characters)
function verifyPassword(password) {
    const passwordRegex = /^[a-zA-Z0-9`!@#$%^&*()-/:'.,{}"~]{8,16}$/;
    return passwordRegex.test(password);
}

//Verify if the email is valid
function verifyEmail(email) {
    const emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return (emailRegex.test(email) && email.length <= 254);
}

//Verify if the mobile is valid
function verifyMobile(mobile) {
    const mobileRegex = /^[6-9]\d{8,9}$/;
    return mobileRegex.test(mobile);
}

//To Add User
function addUser(req, res) {
    let user = new User();
    user.name = req.body.name.toString().trim();

    user.email = req.body.email.toString().toLowerCase().trim();
    //Verify email
    if (!verifyEmail(user.email)) {
        console.log(`addUser - verifyEmail - Error`);
        res.send('Error');
        return;
    }

    user.password = req.body.password.toString().trim();
    //Verify password
    if (!verifyPassword(user.password)) {
        console.log(`addUser - verifyPassword - Error`);
        res.send("Error");
        return;
    }
    user.mobile = req.body.mobile.toString();
    //Verify mobile
    if (!verifyMobile(user.mobile)) {
        console.log(`addUser - verifyMobile - Error`);
        res.send("Error");
        return;
    }

    //Password hashing
    bcrypt.genSalt(10, function (err, salt) {
        bcrypt.hash(user.password, salt, function (err, hash) {
            user.password = hash;

            //Saving the user module to the database
            user.save((err, doc) => {
                if (!err) {
                    console.log(`User Added Successfully`);
                    res.send("Successfully Registered.");
                } else {
                    if (err.name === "MongoError" && err.code === 11000) {
                        let field = err.errmsg.split('users index: ')[1];
                        field = field.substring(0, field.lastIndexOf('_'));
                        res.send("Duplicate " + field);
                    } else {
                        res.send("Error");
                        console.log("addUser - Error during record insertion: " + err);
                    }
                }
            });
        });
    });
}

//GET request at '/'
router.get('/', (req, res) => {
    if (!req.session.user) {
        res.redirect('/auth/login');
    } else {
        res.render("user/dashboard", {});
    }
});


//GET request at '/register'
router.get('/register', (req, res) => {
    res.render("user/register", {});
});

//POST request at '/register'
router.post('/register', (req, res) => {
    addUser(req, res);
});

// To use Google Recaptcha, uncomment the following code
// router.post('/',(req,res,next)=>{
//     const captcha = req.body['g-recaptcha-response'];
//     const verificationURL = "https://www.google.com/recaptcha/api/siteverify";
//     request.post(verificationURL, {
//         form: {
//             //"secret":"**Enter Your Secret Key Here**",
//             "response": captcha
//         }
//     }, function(err, response, body) {
//         body = JSON.parse(body);
//         if (body.success === true) {
//             insertRecord(req, res);
//         } else {
//             res.send("CaptchaFailed");
//         }
//     });
// });

module.exports = router;
