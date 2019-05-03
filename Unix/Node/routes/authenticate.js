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

//GET request at /auth/login
router.get("/login", (req, res) => {
    res.render("user/loginPage");
});

//POST request at /auth/login

router.post("/login", function (req, res) {
    const username = req.body.username.toString().trim();
    const password = req.body.password.toString().trim();
    if (username.length > 20 || password.length > 16) {
        res.send("Too large");
    } else {
        User.findOne({
            "name": username,
        }).then((docu) => {
            if (!docu) {
                res.send("Incorrect")
            } else{
                bcrypt.compare(password, doc.password, (err, result) => {
                    if (result === true) {
                        req.session.user = username;
                        res.redirect("/");
                    } else {
                        res.send('Incorrect');
                    }
                });
            }
        });
    }
});

module.exports = router;
