abstract class DetailEvent {}

class GetDetail extends DetailEvent{
  final String nome;
  final String? sexo;
  final String? localidade;

  GetDetail({required this.nome, this.sexo, this.localidade});
}