# Santander BankApp (iOS)

Santander BankApp é um projeto iOS moderno desenvolvido para demonstrar boas práticas de arquitetura, organização e código limpo em apps financeiros. O app simula o fluxo de autenticação e exibição de extrato bancário, utilizando dados mockados via API REST.

## 🔥 Funcionalidades

- Autenticação de usuário com validações de CPF/email e senha segura
- Salvamento seguro do último usuário autenticado (via Keychain)
- Exibição de informações da conta bancária e lançamentos (extrato)
- Suporte completo à navegação desacoplada via `Coordinators` e `Routers`

## 💡 Layout

O design está disponível na pasta `/bank_app_layout`. Basta abrir o arquivo `index.html` no navegador. Os ícones e recursos visuais estão em `/bank_app_layout/assets`.

![Screenshot](https://github.com/SantanderTecnologia/TesteiOSv2/blob/master/telas.png)

## 🧱 Arquitetura e Tecnologias

- **Arquitetura:** VIP (View, Interactor, Presenter), baseada em Clean Architecture
- **UI:** 100% ViewCode (sem Storyboards ou Xibs)
- **Navegação:** Desacoplada, com suporte a UIKit e SwiftUI
- **Networking:** URLSession + `async/await`, fortemente tipado
- **Persistência:** Keychain para dados sensíveis
- **Modularização:** Swift Package Manager (SPM)

## ✅ Requisitos

- Swift 5.8 ou superior
- iOS 13+ (App compatível com iOS 9+ com adaptações)
- Xcode 14 ou superior

## 🧪 Testes

- ViewModels, Interactors e validações testadas isoladamente
- Mocking manual e via protocolos para simulações de rede e navegação

## 🔐 Validações

- **Usuário:** Campo aceita CPF (11 números) ou e-mail válido
- **Senha:** Deve conter pelo menos:
  - 1 letra maiúscula
  - 1 caractere especial
  - 1 número

## 🌐 Endpoints mockados

- **Login:** `https://65198632818c4e98ac6078a8.mockapi.io/api/v1/login`
- **Extrato:** `https://65198632818c4e98ac6078a8.mockapi.io/api/v1/login/{userId}`

Os dados são mockados e retornam objetos de login e extrato.

## ▶️ Como rodar

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/SantanderBankApp.git
   cd SantanderBankApp
   ```
2. Abra o projeto com o **Xcode 14+**
3. Compile e rode o projeto em um simulador iOS 13+

## 🧩 Dependências

Integradas via **Swift Package Manager**:

- `SwiftKeychainWrapper` – persistência segura
- `IQKeyboardManager` – controle automático do teclado (opcional)

## 📁 Organização

```
SantanderBankApp/
├── App/                     # Ponto de entrada e scene delegate
├── Modules/                 # Feature modules (Login, Statements)
├── Core/                    # Helpers, Extensions, Networking
├── Resources/               # Assets, cores, fontes
├── Tests/                   # Testes unitários
├── bank_app_layout/         # Especificação visual
└── README.md
```

## 📌 Observações

- O último usuário logado é salvo de forma segura no Keychain e reaparece automaticamente no login.
- Todos os dados são fictícios e usados apenas para fins demonstrativos.

---

## 📄 Licença

MIT © 2025 - Projeto de demonstração para avaliação técnica e estudos.

---

Este projeto foi criado para demonstrar domínio das melhores práticas de desenvolvimento iOS: arquitetura limpa, código desacoplado, testes automatizados e foco em usabilidade e segurança.
