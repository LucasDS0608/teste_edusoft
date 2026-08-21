abstract class DetailEvent {}

class GetDetail extends DetailEvent{
  final String nome;

  GetDetail({required this.nome});
}