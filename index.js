const express = require("express");
const app = express();
const port = 3030;

const publicRoutes = require("./routes/public.js");

app.use(express.json());
app.use("/cadastro", publicRoutes);
app.use("/cadastro/propriedades", publicRoutes);
app.use("/", publicRoutes);
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}.....`);
});
