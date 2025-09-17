# 🧮 Calculadora de Expressões Matemáticas

> **Projeto acadêmico desenvolvido em Dart** - Calculadora científica com interface moderna e funções matemáticas avançadas.

## 📋 Sobre o Projeto

Esta calculadora foi desenvolvida como projeto acadêmico para demonstrar conhecimentos em **Dart** e programação orientada a objetos. O projeto implementa uma calculadora científica completa com interface moderna e funcionalidades avançadas.

## ✨ Funcionalidades

### 🔢 Operações Básicas
- Adição (+)
- Subtração (-)
- Multiplicação (*)
- Divisão (/)
- Potenciação (^)

### 🧮 Funções Científicas
- **Trigonométricas**: sin(), cos(), tan()
- **Raiz quadrada**: sqrt()
- **Constantes**: π (pi)
- **Parênteses**: () para agrupamento

### 🎨 Interface
- Design moderno e discreto
- Cores neutras e profissionais
- Botões responsivos
- Tratamento de erros intuitivo

## 🛠️ Tecnologias Utilizadas

- **Dart** - Linguagem de programação principal
- **math_expressions** - Biblioteca para avaliação de expressões matemáticas
- **Programação Orientada a Objetos** - Estrutura modular e organizada

## 🚀 Como Executar

### Pré-requisitos
- Dart SDK instalado
- Flutter SDK (opcional, para interface visual)

### Instalação
```bash
# Clone o repositório
git clone https://github.com/Joaolda/calculadora-dart-limpa.git

# Navegue para o diretório
cd calculadora-dart-limpa

# Instale as dependências
dart pub get

# Execute o projeto
dart run main.dart
```

## 📁 Estrutura do Projeto

```
calculadora-dart-limpa/
├── lib/
│   └── main.dart          # Código principal da calculadora
├── pubspec.yaml           # Configurações e dependências
└── README.md             # Documentação do projeto
```

## 🎯 Características Técnicas

### Arquitetura
- **StatefulWidget**: Gerenciamento de estado da interface
- **TextEditingController**: Controle de entrada de texto
- **Parser**: Análise de expressões matemáticas
- **Tratamento de Exceções**: Validação robusta de entrada

### Validações
- ✅ Verificação de divisão por zero
- ✅ Validação de expressões inválidas
- ✅ Tratamento de erros matemáticos
- ✅ Limpeza automática de entrada

## 📊 Exemplos de Uso

```
Entrada: 2 + 3 * 4
Resultado: 14

Entrada: sin(pi/2)
Resultado: 1.0

Entrada: sqrt(16) + 2^3
Resultado: 12.0
```

## 🎓 Objetivos Acadêmicos

Este projeto demonstra:
- **Conhecimento em Dart**
- **Programação orientada a objetos**
- **Tratamento de exceções**
- **Interface de usuário**
- **Estruturação de código**
- **Documentação técnica**

## 👨‍💻 Desenvolvedor

**João Andrade**
- Estudante de Ciência da Computação
- Foco em desenvolvimento mobile e web

## 📄 Licença

Este projeto é de uso acadêmico e educacional.

---

> **Nota**: Este repositório contém apenas o código Dart essencial, sem as dependências de plataforma do Flutter, facilitando a análise e apresentação acadêmica.