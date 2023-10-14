import 'package:equatable/equatable.dart';

enum TypeVoucher { Money, Percent;
  String toJson() => name;

  static TypeVoucher fromJson(String json) => values.byName(json);
}

class Voucher extends Equatable {
  final String id;
  final String name; // Tên hiển thị của voucher
  final String code; // Mã code voucher
  final TypeVoucher type; // Loại voucher, giá trị giảm tiền mặt hoặc giảm theo phần trăm
  final double value; // 20,000đ hoặc 20%
  final double minium; // Giá trị đơn hàng tối thiểu để áp dụng
  final double upto; // Tiền mặt được giảm tối đa khi sử dụng loại voucher theo %
  //! final DateTime expiry // Hạn sử dụng của vouchcer, có thể cân nhắc đưa cái này vô
  const Voucher({
    required this.id,
    required this.name,
    required this.code,
    required this.type,
    required this.value,
    required this.minium,
    required this.upto,
  });

  @override
  List<Object?> get props => [id, code, value];

  static List<Voucher> vouchers = [
    Voucher(
        id: "1",
        name: "Disc 25.000đ",
        code: 'SAVE25M',
        type: TypeVoucher.Money,
        value: 25000,
        minium: 50000,
        upto: 0),
    Voucher(
        id: "2",
        name: "Disc 50.000đ",
        code: 'SAVE50M',
        type: TypeVoucher.Money,
        value: 50000,
        minium: 75000,
        upto: 0),
    Voucher(
        id: "3",
        name: "Disc 75.000đ",
        code: 'SAVE75M',
        type: TypeVoucher.Money,
        value: 75000,
        minium: 100000,
        upto: 0),
  ];

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      type: TypeVoucher.fromJson(json["type"]),
      value: json["value"] as double,
      minium:json["minium"] as double,
      upto: json["upto"] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "code": this.code,
      "type": this.type,
      "value": this.value,
      "minium": this.minium,
      "upto": this.upto,
    };
  }
}
