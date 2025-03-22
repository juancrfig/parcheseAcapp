# ParcheseAcapp

**ParcheseAcapp** es una aplicación diseñada para unificar la información fragmentada de eventos en Colombia. Nuestra plataforma ofrece a los usuarios una experiencia personalizada e intuitiva para descubrir eventos de acuerdo a sus intereses y ubicación, al mismo tiempo que brinda a los organizadores herramientas potentes para promocionar sus eventos y conectar con socios estratégicos.

---

## Tabla de Contenidos

- [Descripción General](#descripción-general)
- [Características](#características)
- [Plan de Desarrollo](#plan-de-desarrollo)
  - [Fase 1: Planificación y Diseño](#fase-1-planificación-y-diseño)
  - [Fase 2: Desarrollo Central](#fase-2-desarrollo-central)
  - [Fase 3: Integración y Pruebas](#fase-3-integración-y-pruebas)
  - [Fase 4: Preparación para el Lanzamiento](#fase-4-preparación-para-el-lanzamiento)
- [Roles y Responsabilidades](#roles-y-responsabilidades)
- [Tecnologías Utilizadas](#tecnologías-utilizadas)
- [Configuración e Instalación](#configuración-e-instalación)
- [Estimación de Presupuesto](#estimación-de-presupuesto)
- [Contribuir](#contribuir)
- [Licencia](#licencia)

---

## Descripción General

ParcheseAcapp surge para resolver el problema de la información dispersa sobre eventos en Colombia. La aplicación permite a los usuarios:
- Descubrir eventos personalizados mediante filtros avanzados, geolocalización y recomendaciones impulsadas por inteligencia artificial.
- Acceder a listados detallados de eventos.
- Recibir notificaciones en tiempo real sobre eventos relevantes a sus intereses.

Además, ofrece a los organizadores herramientas integrales para:
- Crear y promocionar eventos.
- Analizar el rendimiento mediante estadísticas.
- Integrar pagos de forma segura.
- Conectarse con socios estratégicos a través de un marketplace.

El proyecto contempla el desarrollo para plataformas web, Android e iOS, utilizando **React**, **Spring Boot** y **Swift**, respectivamente.

---

## Características

- **Filtros Avanzados:** Permiten búsquedas personalizadas por intereses, ubicación y más.
- **Recomendaciones IA:** Sugerencias basadas en el comportamiento y preferencias del usuario.
- **Geolocalización:** Encuentra eventos cercanos de forma intuitiva.
- **Herramientas para Organizadores:** Creación de eventos, análisis de métricas y gestión de pagos.
- **Marketplace para Socios Estratégicos:** Espacio para conectar con marcas y colaboradores.
- **Notificaciones en Tiempo Real:** Mantén informados a los usuarios sobre novedades y actualizaciones de eventos.

---

## Plan de Desarrollo

El desarrollo se estructura en cuatro fases, cada una con tareas de menos de dos horas para asegurar un progreso constante:

### Fase 1: Planificación y Diseño (21 de marzo de 2025 – 21 de abril de 2025)
- **Objetivos:** Definir requisitos, diseñar UI/UX y establecer la infraestructura.
- **Actividades:** 
  - Configuración de tableros (Trello) y canales de comunicación (Slack).
  - Diseño de wireframes y prototipos en Figma.
  - Configuración de proyectos iniciales en Xcode, Spring Boot y React.

### Fase 2: Desarrollo Central (22 de abril de 2025 – 22 de julio de 2025)
- **Objetivos:** Construir los componentes principales en paralelo (frontend, backend e iOS).
- **Actividades:**
  - Desarrollo de componentes y páginas en React.
  - Implementación de pantallas y flujos en SwiftUI para iOS.
  - Creación de APIs CRUD, modelos y repositorios en Spring Boot.
  - Integración de la pasarela de pagos y establecimiento de roles de usuario.

### Fase 3: Integración y Pruebas (23 de julio de 2025 – 23 de agosto de 2025)
- **Objetivos:** Conectar todos los componentes, realizar pruebas unitarias y corregir errores.
- **Actividades:**
  - Integración de APIs con el frontend y la aplicación iOS.
  - Desarrollo y ejecución de pruebas unitarias para cada módulo.
  - Verificación de flujos de autenticación y pagos.

### Fase 4: Preparación para el Lanzamiento (24 de agosto de 2025 – 7 de septiembre de 2025)
- **Objetivos:** Finalizar el producto, desplegarlo y ejecutar la estrategia de marketing.
- **Actividades:**
  - Despliegue del frontend en Vercel y del backend en Heroku.
  - Preparación de la aplicación iOS para el App Store y pruebas en TestFlight.
  - Configuración de redes sociales y elaboración de comunicados de prensa.

---

## Roles y Responsabilidades

- **Juanes (Project Lead & Desarrollador iOS):**  
  - Lidera el proyecto, coordina tareas y supervisa el progreso.  
  - Desarrolla la aplicación iOS con Swift, asegurando la paridad funcional.

- **Ada (Desarrolladora Frontend):**  
  - Desarrolla las interfaces para web y Android utilizando React.  
  - Se enfoca en el diseño y la usabilidad de la aplicación.

- **José (Desarrollador Backend):**  
  - Diseña la base de datos y construye las APIs para eventos y usuarios usando Spring Boot.

- **Anderson (Desarrollador Backend & Marketing):**  
  - Desarrolla integraciones backend, como la pasarela de pagos.  
  - Encabeza la estrategia de marketing y la creación de materiales promocionales.

- **Warllen (Desarrollador Backend):**  
  - Se especializa en autenticación y seguridad, implementando APIs para registro e inicio de sesión.

- **Marlon (Desarrollador Backend):**  
  - Configura la infraestructura de Spring Boot y desarrolla el marketplace para socios estratégicos.

---

## Tecnologías Utilizadas

- **Frontend:** React (para web y Android)
- **Backend:** Spring Boot (Java), Hibernate para la conexión con la base de datos
- **iOS:** Swift y SwiftUI
- **Herramientas de Diseño:** Figma, Canva
- **Control de Versiones:** Git y GitHub
- **Despliegue:** Vercel (frontend), Heroku (backend)
- **Comunicación y Gestión:** Trello, Slack

---

## Configuración e Instalación

### Requisitos Previos
- [Node.js](https://nodejs.org/)
- [Java 11 o superior](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
- [Xcode](https://developer.apple.com/xcode/) (para iOS)
- [Git](https://git-scm.com/)

### Instalación

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/tu-usuario/parecheseacapp.git
   cd parcheseacapp
