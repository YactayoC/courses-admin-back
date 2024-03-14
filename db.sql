--- DATABASE TABLAS AND RELATIONS
create table categorias
(
    id          int auto_increment
        primary key,
    nombre      varchar(100) null,
    descripcion text         null
);

create table configuracion
(
    id    int auto_increment
        primary key,
    clave varchar(100) null,
    valor varchar(255) null
);

create table contactos
(
    id      int auto_increment
        primary key,
    nombre  varchar(100)                        null,
    email   varchar(100)                        null,
    mensaje text                                null,
    fecha   timestamp default CURRENT_TIMESTAMP null
);

create table cursos
(
    id           int auto_increment
        primary key,
    nombre       varchar(100) null,
    descripcion  text         null,
    imagen_url   varchar(255) null,
    video_iframe text         null,
    categoria_id int          null,
    constraint cursos_ibfk_1
        foreign key (categoria_id) references categorias (id)
);

create index categoria_id
    on cursos (categoria_id);

create table etiquetas
(
    id     int auto_increment
        primary key,
    nombre varchar(100) null
);

create table curso_etiqueta
(
    curso_id    int not null,
    etiqueta_id int not null,
    primary key (curso_id, etiqueta_id),
    constraint curso_etiqueta_ibfk_1
        foreign key (curso_id) references cursos (id),
    constraint curso_etiqueta_ibfk_2
        foreign key (etiqueta_id) references etiquetas (id)
);

create index etiqueta_id
    on curso_etiqueta (etiqueta_id);

create table idiomas
(
    id     int auto_increment
        primary key,
    codigo varchar(10) null,
    constraint codigo
        unique (codigo)
);

create table menu
(
    id     int auto_increment
        primary key,
    opcion varchar(100) null,
    url    varchar(255) null,
    orden  int          null
);

create table paginas
(
    id        int auto_increment
        primary key,
    titulo    varchar(100) null,
    contenido text         null
);

create table contenido_pagina
(
    id             int auto_increment
        primary key,
    pagina_id      int                               null,
    tipo_contenido enum ('texto', 'imagen', 'video') null,
    contenido      text                              null,
    constraint contenido_pagina_ibfk_1
        foreign key (pagina_id) references paginas (id)
);

create index pagina_id
    on contenido_pagina (pagina_id);

create table estadisticas
(
    id               int auto_increment
        primary key,
    pagina_id        int  null,
    cantidad_visitas int  null,
    fecha            date null,
    constraint estadisticas_ibfk_1
        foreign key (pagina_id) references paginas (id)
);

create index pagina_id
    on estadisticas (pagina_id);

create table permisos
(
    id            int auto_increment
        primary key,
    rol           enum ('administrador', 'visitante', 'cliente') null,
    funcionalidad varchar(100)                                   null
);

create table rol
(
    rol_id   int auto_increment
        primary key,
    rol_name varchar(255) not null
);

create table traducciones
(
    id         int auto_increment
        primary key,
    idioma_id  int          null,
    etiqueta   varchar(100) null,
    traduccion text         null,
    constraint traducciones_ibfk_1
        foreign key (idioma_id) references idiomas (id)
);

create index idioma_id
    on traducciones (idioma_id);

create table usuarios
(
    id         int auto_increment
        primary key,
    nombre     varchar(100) null,
    email      varchar(100) null,
    contrasena varchar(100) null,
    rol_id     int          null,
    constraint email
        unique (email),
    constraint fk_rol_id
        foreign key (rol_id) references rol (rol_id),
    constraint fk_rol
        foreign key (rol_id) references rol (rol_id)
);

create table archivos_adjuntos
(
    id           int auto_increment
        primary key,
    nombre       varchar(255) null,
    ruta         varchar(255) null,
    tipo_archivo varchar(100) null,
    usuario_id   int          null,
    constraint archivos_adjuntos_ibfk_1
        foreign key (usuario_id) references usuarios (id)
);

create index usuario_id
    on archivos_adjuntos (usuario_id);

create table calificaciones
(
    id           int auto_increment
        primary key,
    usuario_id   int null,
    curso_id     int null,
    calificacion int null,
    constraint calificaciones_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint calificaciones_ibfk_2
        foreign key (curso_id) references cursos (id)
);

create index curso_id
    on calificaciones (curso_id);

create index usuario_id
    on calificaciones (usuario_id);

create table comentarios
(
    id         int auto_increment
        primary key,
    usuario_id int                                 null,
    curso_id   int                                 null,
    comentario text                                null,
    fecha      timestamp default CURRENT_TIMESTAMP null,
    constraint comentarios_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint comentarios_ibfk_2
        foreign key (curso_id) references cursos (id)
);

create index curso_id
    on comentarios (curso_id);

create index usuario_id
    on comentarios (usuario_id);

create table favoritos
(
    id         int auto_increment
        primary key,
    usuario_id int null,
    curso_id   int null,
    constraint favoritos_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint favoritos_ibfk_2
        foreign key (curso_id) references cursos (id)
);

create index curso_id
    on favoritos (curso_id);

create index usuario_id
    on favoritos (usuario_id);

create table historial_navegacion
(
    id         int auto_increment
        primary key,
    usuario_id int                                 null,
    pagina_id  int                                 null,
    fecha      timestamp default CURRENT_TIMESTAMP null,
    constraint historial_navegacion_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint historial_navegacion_ibfk_2
        foreign key (pagina_id) references paginas (id)
);

