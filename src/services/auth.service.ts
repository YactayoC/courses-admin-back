import { Request, Response } from "express";
import { pool } from "../database/connectionDB";
import { RowDataPacket } from "mysql2";
import bcrypt from "bcrypt";

const iniciarSesion = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: "Invalid body" });
  }

  try {
    const query = "CALL iniciar_sesion(?)";
    const [response] = await pool.query<RowDataPacket[]>(query, [email]);

    if (response[0].length === 0) {
      return res.status(400).json({ message: "Usuario no encontrado" });
    }
    const user = response[0];

    const isPasswordValid = await bcrypt.compare(password, user[0].contrasena);

    if (!isPasswordValid) {
      return res.status(400).json({ message: "Contraseña incorrecta" });
    }

    return res.json({
      message: "Usuario autenticado correctamente",
      user: {
        id: user[0].id,
        nombre: user[0].nombre,
        email: user[0].email,
        rol_id: user[0].rol_id,
        rol_name: user[0].rol_name,
      },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

const registrarUsuario = async (req: Request, res: Response) => {
  const { nombre, email, password } = req.body;

  if (!nombre || !email || !password) {
    return res.status(400).json({ message: "Invalid body" });
  }

  if (email === "admin@admin.com") {
    return res.status(400).json({ message: "Correo reservado" });
  }

  try {
    const queryCheckEmail = "SELECT * FROM usuarios WHERE email = ?";
    const [existingUsers] = await pool.query<RowDataPacket[]>(queryCheckEmail, [
      email,
    ]);

    if (existingUsers.length > 0) {
      return res
        .status(400)
        .json({ message: "Correo electrónico ya está registrado" });
    }

    const query = "SELECT * FROM usuarios WHERE email = ?";
    const [response] = await pool.query<RowDataPacket[]>(query, [email]);

    if (response.length > 0) {
      return res.status(400).json({ message: "Usuario ya existe" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    await pool.query(
      "INSERT INTO usuarios (nombre, email, contrasena, rol_id) VALUES (?, ?, ?, 3)",
      [nombre, email, hashedPassword]
    );

    return res.json({ message: "Usuario registrado correctamente" });
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
};

export { iniciarSesion, registrarUsuario };
