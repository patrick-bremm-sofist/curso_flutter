## Link Curso

https://www.udemy.com/course/flutter-com-mango/

## Required

Gradle: 6.3

Java: 11.0.18-amzn

Emulator: Pixel 5 API 30

https://fvm.app/ - Flutter Version Management

sdk use VERSION 1.20.4

fvm list (list all sdks)

fvm use 1.20.4

## Backend

-> https://github.com/rmanguinho/clean-ts-api

. Para executar o projeto usem o Docker (instalar Docker e Node ) dentro do projeto só rodar o seguinte comando 'npm run up '...

. Para acessando o Swagger abra o seguinte link no navegador: http://localhost:5050/api-docs/#/...

. Para criar o usuário usar o endpoint /signup.

. IP para o Emulador conseguir bater na API Local: 10.0.2.2

#### Ajuste Backend

No arquivo account-mongo-repository.ts, fazer seguinte import:
Caminho: src/infra/db/mongodb/account-mongo-repository.ts

`import { ObjectId } from 'mongodb'`

Na linha 41 mudar para seguinte trecho de código:

`_id: new ObjectId(id)`

Segue a imagem com alteração:

**Lembrar que precisa fazer build novamente