# Actividad 3.1: Despliegue de una arquitectura distribuida con un balanceador de carga

Autores: Carlos Romero Cruz y Yulieth Alexandra Guiza Pinto

Repositorio basado en la carpeta phpwebappv2 de [asnwebapps](https://github.com/jrbalsas/asnwebapps).

## Instalación previa

Es necesario instalar los siguientes componentes para ejecutar los contenedores de esta
actividad:

- Docker
- make
- [ctop](https://ctop.sh/) 

## Uso

Es posible gestionar los contenedores tanto con las opciones del comando ```docker compose``` como
mediante la herramienta ```make``` para simplificar la ejecución.

### Generar y lanzar los contenedores

```bash
$ make
```

o mediante

```bash
$ docker compose up -d
```

### Monitorizar los recursos empleados por los contenedores

```bash
$ make mon
```

o

```bash
$ docker stats
```

Para emplear la herramienta ```ctop``` simplemente bastará con ejecutar

```bash
$ ctop
```

### Generar las imágenes de los contenedores

```bash
$ make build
```

o

```bash
$ docker compose build
```

### Detener y eliminar los contenedores

```bash
$ make clean
```

o

```bash
$ docker compose down
```

## Consideraciones
- Los archivos de las contraseñas se han incluido en el repositorio para facilitar las pruebas y ejecuciones.
En un caso real estos archivos no se incluirían.
- Se ha optado por el uso de [secretos de Docker](https://docs.docker.com/engine/swarm/secrets/) para gestionar
las credenciales de acceso a la base de datos. Por eso, ha sido necesario la creación de un punto de entrada
(*entrypoint*) específico para el contenedor del servicio web.
- El contenedor de mariadb puede tardar unos segundos en inicializarse durante la primera ejecución. Se
mostrará un aviso en la aplicación web de que la conexión ha sido denegada hasta que el servidor de base de
datos se inicialice.