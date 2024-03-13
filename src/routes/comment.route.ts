import { Router } from "express";
import {
  listarComnetariosPorCursoId,
  insertarComentario,
  eliminarComentario,
} from "../services/comment.service";

const router = Router();

router.get("/:cursoId", [], listarComnetariosPorCursoId);
router.post("/", [], insertarComentario);
router.delete("/:id", [], eliminarComentario);

export { router as routerComment };
