module {{sender}}::biblioteca {

    use std::string::{String, utf8, append};
    use sui::vec_map::{Self, VecMap};

    // --- ESTRUCTURAS PRINCIPALES ---

    // Representa una biblioteca con un registro de usuarios
    public struct Biblioteca has key, store {
        id: UID,
        nombre: String,
        registro_usuarios: VecMap<u16, Usuario>
    }

    // Representa a un usuario de la biblioteca
    public struct Usuario has store, drop, copy {
        nombre_usuario: String,
        direccion: String,
        ano_de_registro: u8,
        nivel_membresia: Membresia,
        libros_prestados: vector<String>
    }

    // Enum para niveles de membresía con diferentes límites de préstamo
    public enum Membresia has store, drop, copy {
        basica(Basica),
        premium(Premium),
        elite(Elite)
    }

    public struct Basica has store, drop, copy { limite: u8 }
    public struct Premium has store, drop, copy { limite: u8 }
    public struct Elite has store, drop, copy { limite: u8 }

    // --- CONSTANTES DE ERROR ---
    #[error]
    const ID_EXISTE: vector<u8> = b"ERROR: El ID ya existe.";
    #[error]
    const ID_NO_EXISTE: vector<u8> = b"ERROR: El ID de usuario no existe.";
    #[error]
    const LIMITE_PRESTAMOS: vector<u8> = b"ERROR: Se alcanzó el límite de préstamos para este usuario.";

    // --- FUNCIONES PRINCIPALES ---

    // Crear nueva biblioteca
    public fun crear_biblioteca(nombre: String, ctx: &mut TxContext) {
        let biblioteca = Biblioteca {
            id: object::new(ctx),
            nombre,
            registro_usuarios: vec_map::empty()
        };
        transfer::transfer(biblioteca, tx_context::sender(ctx));
    }

    // Agregar nuevo usuario
    public fun agregar_usuario(biblioteca: &mut Biblioteca, nombre_usuario: String, direccion: String, ano_de_registro: u8, id_usuario: u16) {
        assert!(!biblioteca.registro_usuarios.contains(&id_usuario), ID_EXISTE);

        let usuario = Usuario {
            nombre_usuario,
            direccion,
            ano_de_registro,
            nivel_membresia: Membresia::basica(Basica{limite: 2}),
            libros_prestados: vector[]
        };

        biblioteca.registro_usuarios.insert(id_usuario, usuario);
    }

    // Prestar un libro a un usuario (valida límite)
    public fun prestar_libro(biblioteca: &mut Biblioteca, id_usuario: u16, libro: String) {
        assert!(biblioteca.registro_usuarios.contains(&id_usuario), ID_NO_EXISTE);

        let usuario = biblioteca.registro_usuarios.get_mut(&id_usuario);
        let limite = obtener_limite(usuario.nivel_membresia);
        let cantidad_actual = vector::length(&usuario.libros_prestados);

        assert!(cantidad_actual < limite, LIMITE_PRESTAMOS);

        usuario.libros_prestados.push_back(libro);
    }

    // Eliminar usuario
    public fun eliminar_usuario(biblioteca: &mut Biblioteca, id_usuario: u16) {
        assert!(biblioteca.registro_usuarios.contains(&id_usuario), ID_NO_EXISTE);
        biblioteca.registro_usuarios.remove(&id_usuario);
    }

    // Eliminar biblioteca
    public fun eliminar_biblioteca(biblioteca: Biblioteca) {
        let Biblioteca {id, nombre: _, registro_usuarios:_ } = biblioteca;
        id.delete();
    }

    // --- CAMBIO DE MEMBRESÍA ---

    public fun cambiar_a_basica(biblioteca: &mut Biblioteca, id_usuario: u16) {
        let usuario = biblioteca.registro_usuarios.get_mut(&id_usuario);
        usuario.nivel_membresia = Membresia::basica(Basica{limite: 2});
    }

    public fun cambiar_a_premium(biblioteca: &mut Biblioteca, id_usuario: u16) {
        let usuario = biblioteca.registro_usuarios.get_mut(&id_usuario);
        usuario.nivel_membresia = Membresia::premium(Premium{limite: 5});
    }

    public fun cambiar_a_elite(biblioteca: &mut Biblioteca, id_usuario: u16) {
        let usuario = biblioteca.registro_usuarios.get_mut(&id_usuario);
        usuario.nivel_membresia = Membresia::elite(Elite{limite: 10});
    }

    // --- FUNCIONES AUXILIARES ---

    public fun obtener_limite(nivel: Membresia): u64 {
        match (nivel) {
            Membresia::basica(dato) => (dato.limite as u64),
            Membresia::premium(dato) => (dato.limite as u64),
            Membresia::elite(dato) => (dato.limite as u64)
        }
    }

    // Mensaje informativo sobre límite actual
    public fun mensaje_limite(biblioteca: &mut Biblioteca, id_usuario: u16): String {
        assert!(biblioteca.registro_usuarios.contains(&id_usuario), ID_NO_EXISTE);

        let usuario = biblioteca.registro_usuarios.get_mut(&id_usuario);
        let limite = obtener_limite(usuario.nivel_membresia);

        let mut mensaje = utf8(b"Tu límite de préstamos es: ");
        mensaje.append(limite.to_string());
        mensaje
    }
}
 