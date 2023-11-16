import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/review/cubit/review_cubit.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

class ReviewScreen extends StatelessWidget {
  final String orderId;

  const ReviewScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review"),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            ReviewCubit(orderRepository: context.read<OrderRepository>())
              ..initReview(),
        child: BlocConsumer<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is ReviewFinished) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is ReviewLoaded) {
              return Padding(
                padding: EdgeInsets.all(AppDimen.screenPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/images/img_review.svg",
                          width: 225,
                          height: 225,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "How's your order this time?",
                          style: AppStyle.largeTitleStyleDark,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Rating",
                        style: AppStyle.mediumTitleStyleDark
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RatingBar(
                            minRating: 0,
                            maxRating: 5,
                            glow: false,
                            ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                ),
                                half: Icon(
                                  Icons.star_half_rounded,
                                  color: Colors.amber,
                                ),
                                empty: Icon(
                                  Icons.star_outline_rounded,
                                  color: Colors.grey,
                                )),
                            onRatingUpdate: (value) =>
                                {context.read<ReviewCubit>().rateStar(value.toInt())}),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 4,
                        color: Color(0xffEFEBE9),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Review",
                        style: AppStyle.mediumTitleStyleDark
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ReviewForm(),
                      Text(
                        "*Reviews won’t be visible to the public.",
                        style: AppStyle.normalTextStyleDark,
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: state.isValid ? () {
                                  context.read<ReviewCubit>().sendReview(orderId);
                                } : null,
                                child: Text("Send Review"),
                                style: AppStyle.elevatedButtonStylePrimary),
                              ))
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class ReviewForm extends StatefulWidget {
  const ReviewForm({Key? key}) : super(key: key);

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if(state is ReviewLoaded){
          return TextField(
            minLines: 6,
            maxLines: 10,
            onChanged: (value) => {
              context.read<ReviewCubit>().writeContent(value)
            },
            style: TextStyle(fontSize: 14),
            maxLength: 100,
            decoration: InputDecoration(
              counterText: "${state.content.length}/100",
              contentPadding: EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(8)),
              hintText: "Tell us about your order experience",
            ),
          );
        }
        else{
          return SizedBox();
        }
      },
    );
  }
}
