const jwt = require('jsonwebtoken');

const payload = {
  userId: 123,
  email: "user@example.com"
};

const secretKey = "your_secret_key";

const token = jwt.sign(payload, secretKey, { expiresIn: "1h" });

console.log("JWT Token:", token);
