import 'package:get_it/get_it.dart';
import 'package:shopfee/features/cart/data/datasources/cart_service.dart';
import 'package:shopfee/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:shopfee/features/cart/domain/repositories/cart_repository.dart';
import 'package:shopfee/features/cart/domain/usecase/cart_usecase.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/change_password/data/datasources/change_password_service.dart';
import 'package:shopfee/features/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:shopfee/features/change_password/domain/repositories/change_password_repository.dart';
import 'package:shopfee/features/change_password/domain/usecase/change_password_usecase.dart';
import 'package:shopfee/features/change_password/presentation/change_password.dart';
import 'package:shopfee/features/choose_address/data/datasources/choose_address_service.dart';
import 'package:shopfee/features/choose_address/data/repositories/choose_address_repository_impl.dart';
import 'package:shopfee/features/choose_address/domain/repositories/choose_address_repository.dart';
import 'package:shopfee/features/choose_address/domain/usecase/choose_address_usecase.dart';
import 'package:shopfee/features/choose_address/presentation/choose_address.dart';
import 'package:shopfee/features/forgot_password/data/datasources/forgot_pasword_service.dart';
import 'package:shopfee/features/forgot_password/data/repositories/forgot_password_repository_impl.dart';
import 'package:shopfee/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:shopfee/features/forgot_password/domain/usecase/forgot_password_usecase.dart';
import 'package:shopfee/features/forgot_password/presentation/forgot_password.dart';
import 'package:shopfee/features/google_map/data/datasources/google_map_service.dart';
import 'package:shopfee/features/google_map/data/repositories/google_map_repository_impl.dart';
import 'package:shopfee/features/google_map/domain/repositories/google_map_repository.dart';
import 'package:shopfee/features/google_map/domain/usecase/google_map_usecase.dart';
import 'package:shopfee/features/google_map/presentation/bloc/google_map_bloc.dart';
import 'package:shopfee/features/history/data/datasources/history_service.dart';
import 'package:shopfee/features/history/data/repositories/history_repository_impl.dart';
import 'package:shopfee/features/history/domain/repositories/history_repository.dart';
import 'package:shopfee/features/history/domain/usecase/history_usecase.dart';
import 'package:shopfee/features/history/presentation/history.dart';
import 'package:shopfee/features/home/data/datasource/home_service.dart';
import 'package:shopfee/features/home/data/repositories/home_repository_impl.dart';
import 'package:shopfee/features/home/domain/repositories/home_repository.dart';
import 'package:shopfee/features/home/domain/usecase/home_usecase.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/login/data/datasources/login_service.dart';
import 'package:shopfee/features/login/data/repositories/login_repository_impl.dart';
import 'package:shopfee/features/login/domain/repositories/login_repository.dart';
import 'package:shopfee/features/login/domain/usecase/login_usecase.dart';
import 'package:shopfee/features/login/presentation/login.dart';
import 'package:shopfee/features/new_address/data/datasources/new_address_service.dart';
import 'package:shopfee/features/new_address/data/repositories/new_address_repository_impl.dart';
import 'package:shopfee/features/new_address/domain/repositories/new_address_repository.dart';
import 'package:shopfee/features/new_address/domain/usecase/new_address_usecase.dart';
import 'package:shopfee/features/new_address/presentation/new_address.dart';
import 'package:shopfee/features/new_password/data/datasources/new_password_service.dart';
import 'package:shopfee/features/new_password/data/repositories/new_password_repository_impl.dart';
import 'package:shopfee/features/new_password/domain/repositories/new_password_repository.dart';
import 'package:shopfee/features/new_password/domain/usecase/new_password_usecase.dart';
import 'package:shopfee/features/new_password/presentation/new_password.dart';
import 'package:shopfee/features/order/data/datasources/order_service.dart';
import 'package:shopfee/features/order/data/repositories/order_repository_impl.dart';
import 'package:shopfee/features/order/domain/repositories/order_repository.dart';
import 'package:shopfee/features/order/domain/usecase/order_usecase.dart';
import 'package:shopfee/features/order/presentation/order.dart';
import 'package:shopfee/features/otp/data/datasources/otp_service.dart';
import 'package:shopfee/features/otp/data/repositories/otp_repository_impl.dart';
import 'package:shopfee/features/otp/domain/repositories/otp_repository.dart';
import 'package:shopfee/features/otp/domain/usecase/otp_usecase.dart';
import 'package:shopfee/features/otp/presentation/otp.dart';
import 'package:shopfee/features/personal_information/data/datasources/personal_information_service.dart';
import 'package:shopfee/features/personal_information/data/repositories/personal_information_repository_impl.dart';
import 'package:shopfee/features/personal_information/domain/repositories/personal_information_repository.dart';
import 'package:shopfee/features/personal_information/domain/usecase/personal_information_usecase.dart';
import 'package:shopfee/features/personal_information/presentation/personal_information.dart';
import 'package:shopfee/features/product_by_category/data/datasources/product_by_category_service.dart';
import 'package:shopfee/features/product_by_category/data/repositories/product_by_category_repository_impl.dart';
import 'package:shopfee/features/product_by_category/domain/repositories/product_by_category_repository.dart';
import 'package:shopfee/features/product_by_category/domain/usecase/product_by_category_usecase.dart';
import 'package:shopfee/features/product_by_category/presentation/product_by_category.dart';
import 'package:shopfee/features/product_detail/data/datasources/product_detail_service.dart';
import 'package:shopfee/features/product_detail/data/repositories/product_detail_repository_impl.dart';
import 'package:shopfee/features/product_detail/domain/repositories/product_detail_repository.dart';
import 'package:shopfee/features/product_detail/domain/usecase/product_detail_usecase.dart';
import 'package:shopfee/features/product_detail/presentation/product_detail.dart';
import 'package:shopfee/features/receipt/data/datasources/receipt_service.dart';
import 'package:shopfee/features/receipt/data/repositories/receipt_repository_impl.dart';
import 'package:shopfee/features/receipt/domain/repositories/receipt_repository.dart';
import 'package:shopfee/features/receipt/domain/usecase/receipt_usecase.dart';
import 'package:shopfee/features/receipt/presentation/receipt.dart';
import 'package:shopfee/features/register/data/datasource/register_service.dart';
import 'package:shopfee/features/register/data/repositories/register_repository_impl.dart';
import 'package:shopfee/features/register/domain/repository/register_repository.dart';
import 'package:shopfee/features/register/domain/usecase/register_usecase.dart';
import 'package:shopfee/features/register/presentation/register.dart';
import 'package:shopfee/features/saved_address/data/datasources/saved_address_service.dart';
import 'package:shopfee/features/saved_address/data/repositories/saved_address_repository_impl.dart';
import 'package:shopfee/features/saved_address/domain/repositories/saved_address_repository.dart';
import 'package:shopfee/features/saved_address/domain/usecase/saved_address_usecase.dart';
import 'package:shopfee/features/saved_address/presentation/saved_address.dart';
import 'package:shopfee/features/search/data/datasources/search_service.dart';
import 'package:shopfee/features/search/data/repositories/search_repository_impl.dart';
import 'package:shopfee/features/search/domain/repositories/search_repository.dart';
import 'package:shopfee/features/search/domain/usecase/search_usecase.dart';
import 'package:shopfee/features/search/presentation/search.dart';
import 'package:shopfee/features/store/data/datasources/store_service.dart';
import 'package:shopfee/features/store/data/repositories/store_repository_impl.dart';
import 'package:shopfee/features/store/domain/repositories/store_repository.dart';
import 'package:shopfee/features/store/domain/usecase/store_usecase.dart';
import 'package:shopfee/features/store/presentation/store.dart';
import 'package:shopfee/features/store_detail/data/datasources/store_detail_service.dart';
import 'package:shopfee/features/store_detail/data/repositories/store_detail_repository_impl.dart';
import 'package:shopfee/features/store_detail/domain/repositories/store_detail_repository.dart';
import 'package:shopfee/features/store_detail/domain/usecase/store_detail_usecase.dart';
import 'package:shopfee/features/store_detail/presentation/store_detail.dart';
import 'package:shopfee/features/tracking/data/datasources/tracking_service.dart';
import 'package:shopfee/features/tracking/data/repositories/tracking_repository_impl.dart';
import 'package:shopfee/features/tracking/domain/repositories/tracking_repository.dart';
import 'package:shopfee/features/tracking/domain/usecase/tracking_usecase.dart';
import 'package:shopfee/features/tracking/presentation/tracking.dart';
import 'package:shopfee/features/user/data/datasources/user_service.dart';
import 'package:shopfee/features/user/data/repositories/user_repository_impl.dart';
import 'package:shopfee/features/user/domain/repositories/user_repository.dart';
import 'package:shopfee/features/user/domain/usecase/user_usecase.dart';
import 'package:shopfee/features/user/presentation/user.dart';
import 'package:shopfee/features/vnpay/data/datasources/vnpay_service.dart';
import 'package:shopfee/features/vnpay/data/repositories/vnpay_repository_impl.dart';
import 'package:shopfee/features/vnpay/domain/repositories/vnpay_repository.dart';
import 'package:shopfee/features/vnpay/domain/usecase/vnpay_usecase.dart';
import 'package:shopfee/features/vnpay/presentation/vnpay.dart';

