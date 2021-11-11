class Product {
  final List<ChartApiModel> data;
  Product({required this.data});

  factory Product.fromJson(List<dynamic> jsonData) {
    //var list = jsonData['data']['result'] as List;
    List<ChartApiModel> dataList = [];
    dataList = jsonData.map((i) => ChartApiModel.fromJson(i)).toList();

    //list.map((e) => ChartApiModel.fromJson(e)).toList();
    return Product(
      data: dataList,
    );
  }
}

class ChartApiModel {
  double newCases, newDeaths, newVaccinations;
  ChartApiModel({
    required this.newCases,
    required this.newDeaths,
    required this.newVaccinations,
  });

  factory ChartApiModel.fromJson(Map<String, dynamic> jsonData) {
    return ChartApiModel(
        newCases: jsonData['new_cases'] as double,
        newDeaths: jsonData['new_deaths'] as double,
        newVaccinations: jsonData['new_vaccinations'] as double);
  }
}
