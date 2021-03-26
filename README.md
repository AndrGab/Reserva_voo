# Flightex  

## Reservas de voos

**Desafios do Módulo 02 - Elixir**
**RocketSeat - Ignite**

Aplicação de teste para uma API de Agendamento de voos, onde é possível:
- Cadastrar usuários e reservas
- Consultar os cadastros realizados de usuários e reservas
- Gerar um relatório (Arquivo .csv) com as informações das reservas.
Todas as rotinas criadas são contempladas com testes automatizados.


## DESAFIO 01 - Reserva de voos

Nesse desafio, você deverá criar uma aplicação de reserva de voos, onde haverá o cadastro de usuários e o cadastro de reservas para um usuário.

A struct do usuário deverá possuir os seguintes campos:

```elixir
%User{
id: id,
name: name,
email: email,
cpf: cpf
}
```

**Obs:** O Id deve ser gerado automaticamente, pode ser um inteiro ou um UUID, mas não pode se repetir.
A struct da reserva deverá possuir os seguintes campos:

```elixir
%Booking{
id: id,
data_completa: data_completa,
cidade_origem: cidade_origem,
cidade_destino: cidade_destino,
id_usuario: id_usuario
}
```
O campo `data_completa` deverá ser uma `NaiveDateTime`, que é um formato de data sem fuso horário e com funções auxiliares. Mais detalhes sobre [NaiveDateTime aqui](https://hexdocs.pm/elixir/NaiveDateTime.html#content).

É importante que todos os dados sejam salvos em um **Agent**, de acordo com o que foi visto no módulo.

Você pode criar o projeto, módulos, funções e structs com o nome que desejar.

Exemplo de chamadas das funções e saídas esperadas:

```elixir
iex>  Flightex.create_user(params)
...> {:ok, user_id}
iex>  Flightex.create_booking(user_id, params)
...> {:ok, booking_id}
iex>  Flightex.create_booking(invalid_user_id, params)
...> {:error, "User not found"}
iex>  Flightex.get_booking(booking_id)
...> {:ok, %Booking{...}}
iex>  Flightex.get_booking(invalid_booking_id)
...> {:error, "Flight Booking not found"}
```

## ROTINAS CRIADAS PARA O DESAFIO

  - Cadastro de Usuários
```elixir
iex>  Flightex.create_user(%{name:  "Andre", email:  "teste@email.com", cpf:  "00000"})
...>{:ok, "bc335b94-c2dc-42b0-918e-6ec5f2a924a2"}

 ```
- Validação se CPF já foi utilizado
```elixir
iex>  Flightex.create_user(%{name:  "Andre", email:  "teste@email.com", cpf:  "00000"})
...>{:error, "This CPF is already used"}
 ```
- Validação se CPF não está no formato de String
```elixir
iex>  Flightex.create_user(%{name:  "Andre", email:  "teste@email.com", cpf:  00000})
...>{:error, "CPF is not a string"}
 ```
 
- Atualiza cadastro de usuário pelo ID
```elixir
iex>  Flightex.update_user(%{name:  "Andre", email:  "teste@email.com", cpf:  "00000", id:  "bc335b94-c2dc-42b0-918e-6ec5f2a924a2" })
...>{:ok, "User Updated"}
 ```
 
- Busca usuário pelo ID
```elixir
iex(211)> Flightex.get_user_by_id("bc335b94-c2dc-42b0-918e-6ec5f2a924a2")
...>{:ok,
 %Flightex.Users.User{
   cpf: "00000",
   email: "teste@email.com",
   id: "bc335b94-c2dc-42b0-918e-6ec5f2a924a2",
   name: "Andre"
 }}
  ```
  
- Busca usuário pelo CPF
```elixir
iex(212)> Flightex.get_user_by_cpf("00000")                               
...>{:ok,
 %Flightex.Users.User{
   cpf: "00000",
   email: "teste@email.com",
   id: "bc335b94-c2dc-42b0-918e-6ec5f2a924a2",
   name: "Andre"
 }}
 ```
 
- Retorna "User not found" se não encontrar CPF ou o ID
```elixir
iex> Flightex.get_user_by_cpf("000000")
...>{:error, "User not found"}

iex> Flightex.get_user_by_id("bc335b94-c2dc-42b0-918e-6ec5f2a92")   
...>{:error, "User not found"}
  ```
  
- Lista todos os Usuários
```elixir
iex> Flightex.list_all_users 
...>%{
  "015bbafe-ebb7-4eb6-9bd4-26ab254e41ff" => %Flightex.Users.User{
    cpf: "248145298",
    email: "andrgab@gmail.com",
    id: "015bbafe-ebb7-4eb6-9bd4-26ab254e41ff",
    name: "Andre"
  },
  "07c4356d-8753-4f11-be78-0a2c3284f9b0" => %Flightex.Users.User{
    cpf: "1239994",
    email: "antonio@gmail.com",
    id: "07c4356d-8753-4f11-be78-0a2c3284f9b0",
    name: "Antonio"
  }
  }
```

- Cria nova reserva
```elixir  
 iex> Create_booking.create_booking(%{id_usuario: "a39140c9-ded5-4843-98c1-8eaf73c87784", data_completa: {"2021-12-10","23:00:00"}, cidade_origem: "Londrina", cidade_destino: "São Paulo"})
...>{:ok, "e7454a87-d2c4-4ecf-bca6-24e29b668ae7"}
```

- Nova reserva, se cidades são iguais retorna erro
```elixir  
iex> Create_booking.create_booking(%{id_usuario: "a39140c9-ded5-4843-98c1-8eaf73c87784", data_completa: {"2021-12-10","23:00:00"}, cidade_origem: "Londrina", cidade_destino: "Londrina"}) 
...>{:error, "Origin and Destination Cities are the same"}
```
   
- Nova reserva, se a data não for válida (deve ser uma
 tupla {"AAAA-MM-DD","HH:MM:SS"}, retorna erro
```elixir  
iex> Create_booking.create_booking(%{id_usuario: "a39140c9-ded5-4843-98c1-8eaf73c87784", data_completa: {"2021-12-40","23:00:00"}, cidade_origem: "Londrina", cidade_destino: "Londrina"})   
...>{:error, :invalid_date}
```

- Nova reserva, se não encontrar o ID do usuário, retorna erro
```elixir  
iex> Create_booking.create_booking(%{id_usuario: "a39140c9-ded5-4843-98c1-8eaf73784", data_completa: {"2021-12-10","23:00:00"}, cidade_origem: "Londrina", cidade_destino: "São Paulo"})   
...>{:error, "User not found"}
```
- Nova reserva, se usuário já tem uma reserva no mesmo dia e horário
```elixir 
iex> Flightex.create_booking(%{id_usuario: "a39140c9-ded5-4843-98c1-8eaf73c87784", data_completa: {"2021-12-10","23:00:00"}, cidade_origem: "Londrina", cidade_destino: "London"})  
...>{:error, "User already has a Flight Booking for this Date/Time"}
```

- Lista todas as reservas
```elixir 

iex> Flightex.list_all_bookings
%{
  "4556a323-9c18-48e9-87e7-0edc1064cf3a" => %Flightex.Flight.Booking{
    cidade_destino: "São Paulo",
    cidade_origem: "Londrina",
    data_completa: ~N[2021-12-12 15:00:00],
    id: "4556a323-9c18-48e9-87e7-0edc1064cf3a",
    id_usuario: "f9c4c4a8-4e01-4f5c-b369-33028fa94276"
  },
  "acf12b0a-a61f-4798-b630-3485b628a9c8" => %Flightex.Flight.Booking{
    cidade_destino: "London",
    cidade_origem: "Londrina",
    data_completa: ~N[2021-12-10 20:00:00],
    id: "acf12b0a-a61f-4798-b630-3485b628a9c8",
    id_usuario: "a39140c9-ded5-4843-98c1-8eaf73c87784"
  }
  }
```

## DESAFIO 02 - Relatório de reservas de voos
Nesse desafio, você deverá incrementar a sua solução do desafio anterior. Agora deverá ser possível também gerar relatórios das reservas de voos de acordo com o intervalo dea inicial e data final. Todas as reservas que estiverem agendadas para esse intervalo de tempo, deve entrar no arquivo CSV do relatório.

Exemplo de chamada da função e saída esperada:

```elixir
iex> Flightex.generate_report(from_date, to_date)
...> {:ok, "Report generated successfully"}
```
## ROTINAS CRIADAS PARA O DESAFIO
```elixir
iex> Flightex.generate_report("2021-12-01","2021-12-31")
...> {:ok, "Report generated successfully"}
```
- Em caso de entrada de datas inválidas, retorna erro
```elixir
iex> Flightex.Flight.Report.create("2021-12-01","2021-13-31")
...> {:error, :invalid_date}
```
Exemplo do arquivo .csv gerado:
```
75132af2-b141-481e-afa0-2a03a95fa037,Londrina,São Paulo,2021-12-11 23:00:00
75132af2-b141-481e-afa0-2a03a95fa037,Londrina,São Paulo,2021-12-10 23:00:00
75132af2-b141-481e-afa0-2a03a95fa037,Londrina,São Paulo,2021-11-10 23:00:00
```

## DESAFIO 03 - Testando a aplicação

Nesse desafio, você deverá criar testes para a aplicação que você desenvolveu no desafio 01 - Reservas de voos. Se você concluiu o desafio opcional Relatório de reservas de voo, os testes também deverão cobrir essa funcionalidade.
Caso você já tenha desenvolvido os testes para os desafios anteriores, basta submeter o link do mesmo repositório para esse desafio também.

```
Todos as funções públicas possuem teste automatizados
````

## Tech utilizadas
- Agent (para simular o banco de dados)

## Libs
- Exmachina (criação de factories para utilização nos testes automatizados)
- UUID (geração de números de ID aleatórios)
- Credo (Ferramenta para análise do código)

## IGNITE - ELIXIR
- Este material foi criado para o Bootcamp Ignite da [RocketSeat](http://www.rocketseat.com.br)