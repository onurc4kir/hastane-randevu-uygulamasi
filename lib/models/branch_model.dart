class BranchModel {
  int? branchId;
  String? name;
  String? description;

  BranchModel({this.branchId, this.name, this.description});

  BranchModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    name = json['name'];
    description = json['description'];
  }
}
