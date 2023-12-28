import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/cart.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/models/type_payment.dart';
import 'package:shopfee/data/models/voucher.dart';
import 'package:shopfee/data/repositories/address/address_repository.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends HydratedBloc<CartEvent, CartState> {
  final OrderRepository orderRepository;
  final AddressRepository addressRepository;
  final FirebaseRepository firebaseRepository;

  CartBloc({
    required this.orderRepository,
    required this.addressRepository,
    required this.firebaseRepository,
  }) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<DeleteCart>(_onDeleteCart);
    on<AddItemIntoCart>(_onAddItemIntoCart);
    on<UpdateItemInCart>(_onUpdateItemInCart);
    on<InitAddress>(_onInitAddress);
    on<ChooseAddress>(_onChooseAddress);
    on<ChooseTypePayment>(_onChooseTypePayment);
    on<AddNote>(_onAddNote);
    on<CreateShippingOrder>(_onCreateShippingOrder);
  }

  FutureOr<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    if (state is! CartLoaded) {
      emit(CartLoaded(cart: Cart()));
    }
  }

  FutureOr<void> _onDeleteCart(DeleteCart event, Emitter<CartState> emit) {
    emit(CartLoaded(cart: Cart()));
  }

  FutureOr<void> _onInitAddress(
      InitAddress event, Emitter<CartState> emit) async {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      try {
        var response =
            await addressRepository.getAllAddress(GlobalData.ins.userId!);
        if (response.success) {
          final List<Address> addressList =
              response.data!.map((e) => Address.fromMap(e)).toList();
          if (addressList.isNotEmpty) {
            final Address defaultAddress =
                addressList.firstWhere((address) => address.isDefault == true);
            var responseDefaultAddress =
                await addressRepository.getAddress(defaultAddress.id!);
            late Address address;
            if (responseDefaultAddress.success) {
              address = Address.fromMapFull(responseDefaultAddress.data!);
            }
            emit(CartLoaded(
              cart: currentState.cart.copyWith(
                address: address,
              ),
            ));
          }
        }
      } catch (e) {
        print(e);
      }
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
        if (existingOrderIndex != -1 && existingOrderIndex != event.index) {
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
      } catch (e) {}
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
      late String orderId;
      try {
        EasyLoading.show();
        var response = await orderRepository.createShippingOrder(
            successState.cart, GlobalData.ins.userId!);
        EasyLoading.dismiss();
        if (response.success) {
          orderId = response.data!["orderId"];
          final String transactionId = response.data!["transactionId"];
          final String? paymentUrl = response.data!["paymentUrl"];
          if (paymentUrl == null) {
            emit(CartFinished(orderId: orderId));
          } else {
            emit(CartFinished(
                orderId: orderId,
                transactionId: transactionId,
                paymentUrl: paymentUrl));
          }
          add(LoadCart());
        } else {
          EasyLoading.showError(response.message);
        }
        var responseNotify = await firebaseRepository.sendOrderMessage(
            "Shopfee For Employee Announce",
            "The order $orderId was created. Please tap to see details",
            orderId);
      } catch (e) {
        EasyLoading.showError(e.toString());
      }
    }
  }

  @override
  CartState? fromJson(Map<String, dynamic> json) {
    return CartLoaded.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(CartState state) {
    if (state is CartInitial) {
      return state.toJson();
    } else if (state is CartLoading) {
      return state.toJson();
    } else if (state is CartLoaded) {
      return state.toJson();
    } else if (state is CartFinished) {
      return state.toJson();
    }
    return null;
  }
}
