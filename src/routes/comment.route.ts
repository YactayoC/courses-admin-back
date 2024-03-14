import { Router } from "express";
import {
  listarComnetariosPorCursoId,
  insertarComentario,
  eliminarComentario,
} from "../services/comment.service";
import { RouterPathComment } from "../utils/routerPath";

const router = Router();

router.get(RouterPathComment.CURSO_ID, [], listarComnetariosPorCursoId);
router.post("/", [], insertarComentario);
router.delete(RouterPathComment.ID, [], eliminarComentario);

export { router as routerComment };
