import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/cart.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/models/voucher.dart';
import 'package:shopfee/data/repositories/address/address_repository.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final OrderRepository orderRepository;
  final AddressRepository addressRepository;

  CartBloc({required this.orderRepository, required this.addressRepository})
      : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddItemIntoCart>(_onAddItemIntoCart);
    on<UpdateItemInCart>(_onUpdateItemInCart);
    on<ChooseAddress>(_onChooseAddress);
    on<ChooseTypePayment>(_onChooseTypePayment);
    on<AddNote>(_onAddNote);
    on<CreateShippingOrder>(_onCreateShippingOrder);
  }

  FutureOr<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      var response =
          await addressRepository.getAllAddress(GlobalData.ins.userId!);
      if (response.success) {
        final List<Address> addressList =
            response.data!.map((e) => Address.fromMap(e)).toList();
        final Address defaultAddress =
            addressList.firstWhere((address) => address.isDefault == true);
        var responseDefaultAddress =
            await addressRepository.getAddress(defaultAddress.id!);
        late Address address;
        if (responseDefaultAddress.success) {
          address = Address.fromMapFull(responseDefaultAddress.data!);
        }
        emit(CartLoaded(
            cart: Cart(address: address, typePayment: TypePayment.CASHING)));
      }
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _onAddItemIntoCart(
      AddItemIntoCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      List<Order> orders = List.from(successState.cart.orders);
      final existingOrderIndex = orders
          .indexWhere((order) => order.isEqualExceptQuantity(event.order));

      if (existingOrderIndex != -1) {
        // Nếu "event.order" đã tồn tại trong danh sách "orders"
        orders[existingOrderIndex] = orders[existingOrderIndex].copyWith(
            quantity:
                orders[existingOrderIndex].quantity + event.order.quantity);
      } else {
        // Nếu "event.order" chưa tồn tại trong danh sách "orders"
        orders.add(event.order);
      }

      emit(CartLoaded(
        cart: successState.cart.copyWith(
          orders: orders,
        ),
      ));
    }
  }

  FutureOr<void> _onUpdateItemInCart(
      UpdateItemInCart event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      List<Order> orders = List.from(successState.cart.orders);
      if (event.updatedOrder.quantity == 0) {
        orders.removeAt(event.index);
      } else {
        final existingOrderIndex = orders.indexWhere(
            (order) => order.isEqualExceptQuantity(event.updatedOrder));
        if (existingOrderIndex != -1) {
          orders[existingOrderIndex] = orders[existingOrderIndex].copyWith(
              quantity: orders[existingOrderIndex].quantity +
                  event.updatedOrder.quantity);
          orders.removeAt(event.index);
        } else {
          orders[event.index] = event.updatedOrder;
        }
      }
      emit(CartLoaded(
        cart: successState.cart.copyWith(
          orders: orders,
        ),
      ));
    }
  }

  FutureOr<void> _onChooseAddress(
      ChooseAddress event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      try {
        final successState = state as CartLoaded;
        EasyLoading.show();
        var response = await addressRepository.getAddress(event.addressId);
        EasyLoading.dismiss();
        late Address address;
        if (response.success) {
          address = Address.fromMapFull(response.data!);
          emit(CartLoaded(cart: successState.cart.copyWith(address: address)));
        }
      } catch (e) {

      }
    }
  }

  FutureOr<void> _onChooseTypePayment(
      ChooseTypePayment event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      emit(CartLoaded(
          cart: successState.cart.copyWith(typePayment: event.typePayment)));
    }
  }

  FutureOr<void> _onAddNote(AddNote event, Emitter<CartState> emit) {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      emit(CartLoaded(cart: successState.cart.copyWith(note: event.note)));
    }
  }

  FutureOr<void> _onCreateShippingOrder(
      CreateShippingOrder event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final successState = state as CartLoaded;
      try {
        EasyLoading.show();
        var response = await orderRepository.createShippingOrder(
            successState.cart, GlobalData.ins.userId!);
        EasyLoading.dismiss();
        if (response.success) {
          final String orderId = response.data!["orderId"];
          final String invoiceCode = response.data!["invoiceCode"];
          emit(CartFinished(orderId: orderId));
          add(LoadCart());
        } else {
          EasyLoading.showError(response.message);
        }
      } catch (e) {
        EasyLoading.showError(e.toString());
      }
    }
  }
}
