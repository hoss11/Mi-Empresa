![banner](./imagenes/banner.jpg)
# Sui Certification Day Code

Sui es una plataforma de blockchain y contratos inteligentes de capa 1 diseñada para que la propiedad de activos digitales sea rápida, privada, segura y accesible.

Move es un lenguaje de código abierto para escribir paquetes seguros para manipular objetos en blockchain. Permite bibliotecas, herramientas y comunidades de desarrolladores comunes en blockchains con modelos de datos y ejecución muy diferentes.

## Proyecto base

Puedes usar este repositorio como tu punto de despliegue de tu proyecto backend.

### Abriendo con Codespaces

* Asegúrate de clonar este repositorio a tu cuenta usando el botón **`Fork`**.
    
    ![fork](./imagenes/fork.png)
    * Puedes renombrar el repositorio a lo que sea que se ajuste con tu proyecto.
* Presiona el botón **`<> Code`** y luego haz click en la sección **`Codespaces`**

    ![codespaces](./imagenes/codespaces.png)

* Por último, presiona **`Create codespace on master`**. Esto abrirá el proyecto en una interfaz gráfica de Visual Studio Code e instalará todas las herramientas necesarias para desarrollar con Move.

## Configuración inicial para despliegue en testnet

Puedes hacer esto ejecutando los siguientes comandos en tu terminal:
```sh
sui client
```

La primera vez que ejecutemos esto obtendremos el siguiente mensaje:

```sh
Config file ["<PATH-TO-FILE>/client.yaml"] doesn't exist, do you want to connect to a Sui Full node server [y/N]?
```

Presionamos y y luego Enter para continuar y obtendremos esto:
```sh
Sui Full node server URL (Defaults to Sui Testnet if not specified) :
```

Puedes volver a presionar `Enter` en tu teclado para dejar la configuración por defecto, en este caso nos estaríamos conectando a la `testnet`, es decir, a la red de pruebas de Sui. El siguiente mensaje en terminal debería ser algo como:

```sh
Select key scheme to generate keypair (0 for ed25519, 1 for secp256k1, 2 for secp256r1):
```
Puedes seleccionar el que gustes, la opción por defecto es 0, así que escribe `0` en y presiona `Enter`. Una vez terminado deberías obtener algo similar a esto:

```sh
Generated new keypair for address with scheme "ed25519" [0xb9c83a8b40d3263c9ba40d551514fbac1f8c12e98a4005a0dac072d3549c2442]
Secret Recovery Phrase : [cap wheat many line human lazy few solid bored proud speed grocery]
```
> :information_source: Tanto el `address` como la frase de recuperación que obtengas serán diferentes a las que mostramos aquí.


## Fondeando una cuenta

Una vez conectado, el siguiente paso es **fondear tu cuenta**, es decir, asegurarte de que la dirección que estás utilizando tenga **tokens SUI** (aunque sean tokens de prueba) suficientes para cubrir las tarifas de las transacciones. Este proceso es esencial para poder desplegar paquetes, ejecutar funciones y validar tu lógica en cualquier red que estés utilizando.

Puedes hacer esto ejecutando el siguiente comando en tu terminal:

```sh
sui client faucet
```

Obtendrás algo similar a esto, probablemente en letras rojas:

```sh
For testnet tokens, please use the Web UI: https://faucet.sui.io/?address=0x451ef911c5a1706d4833f89b75f6cb49c55a586821e9b7de6bd9d8b41dac2cda
```
Puedes hacer click en esa URL, la cual te llevará al faucet de Sui, que es una aplicación que reparte tokens de prueba en las redes `testnet` y `devnet`, para que los desarrolladores puedan desplegar y probar sus paquetes Move.

![faucet](imagenes/testnetfaucet.png)

Ya en el sitio, simplemente haz click en **Request Testnet SUI**. Con esto habremos terminado el proceso de fondeo. Puedes verificarlo en terminal

```sh
sui client balance
╭────────────────────────────────────────╮
│ Balance of coins owned by this address │
├────────────────────────────────────────┤
│ ╭──────────────────────────────────╮   │
│ │ coin  balance (raw)  balance     │   │
│ ├──────────────────────────────────┤   │
│ │ Sui   10000000000    10.00 SUI   │   │
│ ╰──────────────────────────────────╯ │
╰────────────────────────────────────────╯
```

> :information_source: El README distorsiona un poco este output.

Puedes acceder al faucet directamente desde acá: https://faucet.sui.io/

## Desplegando en la testnet
La testnet es un entorno de pruebas creado para que los desarrolladores de la blockchain Sui experimenten e interactuen con sus paquetes antes de subirlos de manera oficial a la Mainnet, la red real. 

Una vez recibidos los tokens de testnet mediante el faucet, desplegar a la testnet es muy sencillo, solo es necesario ejecutar el comando:
```
sui client publish
```

Lo que dará como resultado mucha informacion relacionada con la transaccion. Sin embargo, la información en la que nos vamos a centrar es la siguiente: 