class ServiceLocator {
  static final sl = GetIt.instance;

  Future<void> init() async {
    _loginFeature();
    _registerFeature();
    _otpFeature();
    _changePasswordFeature();
    _newPasswordFeature();
    _forgotPasswordFeature();
    _userFeature();
    _homeFeature();
    _orderFeature();
    _storeFeature();
    _productByCategoryFeature();
    _searchProductFeature();
    _productDetailFeature();
    _cartFeature();
    _savedAddressFeature();
    _chosenAddressFeature();
    _vnPayFeature();
    _receiptFeature();
    _trackingFeature();
    _historyFeature();
    _newAddressFeature();
    _googleMapFeature();
    _personalInformationFeature();
    _storeDetailInformationFeature();
  }

  void _loginFeature() {
    // //DataSource
    sl.registerLazySingleton(() => LoginService());
    // //Repository
    sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
    // //Usecase
    sl.registerLazySingleton<LoginUseCase>(() => LoginUseCaseImpl(sl()));
    // //Cubit or Bloc
    sl.registerLazySingleton(() => LoginCubit(sl()));
  }

  void _otpFeature() {
    sl.registerLazySingleton(() => OtpService());
    sl.registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl(sl()));
    sl.registerLazySingleton<OtpUseCase>(() => OtpUseCaseImpl(sl()));
    sl.registerFactory(() => OtpCubit(sl()));
  }

  void _changePasswordFeature() {
    sl.registerLazySingleton(() => ChangePasswordService());
    sl.registerLazySingleton<ChangePasswordRepository>(
        () => ChangePasswordRepositoryImpl(sl()));
    sl.registerLazySingleton<ChangePasswordUseCase>(
        () => ChangePasswordUseCaseImpl(sl()));
    sl.registerFactory(() => ChangePasswordCubit(sl()));
  }

  void _userFeature() {
    sl.registerLazySingleton(() => UserService());
    sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
    sl.registerLazySingleton<UserUseCase>(() => UserUseCaseImpl(sl()));
    sl.registerFactory(() => UserBloc(sl()));
  }

  void _homeFeature() {
    sl.registerLazySingleton(() => HomeService());
    sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
    sl.registerLazySingleton<HomeUseCase>(() => HomeUseCaseImpl(sl()));
    sl.registerFactory(() => HomeBloc(sl()));
  }

  void _productByCategoryFeature() {
    sl.registerLazySingleton(() => ProductByCategoryService());
    sl.registerLazySingleton<ProductByCategoryRepository>(
        () => ProductByCategoryRepositoryImpl(sl()));
    sl.registerLazySingleton<ProductByCategoryUseCase>(
        () => ProductByCategoryUseCaseImpl(sl()));
    sl.registerFactory(() => ProductByCategoryBloc(sl()));
  }

  void _searchProductFeature() {
    sl.registerLazySingleton(() => SearchService());
    sl.registerLazySingleton<SearchRepository>(
        () => SearchRepositoryImpl(sl()));
    sl.registerLazySingleton<SearchUseCase>(() => SearchUseCaseImpl(sl()));
    sl.registerFactory(() => SearchCubit(sl()));
  }

  void _productDetailFeature() {
    sl.registerLazySingleton(() => ProductDetailService());
    sl.registerLazySingleton<ProductDetailRepository>(
        () => ProductDetailRepositoryImpl(sl()));
    sl.registerLazySingleton<ProductDetailUseCase>(
        () => ProductDetailUseCaseImpl(sl()));
    sl.registerFactory(() => ProductDetailBloc(sl()));
  }

  void _cartFeature() {
    sl.registerLazySingleton(() => CartService());
    sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
    sl.registerLazySingleton<CartUseCase>(() => CartUseCaseImpl(sl()));
    sl.registerFactory(() => CartBloc(sl()));
  }

  void _savedAddressFeature() {
    sl.registerLazySingleton(() => SavedAddressService());
    sl.registerLazySingleton<SavedAddressRepository>(
        () => SavedAddressRepositoryImpl(sl()));
    sl.registerLazySingleton<SavedAddressUseCase>(
        () => SavedAddressUseCaseImpl(sl()));
    sl.registerFactory(() => SavedAddressBloc(sl()));
  }

  void _vnPayFeature() {
    sl.registerLazySingleton(() => VnPayService());
    sl.registerLazySingleton<VnPayRepository>(() => VnPayRepositoryImpl(sl()));
    sl.registerLazySingleton<VnPayUseCase>(() => VnPayUseCaseImpl(sl()));
    sl.registerFactory(() => VnPayCubit(sl()));
  }

  void _receiptFeature() {
    sl.registerLazySingleton(() => ReceiptService());
    sl.registerLazySingleton<ReceiptRepository>(
        () => ReceiptRepositoryImpl(sl()));
    sl.registerLazySingleton<ReceiptUseCase>(() => ReceiptUseCaseImpl(sl()));
    sl.registerFactory(() => ReceiptBloc(sl()));
  }

  void _trackingFeature() {
    sl.registerLazySingleton(() => TrackingService());
    sl.registerLazySingleton<TrackingRepository>(
        () => TrackingRepositoryImpl(sl()));
    sl.registerLazySingleton<TrackingUseCase>(() => TrackingUseCaseImpl(sl()));
    sl.registerFactory(() => TrackingCubit(sl()));
  }

  void _historyFeature() {
    sl.registerLazySingleton(() => HistoryService());
    sl.registerLazySingleton<HistoryRepository>(
        () => HistoryRepositoryImpl(sl()));
    sl.registerLazySingleton<HistoryUseCase>(() => HistoryUseCaseImpl(sl()));
    sl.registerFactory(() => HistoryBloc(sl()));
  }

  void _newAddressFeature() {
    sl.registerLazySingleton(() => NewAddressService());
    sl.registerLazySingleton<NewAddressRepository>(
        () => NewAddressRepositoryImpl(sl()));
    sl.registerLazySingleton<NewAddressUseCase>(
        () => NewAddressUseCaseImpl(sl()));
    sl.registerFactory(() => NewAddressBloc(sl()));
  }

  void _chosenAddressFeature() {
    sl.registerLazySingleton(() => ChooseAddressService());
    sl.registerLazySingleton<ChooseAddressRepository>(
        () => ChooseAddressRepositoryImpl(sl()));
    sl.registerLazySingleton<ChooseAddressUseCase>(
        () => ChooseAddressUseCaseImpl(sl()));
    sl.registerFactory(() => ChooseAddressBloc(sl()));
  }

  void _googleMapFeature() {
    sl.registerLazySingleton(() => GoogleMapService());
    sl.registerLazySingleton<GoogleMapRepository>(
        () => GoogleMapRepositoryImpl(sl()));
    sl.registerLazySingleton<GoogleMapUseCase>(
        () => GoogleMapUseCaseImpl(sl()));
    sl.registerFactory(() => GoogleMapBloc(sl()));
  }

  void _newPasswordFeature() {
    sl.registerLazySingleton(() => NewPasswordService());
    sl.registerLazySingleton<NewPasswordRepository>(
        () => NewPasswordRepositoryImpl(sl()));
    sl.registerLazySingleton<NewPasswordUseCase>(
        () => NewPasswordUseCaseImpl(sl()));
    sl.registerFactory(() => NewPasswordCubit(sl()));
  }

  void _forgotPasswordFeature() {
    sl.registerLazySingleton(() => ForgotPasswordService());
    sl.registerLazySingleton<ForgotPasswordRepository>(
        () => ForgotPasswordRepositoryImpl(sl()));
    sl.registerLazySingleton<ForgotPasswordUseCase>(
        () => ForgotPasswordUseCaseImpl(sl()));
    sl.registerFactory(() => ForgotPasswordCubit(sl()));
  }

  void _orderFeature() {
    sl.registerLazySingleton(() => OrderService());
    sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));
    sl.registerLazySingleton<OrderUseCase>(() => OrderUseCaseImpl(sl()));
    sl.registerFactory(() => OrderBloc(sl()));
  }

  void _personalInformationFeature() {
    sl.registerLazySingleton(() => PersonalInformationService());
    sl.registerLazySingleton<PersonalInformationRepository>(
        () => PersonalInformationRepositoryImpl(sl()));
    sl.registerLazySingleton<PersonalInformationUseCase>(
        () => PersonalInformationUseCaseImpl(sl()));
    sl.registerFactory(() => PersonalInformationCubit(sl()));
  }

  void _registerFeature() {
    sl.registerLazySingleton(() => RegisterService());
    sl.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImpl(sl()));
    sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCaseImpl(sl()));
    sl.registerFactory(() => RegisterCubit(sl()));
  }

  void _storeFeature() {
    sl.registerLazySingleton(() => StoreService());
    sl.registerLazySingleton<StoreRepository>(() => StoreRepositoryImpl(sl()));
    sl.registerLazySingleton<StoreUseCase>(() => StoreUseCaseImpl(sl()));
    sl.registerFactory(() => StoreBloc(sl()));
  }

  void _storeDetailInformationFeature() {
    sl.registerLazySingleton(() => StoreDetailService());
    sl.registerLazySingleton<StoreDetailRepository>(() => StoreDetailRepositoryImpl(sl()));
    sl.registerLazySingleton<StoreDetailUseCase>(() => StoreDetailUseCaseImpl(sl()));
    sl.registerFactory(() => StoreDetailBloc(sl()));
  }
}