create index pagina_id
    on historial_navegacion (pagina_id);

create index usuario_id
    on historial_navegacion (usuario_id);

create table integraciones
(
    id         int auto_increment
        primary key,
    servicio   varchar(100) null,
    api_key    varchar(255) null,
    usuario_id int          null,
    constraint integraciones_ibfk_1
        foreign key (usuario_id) references usuarios (id)
);

create index usuario_id
    on integraciones (usuario_id);

create table notificaciones
(
    id         int auto_increment
        primary key,
    usuario_id int                                  null,
    mensaje    text                                 null,
    leido      tinyint(1) default 0                 null,
    fecha      timestamp  default CURRENT_TIMESTAMP null,
    constraint notificaciones_ibfk_1
        foreign key (usuario_id) references usuarios (id)
);

create index usuario_id
    on notificaciones (usuario_id);

create table reportes
(
    id           int auto_increment
        primary key,
    usuario_id   int                                 null,
    tipo_reporte varchar(100)                        null,
    descripcion  text                                null,
    fecha        timestamp default CURRENT_TIMESTAMP null,
    constraint reportes_ibfk_1
        foreign key (usuario_id) references usuarios (id)
);

create index usuario_id
    on reportes (usuario_id);

create table reportes_comentario
(
    id            int auto_increment
        primary key,
    usuario_id    int                                 null,
    comentario_id int                                 null,
    motivo        varchar(255)                        null,
    fecha         timestamp default CURRENT_TIMESTAMP null,
    constraint reportes_comentario_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint reportes_comentario_ibfk_2
        foreign key (comentario_id) references comentarios (id)
);

create index comentario_id
    on reportes_comentario (comentario_id);

create index usuario_id
    on reportes_comentario (usuario_id);

create table respuestas_comentario
(
    id            int auto_increment
        primary key,
    usuario_id    int                                 null,
    comentario_id int                                 null,
    respuesta     text                                null,
    fecha         timestamp default CURRENT_TIMESTAMP null,
    constraint respuestas_comentario_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint respuestas_comentario_ibfk_2
        foreign key (comentario_id) references comentarios (id)
);

create index comentario_id
    on respuestas_comentario (comentario_id);

create index usuario_id
    on respuestas_comentario (usuario_id);

create table sesiones
(
    id               int auto_increment
        primary key,
    usuario_id       int          null,
    token            varchar(100) null,
    fecha_expiracion datetime     null,
    constraint sesiones_ibfk_1
        foreign key (usuario_id) references usuarios (id)
);

create index usuario_id
    on sesiones (usuario_id);

create table suscripciones
(
    id           int auto_increment
        primary key,
    usuario_id   int          null,
    plan         varchar(100) null,
    fecha_inicio timestamp    null,
    fecha_fin    timestamp    null,
    constraint suscripciones_ibfk_1
        foreign key (usuario_id) references usuarios (id)
);

create index usuario_id
    on suscripciones (usuario_id);

create table transacciones
(
    id         int auto_increment
        primary key,
    usuario_id int                                 null,
    curso_id   int                                 null,
    monto      decimal(10, 2)                      null,
    fecha      timestamp default CURRENT_TIMESTAMP null,
    constraint transacciones_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint transacciones_ibfk_2
        foreign key (curso_id) references cursos (id)
);

create index curso_id
    on transacciones (curso_id);

create index usuario_id
    on transacciones (usuario_id);

create table valoraciones_comentario
(
    id            int auto_increment
        primary key,
    usuario_id    int                                 null,
    comentario_id int                                 null,
    valoracion    enum ('positiva', 'negativa')       null,
    fecha         timestamp default CURRENT_TIMESTAMP null,
    constraint valoraciones_comentario_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint valoraciones_comentario_ibfk_2
        foreign key (comentario_id) references comentarios (id)
);

create index comentario_id
    on valoraciones_comentario (comentario_id);

create index usuario_id
    on valoraciones_comentario (usuario_id);

create table visualizaciones_curso
(
    id         int auto_increment
        primary key,
    usuario_id int                                 null,
    curso_id   int                                 null,
    fecha      timestamp default CURRENT_TIMESTAMP null,
    constraint visualizaciones_curso_ibfk_1
        foreign key (usuario_id) references usuarios (id),
    constraint visualizaciones_curso_ibfk_2
        foreign key (curso_id) references cursos (id)
);

create index curso_id
    on visualizaciones_curso (curso_id);

create index usuario_id
    on visualizaciones_curso (usuario_id);

--- STORE PROCEDURES 

create procedure agregar_categoria(IN p_nombre varchar(255), IN p_descripcion text)
BEGIN
  INSERT INTO categorias (nombre, descripcion)
  VALUES (p_nombre, p_descripcion);
END;

create procedure agregar_curso(IN p_nombre varchar(255), IN p_descripcion text, IN p_imagen_url varchar(255),
                               IN p_video_frame varchar(255), IN p_categoria_id int)
BEGIN
    INSERT INTO cursos (nombre, descripcion, imagen_url, video_iframe, categoria_id)
    VALUES (p_nombre, p_descripcion, p_imagen_url, p_video_frame, p_categoria_id);
END;


