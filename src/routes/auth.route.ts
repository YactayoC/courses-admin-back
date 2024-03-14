import { Router } from "express";
import { iniciarSesion, registrarUsuario } from "../services/auth.service";
import { RouterPathAuth } from "../utils/routerPath";

const router = Router();

router.post(RouterPathAuth.INICIAR_SESION, [], iniciarSesion);
router.post(RouterPathAuth.REGISTRAR_USUARIO, [], registrarUsuario);

export { router as routerAuth };
