import { Router } from "express";
import multer from "multer";

import storageSaveF from "../utils/saveFile";
import { RouterPathAdmin } from "../utils/routerPath";
import {
  agregarCategoria,
  eliminarCategoria,
  listarCategorias,
  editarCategoria,
  listarCategoriaPorId,
} from "../services/categorie.service";
import {
  agregarCurso,
  listarCursos,
  eliminarCurso,
  actualizarCurso,
  listarCursoPorId,
} from "../services/course.service";

const router = Router();
const upload = multer({ storage: storageSaveF });

// Cursos
router.get(RouterPathAdmin.CURSOS, [], listarCursos);
router.post(RouterPathAdmin.CURSOS, [], upload.single("file"), agregarCurso);
router.put(
  RouterPathAdmin.CURSOS_ID,
  [],
  upload.single("file"),
  actualizarCurso
);
router.delete(RouterPathAdmin.CURSOS_ID, [], eliminarCurso);
router.get(RouterPathAdmin.CURSOS_ID, [], listarCursoPorId);

// Categorias
router.get(RouterPathAdmin.CATEGORIAS, [], listarCategorias);
router.post(RouterPathAdmin.CATEGORIAS, [], agregarCategoria);
router.delete(RouterPathAdmin.CATEGORIAS_ID, [], eliminarCategoria);
router.put(RouterPathAdmin.CATEGORIAS_ID, [], editarCategoria);
router.get(RouterPathAdmin.CATEGORIAS_ID, [], listarCategoriaPorId);

export { router as routerAdmin };