```
╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Object Changes                                                                                   │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Created Objects:                                                                                 │
│  ┌──                                                                                             │
│  │ ObjectID: 0xeee71d904b4ba170d130dacdaf5de7eabd23a6d3634fd39e06ceb6e2e630522b                  │
│  │ Sender: 0xfdfb28de3b66e3d21922ed3a1f13cb99b5c7d848264fab94358d17e76647b6a0                    │
│  │ Owner: Account Address ( 0xfdfb28de3b66e3d21922ed3a1f13cb99b5c7d848264fab94358d17e76647b6a0 ) │
│  │ ObjectType: 0x2::package::UpgradeCap                                                          │
│  │ Version: 349180416                                                                            │
│  │ Digest: HuYaAgoVDsdbt3skuHzBgstvupEqL6AjEURbPgjb86sn                                          │
│  └──                                                                                             │
│ Mutated Objects:                                                                                 │
│  ┌──                                                                                             │
│  │ ObjectID: 0x12b4b6e610179a45e4e5824a5189b73bbd88d37adc8e91988ce343689172ba45                  │
│  │ Sender: 0xfdfb28de3b66e3d21922ed3a1f13cb99b5c7d848264fab94358d17e76647b6a0                    │
│  │ Owner: Account Address ( 0xfdfb28de3b66e3d21922ed3a1f13cb99b5c7d848264fab94358d17e76647b6a0 ) │
│  │ ObjectType: 0x2::coin::Coin<0x2::sui::SUI>                                                    │
│  │ Version: 349180416                                                                            │
│  │ Digest: 9pvSJgWuu2Ki7qz5ZKRiarP7XwEHSkXYBnj5RGrPkkF6                                          │
│  └──                                                                                             │
│ Published Objects:                                                                               │
│  ┌──                                                                                             │
│  │ PackageID: 0x8ddace66e376f03067016c51820d512fa1a8fa9e2e518ed0c842086cdb27ae91                 │
│  │ Version: 1                                                                                    │
│  │ Digest: 71yxJBgson9NHunqDvmKiuM5XVfsaszxwhdnXCPTsbeX                                          │
│  │ Modules: empresa                                                                              │
│  └──                                                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
```

Donde al final se muestra el PackageID, o ID del paquete (nuestro código). Es importante guardar este ID, ya que mediante su uso es como haremos interaccion con nuestro nuestro codigo y sus funciones.

## Verificando nuestro paquete en Suiscan
Suiscan es una plataforma de exploración y análisis. Sirve como una herramienta integral para que los desarrolladores naveguen y analicen datos on-chain, proporcionando información detallada sobre transacciones, direcciones, actividad de la red y diversos componentes del ecosistema.

![alt text](/imagenes/suiscan.png)
https://suiscan.xyz/testnet/home


Para localizar nuestro paquete solo es necesario verificar que nos encontramos en testnet (que se ve en la parte superior derecha) e introduciremos en el buscador el ID del paquete que nos arrojo la terminal una vez finalizado el despliegue. 

Posterior a eso, daremos click en la única opción que nos aparece:

![alt text](imagenes/paquete.png)

Como resultado veremos la siguiente pestaña, donde veremos un resumen de las transacciones realizadas con nuestro paquete. De igual manera, en el apartado contracts es posible visualizar el código desplegado.

![alt text](imagenes/bloque.png)

## Despliegue en mainnet 
### Cambiando de entorno
El primer paso para el despligue en mainnet es especificar la red en la que ahora queremos trabajar, para ello es necesario ejecutar los siguientes comandos:

```sh
sui client new-env --alias mainnet --rpc https://fullnode.mainnet.sui.io:443
```

Ahora, necesitamos cambiarnos a este ambiente. Hazlo de la siguiente manera:
```sh
sui client switch --env mainnet 
```

Puedes consultar tu dirección activa usando [Esta es la address que debes compartir en el registro de solicitud de tokens]:
```sh
sui client active-address
```

Y tu balance usando:
```sh
sui client balance
```

## Despliegue
De igual manera que en el despliegue en testnet, solo es necesario ejecutar el comando 

```
sui client publish
```
Lo que dara como resultado, entre otras cosas:

```
│ Published Objects:                                                                               │
│  ┌──                                                                                             │
│  │ PackageID: 0x41c0712233a64af3b69dd5f2a557b3a05f4dabdaba0300880e130d59381be03f                 │
│  │ Version: 1                                                                                    │
│  │ Digest: ASwdkEcAfKuYgAprofprLDLJnz7DNfNDtUTTPAKUd41x                                          │
│  │ Modules: empresa                                                                              │
│  └──                                                                                             │
```
Puedes revisar tu paquete mediante el PackageID en suiscan para verificar que el codigo es el mismo al que desarrollaste, ver detalles del despliegue, entre otras cosas.

## Creacion del Move Registry
### Importacion de la llave privada
En este paso es necesario exportar la llave privada del address utilizado para el despliegue del paquete en mainnet, suena complejo, pero en realidad es bastante sencillo. El primer paso apra lograrlo correr el comando:

```
sui keytool export --key-identity <Inserta tu address aqui>
```
Recuerda que puedes consultar tu address con:
```
sui client active-address
```

Por ejemplo:

```
sui keytool export --key-identity 0xfdfb28de3b66e3d21922ed3a1f13cb99b5c7d848264fab94358d17e76647b6a0
```

lo que dará como resultado la siguiente informacion:
```
╭────────────────────┬────────────────────────────────────────────────────────────────────────────────────────────╮
│ exportedPrivateKey │  suiprivkey1qz72l.......                                                                   │
│ key                │ ╭─────────────────┬──────────────────────────────────────────────────────────────────────╮ │
│                    │ │ alias           │                                                                      │ │
│                    │ │ suiAddress      │  0xfdfb28de3b66e3d21922ed3a1f13cb99b5c7d848264fab94358d17e76647b6a0  │ │
│                    │ │ publicBase64Key │  ACp+9/7QpKjAx29svnrX+....                                           │ │
│                    │ │ keyScheme       │  ed25519                                                             │ │
│                    │ │ flag            │  0                                                                   │ │
│                    │ │ peerId          │  2a7ef7fed0a4a8c0c76f6cbe7ad7fac6f71f60....                          │ │
│                    │ ╰─────────────────┴──────────────────────────────────────────────────────────────────────╯ │
╰────────────────────┴────────────────────────────────────────────────────────────────────────────────────────────╯
```

Vamos a copiar todo lo que aparece en la primera linea: suiprivkey1qz72l...

Posteriormente, crearemos una nueva cuenta en la Wallet de Slush, si aun no tienes la tuya puedes acceder desde el navegador o instalando la extencion, desde el siguiente enlace: https://slush.app/

![alt text](/imagenes/slush.png)

Una vez en el apartado de agregar cuenta, seleccionaremos la opcion Import Private Key (importar llave privada), donde pegaremos la informacion copiada de la terminal. 

![alt text](imagenes/import.png)

Y listo!!!, ahora deberia aparecer tu direccion de la siguiente manera:

![alt text](imagenes/imported.png)

### Creacion del MVR
Abriremos el siguiente enlace, lo que nos direccionara a la pagina para la creacion del MVR: https://www.moveregistry.com/
![alt text](imagenes/mvr.png)

En la parte superior izquierda vemos la opcion que dice "Connect", donde daremos click para vincular nuestra Wallet de Slush con MVR, **En caso de tener mas de dos direcciones, verifica que sea la misma en la que desplegaste tu proyecto en mainnet**. Finalmente, es necesario presionar el boton Approve.


Una vez vinculada la Wallet de Slush, se nos habilitaran dos opciones. De momento, daremos click donde dice **My Packages**, despues, en el buscador que dice **Select one**, donde seleccionaremos la unica opcion que aparece  **Public Name**.

![alt text](imagenes/packages.png)

Ahora daremos click en  **Add package**

![alt text](imagenes/create.png)

Lo que nos abrira el siguiente formulario donde debemos de poner de manera obligatoria el nombre. De igual manera, es recomendable llenar la segunda casilla con una breve descripcion del proyecto, todas las demas secciones son opcionales. 

![alt text](imagenes/package-details.png)

Al terminar, nos desplazaremos hasta la parte inferior para presionar el boton **Create**, lo que nos abrira la extension de Slush que nos solicitara la aprovacion de la creacion.

![alt text](imagenes/approve-creation.png)

Una vez creado, nos redireccionara a la pestaña anterior, donde ahora seleccionaremos la opcion **My Metadata** y posteiormente **Create New Metadata**

![alt text](/imagenes/metadata.png)

Seleccionamos la unica opcion que aparece y presionamos siguiente. **La ID que se muestra es la ID del objeto, no la ID del paquete**

![alt text](/imagenes/step1.png)

Personalizamos la informacion de la metadata, **Se recomienda que la etiqueta sea acorde al nombre del proyecto**

![alt text](/imagenes/step2.png)

Una vez completada la personalizacion, damos en **Create**, de nueva cuenta abrira la extension de Slush para autorizar la creacion de la metadata, donde solo daremos click en Approve.

![alt text](/imagenes/approve2.png)

Ya creada la metadata, nos regresamos a la pagina anterior, donde seleccionaremos el paquete creado anteriormente (1), bajaremos hasta la parte inferior (2) y seleccionaremos la metadata creada (3)

![alt text](/imagenes/package-metadata.png)

Una vez hecho esto, aparecera un recuadro que nos pide confirmar que entendemos que esta accion es irreversible (1). Por ultimo, damos click en **Save Changes** (2), se abrira la extension de Slush donde es necesario aprovar la transaccion (3).

![alt text](imagenes/create-metadata.png)

Y listo!, eso es todo. Puedes corrobarar la creacion de tu MVR en el buscador de la parte superior:

![alt text](imagenes/image.png)

Lo que nos llevara a una pagina similar a esta: https://www.moveregistry.com/package/@pkg/mi-empresa, que es similar a la que debes de compartir en el formulario de entrega de proyecto.

![alt text](/imagenes/image-1.png)

## Formulario de entrega
https://airtable.com/appSMP6mbcQoLiIEu/pagGANiEIaqdcrtdc/form
> Este repositorio fue creado con base al sui-starter-kit de ZinHunter: https://github.com/WayLearnLatam/sui-starter-kit
