import { Router } from "express";
const express = require('express');
const router = express.Router() as Router;

// Get application options
router.get("/", (req, res) => {
    res.sendStatus(200);
    res.send({ "message": "OK", "method": "getWorkspaceList"})
});

export default router;