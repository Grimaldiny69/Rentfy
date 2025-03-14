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
      console.log(secretKey);
      const token = await jwt.sign({ id: userData.id }, secretKey, {
        expiresIn: "1h",
      });
      res.status(201).json(token);
    } else {
      res.status(204).json("Usuário Não Encontrado!");
    }
  } catch (error) {
    res.status(500).json({
      status: 500,
      message: error.message,
    });
  }
});

/* Cadastro */
router.post("/cadastro", async (req, res) => {
  try {
    const { name, surname, email, password, phoneNumber, idNumber, userType } =
      req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    const dataValidate = await logInController.findUser(email);

    if (!dataValidate) {
      const createUser = await userController.create({
        name,
        surname,
        email,
        password: hashedPassword,
        phoneNumber,
        idNumber,
        userType: UserType[userType],
      });

      res
        .status(201)
        .json(
          createUser
            ? "Usuario Cadastrado com sucesso"
            : "Usuario nao cadatrado"
        );
    } else {
      res.status(201).json("Ja Existe um usuaria com essas credencias");
    }
  } catch (error) {
    res.status(500).json({
      status: 500,
      message: error.message,
    });
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
