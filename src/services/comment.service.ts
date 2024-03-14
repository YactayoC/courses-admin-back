import { Request, Response } from "express";
import { pool } from "../database/connectionDB";

const listarComnetariosPorCursoId = async (req: Request, res: Response) => {
  const { cursoId } = req.params;

  if (!cursoId) {
    return res.status(400).json({ message: "Invalid body" });
  }

  try {
    const [result] = await pool.query(
      "SELECT com.*, user.nombre, user.email FROM comentarios com LEFT JOIN leog.usuarios user ON com.usuario_id = user.id WHERE curso_id = ? ORDER BY com.fecha DESC",
      [cursoId]
    );

    return res.json({ comentarios: result });
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
};

const insertarComentario = async (req: Request, res: Response) => {
  const { usuarioId, cursoId, comentario } = req.body;
  if (!usuarioId || !cursoId || !comentario) {
    return res.status(400).json({ message: "Invalid body" });
  }

  try {
    await pool.query(
      "INSERT INTO comentarios (usuario_id, curso_id, comentario, fecha)  VALUES (?, ?, ?, CURRENT_TIMESTAMP)",
      [usuarioId, cursoId, comentario]
    );
    return res.json({ message: "Comentario agregado correctamente" });
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
};

//NO UTILIZADO
const eliminarComentario = async (req: Request, res: Response) => {
  const { id } = req.params;
  if (!id) {
    return res.status(400).json({ message: "Invalid body" });
  }

  try {
    await pool.query("DELETE FROM comentarios WHERE id = ?", [id]);
    return res.json({ message: "Comentario eliminado correctamente" });
  } catch (error) {
    return res.status(500).json({ message: "Internal server error" });
  }
};

export { listarComnetariosPorCursoId, insertarComentario, eliminarComentario };
