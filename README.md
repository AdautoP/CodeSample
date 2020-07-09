<p align="center">
  <img src="https://i.ibb.co/qCYZwwt/i-Tunes-Artwork-1x.png">
</p>

# Preview

<p align="center">
  <img src="https://media1.giphy.com/media/hqmYJBuXfvpYJMTyTY/giphy.gif">
</p>

# Sobre

CodeSample é um nome genérico para um projeto com intuito de prática e estudo de tecnologias de desenvolvimento diversas, assim como portfólio. Nele consumo a REST API do [Rick and Morty](https://rickandmortyapi.com/). 

## Stack

- MVVM + Clean
- RxSwift
- Submódulos em Monorepo
- XcodeGen
- Fastlane
- SwiftGen

# Instalação

## Pré-requisitos
Você vai precisar instalar as ferramentas abaixo para rodar o projeto:

- [Carthage](https://github.com/Carthage/Carthage) para gerenciamento de dependências.
- [Swiftlint](https://github.com/realm/SwiftLint) para gerenciamento de regras de código.
- [SwiftGen](https://github.com/SwiftGen/SwiftGen) para geração de Assets e Strings.
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) para geração do xcodeproj.


## Scripts

Enquanto na pasta raiz do projeto, rode:
```sh
./Bin/carthage-bootstrap
```
then

```sh
./Bin/xcodegen
```
