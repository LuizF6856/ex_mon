# ExMon

## Explicação do jogo

Jogo baseado em turnos onde teremos um player contra o computador.

Humano e computador começam com 100 pontos de vida.

A cada rodada, cada um pode fazer um dos 3 movimentos:
  - Ataque moderado que dá entre 18 - 25 de dano.
  - Ataque variado que dá entre 10 - 35 de dano.
  - Pode de cura, curando entre 18 - 25 de vida.

A cada movimento, deve ser exibido na tela o que aconteceu e a situação de cada jogador.

Se o jogador ou o computador ficarem com 0 de vida, o jogo acaba.
  - Se alguém perder, ao exibir o resultado final, não deve ser    exibido que algum jogador ficou com a vida negativa.

O jogador humano poderá escolher o nome do seu personagem assim como o nome de seus 3 movimentos. 


## Topicos de estudo recomendados

  - Maps.
  - Structs.
  - Agent.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_mon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_mon, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/ex_mon>.

