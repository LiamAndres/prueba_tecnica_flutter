/// 📌 `UseCase` – Base genérica para los casos de uso en Clean Architecture.
///  
/// 🔹 **Propósito**:  
///   - Define un contrato estándar para la ejecución de casos de uso.  
///   - Mantiene la separación de responsabilidades y facilita el mantenimiento.  
///  
/// 🔹 **Uso**:  
///   - Implementado en `FetchUsersUseCase` y `FetchPostsUseCase`.  
///  
/// 🔹 **Parámetros genéricos**:  
///   - `@template Type`: Tipo de dato que retorna el caso de uso (Ej: `List<Map<String, dynamic>>`).  
///   - `@template Params`: Tipo de parámetro requerido para la ejecución (Ej: `int` para `userId`).  
abstract class UseCase<Type, Params> {
  /// 📌 Método abstracto que deben implementar los casos de uso.
  ///  
  /// 🔹 **Flujo**:  
  ///   1️⃣ Recibe los `params` necesarios para ejecutar la lógica.  
  ///   2️⃣ Devuelve un `Future<Type>` con el resultado del caso de uso.  
  Future<Type> execute(Params params);
}
