class FrequencyDetailModel {
  String? periodo;
  int? frequencia;

  FrequencyDetailModel({
    this.periodo,
    this.frequencia
  });

  factory FrequencyDetailModel.fromJson(Map<String, dynamic>? json){
    if (json == null) {
      return FrequencyDetailModel();
    }
    return FrequencyDetailModel(
      periodo: json['periodo'],
      frequencia: json['frequencia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'periodo': periodo,
      'frequencia': frequencia,
    };
  }
}