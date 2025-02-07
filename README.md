# 📱 Prueba Técnica Flutter

## 🏆 Descripción  
Esta es una aplicación móvil desarrollada en **Flutter** para listar usuarios y sus publicaciones, obtenidos desde una API REST.  

---

## 🚀 Tecnologías y Herramientas Utilizadas  

- **Flutter & Dart** - Desarrollo de la aplicación.  
- **Provider** - Manejo de estado.  
- **Dio** - Consumo de API.  
- **Hive** - Almacenamiento local.  
- **Arquitectura Limpia (Clean Architecture)** - Separación de capas:  
  - **Data**: Repositorios y fuentes de datos.  
  - **Domain**: Casos de uso y lógica de negocio.  
  - **Presentation**: UI y Providers.  
- **SOLID & Clean Code** - Aplicación de buenas prácticas.  
- **Pruebas Unitarias & Integración** - Validación del código.  

---

## 📌 Funcionalidades Implementadas  

✔ **Listar usuarios** obtenidos de la API o de almacenamiento local (**Hive**).  
✔ **Filtrar usuarios** en tiempo real.  
✔ **Ver publicaciones** de cada usuario.  
✔ **Manejo de estado** con **Provider**.  
✔ **Almacenamiento local** con **Hive** para evitar llamadas innecesarias a la API.  
✔ **Indicadores de carga** al obtener datos de la API.  

---

## 📂 Estructura del Proyecto  


lib/
├── core/                    # Código reutilizable (UseCases, Network)
├── features/
│   ├── users/               # Módulo de Usuarios
│   │   ├── data/            # Fuentes de datos y repositorios
│   │   ├── domain/          # Casos de uso y modelos
│   │   ├── presentation/    # UI y Providers
│   ├── posts/               # Módulo de Publicaciones (estructura similar)
└── main.dart                # Punto de entrada de la aplicación


---

## ✅ Pruebas Implementadas  

### 🔹 Pruebas Unitarias  

#### Casos de Uso (UseCases):  
✅ **FetchUsersUseCase**: Obtiene usuarios correctamente.  
✅ **FetchPostsUseCase**: Obtiene publicaciones según el usuario.  

#### Providers:  
✅ **UserProvider**: Carga y filtra usuarios correctamente.  
✅ **PostsProvider**: Maneja el estado y carga publicaciones correctamente.  

### 🔹 Pruebas de Integración  

#### UseCases + Repositories (con Hive y Dio simulados):  
✅ **Validación de almacenamiento local antes de llamar a la API.**  
✅ **Manejo correcto de errores en API y base de datos local.**  

📌 **Herramientas usadas:**  
✅ **mocktail** - Mocking de dependencias.  
✅ **Hive** - Base de datos local para pruebas.  

---

## 🚀 Cómo Ejecutar la Aplicación  

1️⃣ Clona este repositorio  

git clone https://github.com/LiamAndres/prueba_tecnica_flutter.git
cd prueba_tecnica_flutter

2️⃣ **Instalar dependencias**

flutter pub get

3️⃣ **Ejecutar la aplicación**

flutter run

4️⃣ **Ejecutar pruebas**

flutter test


---

## 📩 Envío de la Prueba  

📌 **Repositorio Público en GitHub** - Cumple con los requisitos de la prueba.  
📌 **Versión Controlada con Git** - Uso de commits y estructura clara.  

---

## 👨‍💻 Autor  

📌 **Liam Andres**
🔗 **GitHub:** https://github.com/LiamAndres

---

📌 **¡Gracias por revisar esta prueba! 🚀**
