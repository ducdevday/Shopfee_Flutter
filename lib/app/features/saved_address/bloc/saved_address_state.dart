part of 'saved_address_bloc.dart';

abstract class SavedAddressState extends Equatable {
  const SavedAddressState();
}

class SavedAddressInitial extends SavedAddressState {
  @override
  List<Object> get props => [];
}

class SavedAddressLoading extends SavedAddressState {
  @override
  List<Object> get props => [];
}

class SavedAddressLoaded extends SavedAddressState {
  final List<Address> addressList;

  const SavedAddressLoaded({
    this.addressList = const [],
  });

  @override
  List<Object> get props => [addressList];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is SavedAddressLoaded &&
              runtimeType == other.runtimeType &&
              addressList == other.addressList);

  @override
  int get hashCode => addressList.hashCode;

  @override
  String toString() {
    return 'SavedAddressLoaded{' + ' addressList: $addressList,' + '}';
  }

  SavedAddressLoaded copyWith({
    List<Address>? addressList,
  }) {
    return SavedAddressLoaded(
      addressList: addressList ?? this.addressList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'addressList': this.addressList,
    };
  }

  factory SavedAddressLoaded.fromMap(Map<String, dynamic> map) {
    return SavedAddressLoaded(
      addressList: map['addressList'] as List<Address>,
    );
  }
}
