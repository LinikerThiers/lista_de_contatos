# 📇 Lista de Contatos

Aplicativo Flutter para gerenciamento de contatos com suporte a tema escuro, internacionalização e armazenamento em nuvem via Back4App. Permite adicionar, editar, excluir contatos com foto de perfil e marcar favoritos para acesso rápido.

## ✨ Funcionalidades

- ✅ Cadastrar contatos com imagem de perfil, editar e excluir
- ⭐ Marcar contatos como favoritos
- ↗️ Compartilhar informações dos contatos
- 🌓 Suporte a temas claro e escuro
- ☁️ Armazenamento na nuvem com Back4App
- 🌐 Escolha de idioma (Português e Inglês)
- 🖼️ Salvamento de perfil com imagem e dados personalizados

## 🛠️ Tecnologias e Pacotes

| Pacote                   | Versão     | Descrição                                      |
|--------------------------|------------|------------------------------------------------|
| `flutter`                | 3.27.3     | Framework principal                            |
| `cupertino_icons`        | ^1.0.8     | Ícones estilo iOS                              |
| `font_awesome_flutter`   | ^10.8.0    | Ícones do FontAwesome                          |
| `flutter_native_splash`  | ^2.4.4     | Tela Splash nativa no Flutter                  |
| `animated_text_kit`      | ^4.2.2     | Animações de texto personalizáveis             |
| `page_transition`        | ^2.2.1     | Animações de transição entre páginas           |
| `easy_localization`      | ^3.0.7+1   | Internacionalização (i18n)                     |
| `path`                   | ^1.9.0     | Manipulação de caminhos de arquivos            |
| `shared_preferences`     | ^2.5.2     | Armazenamento local                            |
| `provider`               | ^6.1.4     | Gerenciamento de estado                        |
| `google_fonts`           | ^6.2.1     | Fontes do Google para uso com Flutter          |
| `image_picker`           | ^1.1.2     | Seleção de imagens da galeria ou câmera        |
| `dio`                    | ^5.8.0+1   | Cliente HTTP poderoso e flexível               |
| `flutter_dotenv`         | ^5.2.1     | Gerenciamento de variáveis de ambiente         |
| `path_provider`          | ^2.1.5     | Acesso a diretórios específicos do sistema     |
| `share_plus`             | ^10.1.4    | Compartilhamento de conteúdo via apps nativos  |
| `intl`                   | ^0.19.0    | Internacionalização e formatação de datas/números |

## 🏗️ Estrutura do Projeto

```
lib/
├── main.dart # Ponto de entrada principal
├── my_app.dart # Configuração do MaterialApp
│
├── model/
│ └── lista_de_contatos_model.dart # Modelo de dados dos contatos
│
├── pages/
│ ├── splash_screen/ # Tela inicial animada
│ │ └── splash_screen.dart
│ │
│ ├── lista_page.dart # Tela principal de listagem
│ ├── detalhes_contato_page.dart # Detalhes do contato
│ ├── adicionar_contato_page.dart # Adicionar novo contato
│ ├── favoritos_page.dart # Lista de favoritos
│ ├── linguagens_page.dart # Seleção de idioma
│ ├── perfil_page.dart # Visualização do perfil
│ └── editar_perfil.dart # Edição do perfil
│ └── main_home_page.dart # Pagina principal com o BottomNavigationBar
│ └── reportar_problema_page.dart # Pagina para reportar problema do aplicativo
│
├── repository/
│ └── contatos_back4app_repository.dart # Conexão com Back4App
│ └── back4app_dio_interceptor.dart # Interceptor do Dio
│ └── back4app_custom_dio.dart # Configuraçõs do Dio de Headers e Base URL
│
├── utils/
│ └── gerenciador_de_temas.dart # Gerenciamento de tema claro/escuro
│
├── shared/
│ └── widget/ # Componentes reutilizáveis
│ ├── lista_app_bar.dart # AppBar da página da lista de contatos
│ └── favoritos_app_bar.dart # AppBar da página de favoritos
│
└── assets/
├── translations/ # Arquivos de internacionalização
│ ├── en.json # Inglês
│ └── pt.json # Português
└── icon/ # Logotipo do aplicativo
```

## 🔌 Configuração do Back4App

1. Crie uma conta no [Back4App](https://www.back4app.com/)
2. Crie um novo app e configure a classe `Contatos` com os campos:
   ```json
   {
     "nome": String,
     "email": String,
     "telefone": String,
     "endereco": String,
     "instagram": String,
     "aniversario": Date,
     "favorito": Boolean,
     "image_profile": String
   }
   ```
3. Obtenha suas chaves de API do Back4App
4. Crie um arquivo `.env` na raiz do projeto:
   ```env
   BACK4APP_APPLICATION_ID=SUA_APP_ID
   BACK4APP_CLIENT_KEY=SUA_CLIENT_KEY
   BACK4APP_SERVER_URL=https://parseapi.back4app.com/
   ```

## 🚀 Executando o Projeto

1. Clone o repositório:
   ```bash
   git clone https://github.com/LinikerThiers/lista_de_contatos.git
   cd lista_de_contatos
   ```

2. Instale as dependências:
   ```bash
   flutter pub get
   ```

4. Execute o app:
   ```bash
   flutter run
   ```

## 📸 Screenshots
<img src="https://github.com/user-attachments/assets/9e72c6dd-6dd9-4fc4-bb02-5f6fd17e3567" width="200">
<img src="https://github.com/user-attachments/assets/bf2ddee4-9587-4d2d-946a-66eea706ef39" width="200">
<img src="https://github.com/user-attachments/assets/4ca3ff7a-9201-475f-be07-c450635a6fc3" width="200">
<img src="https://github.com/user-attachments/assets/11f446d8-cd09-4c1d-9276-30b087c2100c" width="200">
<img src="https://github.com/user-attachments/assets/b0f854f0-b4ef-4f77-b968-78f24676f936" width="200">
<img src="https://github.com/user-attachments/assets/dc30db78-8913-43ff-a84c-6ad60bce7df7" width="200">
<img src="https://github.com/user-attachments/assets/d07587d8-f5e6-4db3-8657-d1dd8ea09138" width="200">
<img src="https://github.com/user-attachments/assets/5097cc88-6bd9-4453-9364-212e1bacc57e" width="200">
<img src="https://github.com/user-attachments/assets/05876c78-26be-4830-8796-f201acf42e1d" width="200">
<img src="https://github.com/user-attachments/assets/a148f085-63fb-4d0d-8779-d657b94f7985" width="200">
<img src="https://github.com/user-attachments/assets/2142e6f7-39b4-4373-b4f8-4d5887e05fc8" width="200">
<img src="https://github.com/user-attachments/assets/ab25f092-4f5a-4d28-b1ee-95659d0204d1" width="200">
