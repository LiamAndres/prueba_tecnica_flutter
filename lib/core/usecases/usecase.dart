/*  📌 Clase base genérica para los casos de uso en Clean Architecture.
    ✔ Permite definir un contrato común para los casos de uso.
    ✔ Ayuda a mantener la separación de responsabilidades.
    ✔ Implementado en `FetchUsersUseCase` y `FetchPostsUseCase`. 
*/

abstract class UseCase<Type, Params> {
  Future<Type> execute(Params params);
}