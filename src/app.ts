import "dotenv/config";
import express from "express";
import cors from "cors";
import path from "path";

import { routerAdmin } from "./routes/admin.route";
import { verificateConnection } from "./database/connectionDB";
import { routerAuth } from "./routes/auth.route";
import { routerComment } from "./routes/comment.route";

verificateConnection(); //VERIFICA CONEXION A LA BD

const app = express();
app.use("/uploads", express.static(path.resolve(__dirname, "uploads")));

app.use(express.json());
app.use(
  cors({
    // origin: process.env.CLIENT_URL,
    origin: "*",
  })
);

app.use("/api/admin", routerAdmin);
app.use("/api/auth", routerAuth);
app.use("/api/comment", routerComment);

app.listen(process.env.PORT || 3001, () => {
  console.log(`🚀 Server is running on port ${process.env.PORT || 3001}`);
});
