import { createPool } from "mysql2/promise";

export const pool = createPool({
  host: "localhost",
  user: process.env.USER_DB,
  password: process.env.PASSWORD_DB,
  database: process.env.DATABASE_DB,
});

export const verificateConnection = async () => {
  try {
    const connection = await pool.getConnection();
    console.log("Conexión establecida correctamente a la base de datos");
    connection.release();
  } catch (error) {
    console.error("Error al conectar a la base de datos:", error);
  }
};
