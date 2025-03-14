const { UserType } = require("@prisma/client");
const express = require("express");
const router = express.Router();
const userController = require("../Controllers/userController");
const logInController = require("../Controllers/logInController");
const propertyController = require("../Controllers/propertyController");
const locationControler = require("../Controllers/locationController");
const imageController = require("../Controllers/imageController");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
require("dotenv").config();
const secretKey = process.env.JWT_SECRET;
/* Log-in */

router.get("/", async (req, res) => {
  try {
    const { email, password } = req.body;
    const userData = await logInController.findUser(email);
    const PassValidation = await bcrypt.compare(password, userData.password);

    if (PassValidation) {
      const token = await jwt.sign(userData.id, secretKey, { expiredIn: "1h" });
      res.status(201).json(token);
    }

    res.status(201).json("Usuário Não Encontrado!");
  } catch (error) {
    res.status(500).json({
      status: 500,
      message: error.message,
    });
  }
});

/* Cadastro */
router.post("/cadastro", async (req, res) => {
  const { name, surname, email, password, phoneNumber, idNumber, userType } =
    req.body;
  let usertype;
  if (userType === "Client") {
    usertype = UserType.Client;
  } else if (userType === "Admin") {
    usertype = UserType.Admin;
  } else if ((usertype = UserType.Owner)) {
    usertype = UserType.Admin;
  }

  try {
    const createUser = await userController.create({
      name,
      surname,
      email,
      password,
      phoneNumber,
      idNumber,
      userType: UserType.Admin,
    });
    console.log(createUser);

    res.status(201).json(createUser);
  } catch (error) {
    res.status(500).json(error.message);
    console.log(error.message);
  }
});

router.post("/cadastro/propriedades", async (req, res) => {
  try {
    const { locationData, imageData, propertyData } = req.body;
    const createHome = await propertyController.createProperty({
      ...propertyData,
    });

    if (createHome) {
      const createLocation = await locationControler.createLocation({
        ...locationData,
        propertyId: createHome.id,
      });

      const createImage = await imageController.createImages({
        ...imageData,
        propertyId: createHome.id,
      });
      res.status(201).send({ createHome, createLocation, createImage });
    }
  } catch (error) {
    res.status(500).json(error.message);
  }
});

module.exports = router;
