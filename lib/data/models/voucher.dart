import 'package:equatable/equatable.dart';

enum TypeVoucher { Money, Percent }

class Voucher extends Equatable {
  final String id;
  final String name;
  final String code;
  final TypeVoucher type;
  final double value;
  final double minium;
  final double upto;

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
}
