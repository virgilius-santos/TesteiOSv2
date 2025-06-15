# Show me the code

Esse repositório contem todo o material necessário para realizar o teste: 
- A especificação do layout está na pasta 'bank_app_layout' abrindo o index.html, os icones estão na pasta 'assets'

- Os dados da Api estão mockados, os exemplos e a especificação dos serviços (login e statements) na api https://65198632818c4e98ac6078a8.mockapi.io/api/v1/login

![Image of Yaktocat](https://github.com/SantanderTecnologia/TesteiOSv2/blob/master/telas.png)

### # DESAFIO:

Na primeira tela teremos um formulario de login, o campo user deve aceitar email ou cpf,
o campo password deve validar se a senha tem pelo menos uma letra maiuscula, um caracter especial e um caracter alfanumérico.
Apos a validação, realizar o login no endpoint https://65198632818c4e98ac6078a8.mockapi.io/api/v1/login e exibir os dados de retorno na próxima tela.
O ultimo usuário logado deve ser salvo de forma segura localmente, e exibido na tela de login se houver algum salvo. 

Na segunda tela será exibido os dados formatados do retorno do login e será necessário fazer um segundo request para obter os lançamentos do usuário, no endpoint https://65198632818c4e98ac6078a8.mockapi.io/api/v1/login/{idUser} que retornará uma lista de lançamentos

### # Avaliação

Você será avaliado pela usabilidade, por respeitar o design e pela arquitetura do app. É esperado que você consiga explicar as decisões que tomou durante o desenvolvimento através de commits.

Obrigatórios:

* Swift 3.0 ou superior
* Autolayout
* O app deve funcionar no iOS 9
* Testes unitários, pode usar a ferramenta que você tem mais experiência, só nos explique o que ele tem de bom.
* Arquitetura a ser utilizada: VIP
* Uso do git.

### # Observações gerais

Adicione um arquivo [README.md](http://README.md) com os procedimentos para executar o projeto.

# SantanderSample in Swift!

this is a demo application where you can:
- insert an email/cpf and a password to login
- after login has completed you will see some account informations
- you can logout too.

in the first screen it will show the last valid user, if it exists.

obs.
- cpf must have 11 numbers 
- password must have 1 Uppercase, 1 alphanumeric and 1 especial character


Although simple, it is being used:
- Clean Swift architecture
- API Restful
- Unit tests
- Keychain for secure information persistence

CocoaPods:
- Swinject, a simple way to inject dependencies avoiding coupling
- Quick / Nimble, it's more simple and readable.
- IQKeyboardManager, 
- SwiftKeychainWrapper, for persistance of safe data

