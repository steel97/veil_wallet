class AddressModel {
  final int id;
  final String label;
  final String address;

  AddressModel(this.id, this.label, this.address);

  AddressModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        label = json['label'] as String,
        address = json['address'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'address': address,
      };
}
