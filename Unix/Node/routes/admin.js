//admin.js

//Require express and express-router
const express = require('express');
var router = express.Router();

//Require the user.js file for add user functionality
const userjs = require('./user');
var add = userjs.addUser;

//Require mongoose model
var User = require('../models/user.model');

//Checks if admin, only then allows to use the following functionalities
function adminCheck(req, res, next) {
    if (req.session.admin) {
        next();
    } else {
        res.redirect("/auth/adminLogin");
    }
}
router.use(adminCheck);

//View all users based on some filter, leave blank if none
router.get('/', (req, res) => {
    User.find({
        //Put conditions to filter, if any
    }, (err, docs) => {
        if (!err) {
            User.countDocuments({
                //Put conditions to filter counts, if any
            }, (err, counter) => {
                if (!err) {
                    res.render("admin/viewUsers", {
                        list: docs,
                        count: counter
                    });
                } else {
                    console.log(`/view - User.find/count - Error`)
                    res.send("Server Error");
                }
            });
        } else {
            res.send("Could not get user list.");
            console.log('Error in retrieving user list: ' + err);
        }
    }).sort({
        '_id': -1
    });
});

//Add user from admin panel
router.get('/add', (req, res) => {
    res.render("user/register");
});

//Post request
router.post('/add', (req, res) => {
    add(req, res);
});

//Delete user by id
router.get('/delete/:id', (req, res) => {
    User.findByIdAndRemove(req.params.id, (err, doc) => {
        if (!err) {
            res.redirect('/admin');
        }
        else {
            console.log('Error in user delete: ' + err);
            res.send("Server error");
        }
    });
});

//Update user data from admin panel
router.post('/update/:id', (req, res) => {

    let user = new User();
    user.name = req.body.name.toString().trim();
    user.mobile = req.body.mobile.toString().trim();
    user.email = req.body.email.toString().trim();
    user.password = req.body.password.toString().trim();

    User.findOneAndUpdate({
        id: req.params.id
    }, {
        name: user.name,
        mobile: user.mobile,
        email: user.email,
        password: user.password
    }, (err, doc) => {
        if(!err) {
            res.redirect('/admin');
            console.log(doc);
        }
        else {
            console.log('Error in user update:' + err);
            res.send("Server error");
        }
    });
});

module.exports = router;
