# Ricky and morty Characters – iOS Technical Challenge

Aplicación iOS desarrollada en **SwiftUI** que consume la API oficial de Rick & Morty para listar personajes con paginación, búsqueda y navegación a detalle.

---

## Cómo correr el proyecto

### Requisitos

- Xcode 15+
- iOS 16+
- Swift 5.9+

### Pasos

1. Clonar el repositorio:
```bash
   git clone <url-del-repositorio>
```
3. Abrir el .xcodeproj en Xcode.
3.Resolver dependencias:
File → Packages → Resolve Package Versions
4. Ejecutar con ⌘ + R.

## Arquitectura

El proyecto sigue una arquitectura MVVM con separación clara de responsabilidades:

core -> configuracion base de red, coreRequest, Manejo de errores

data -> DTOs, Mappers

domain -> Entidades, Casos de uso,  Repository

shared -> Views, ViewModels

## Librerías utilizadas
1️⃣ Alamofire

Utilizada para el consumo de red.

Motivo:

- Simplifica requests HTTP.

- Compatible con async/await.

- Manejo limpio de validación y serialización.

- Configuración sencilla de timeout y errores.

2️⃣ Kingfisher

Utilizada para carga y cacheo de imágenes.

Motivo:

- Cache automático eficiente.

- Manejo óptimo en listas.

- Placeholder y cancelación automática.

- Reduce complejidad frente a implementación manual.

## Mayor reto encontrado(iOS)

El principal reto fue replicar la lógica de estado y paginación entre plataformas.

En SwiftUI fue necesario:

- Controlar race conditions en llamadas async

- Cancelar tareas anteriores

- Evitar que respuestas antiguas sobrescribieran el estado actual

- Manejar re-render automático de vistas

La solución incluyó control de concurrencia, cancelación de Task y validación de respuestas activas.
