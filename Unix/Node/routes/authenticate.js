//authenticate.js

//Require express and express-router
var express = require('express');
var router = express.Router();

//Set admin user-name and admin-password
const adminUser = "**Enter Admin Username Here**"; //Enter admin username
const adminPass = "**Enter Admin Password Here**"; //Enter admin password

//GET request at /auth/adminLogin
router.get("/adminLogin", function (req, res) {
    res.render("admin/authenticate");
});

//POST request at /auth/adminLogin
router.post("/adminLogin", function (req, res) {
    const username = req.body.username;
    const password = req.body.password;

    if (username == adminUser && password === adminPass) {
        req.session.admin = true;
        res.redirect("/admin");
    } else {
        res.render("authenticate", {
            wrong: true
        });
    }
});

//GET request at /auth/adminLogout
router.get("/adminLogout", function (req, res, next) {
    req.session.destroy(function () {
        res.redirect("/auth/adminLogin");
    });
});

module.exports = router;
