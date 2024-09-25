//import { Router } from "express";
//import express from 'express';

exports.test = function (req, res) {
    res.statusCode = 200;
    res.send("test");
}

/*
module.exports = function(app){

    app.get('/test', function(req, res){
        res.statusCode = 200;
        res.send("test");
    });

    //other routes..
}
    */

/*
const router = express.Router() as Router;
//const appRouter = require("./application");
//const workspaceRouter = require("./workspace");

router.use((_, res, next) => {
    res.setHeader("Content-Type", "application/json");
    next();
});
//router.use("/api/v1/application", appRouter);
//router.use("/api/v1/workspace", workspaceRouter);

router.get("/api/v1/test", (_, res) => {
    res.statusCode = 200;
    res.send("test");
})

export default router;
*/