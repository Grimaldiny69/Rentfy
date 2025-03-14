const express = require("express");
const app = express();
require("dotenv").config();
const PORT = process.env.PORT;

const publicRoutes = require("./routes/public.js");

app.use(express.json());
app.use("/cadastro", publicRoutes);
app.use("/cadastro/propriedades", publicRoutes);
app.use("/", publicRoutes);
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}.....`);
  console.log(process.env.PORT);
});
