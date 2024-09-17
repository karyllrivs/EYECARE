import 'package:eyecare_mobile/model/rating.model.dart';
import 'package:eyecare_mobile/pages/rating/star_rating.dart';
import 'package:eyecare_mobile/shared/helpers/dialog.helper.dart';
import 'package:eyecare_mobile/shared/helpers/validators.dart';
import 'package:eyecare_mobile/shared/widgets/bottom_navbar.dart';
import 'package:eyecare_mobile/shared/widgets/navbar.dart';
import 'package:eyecare_mobile/view_model/rating.view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRating extends StatefulWidget {
  final String productId;
  const AddRating({super.key, required this.productId});

  @override
  State<AddRating> createState() => _AddRatingState();
}

class _AddRatingState extends State<AddRating> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _reviewCtrl = TextEditingController();

  int rating = 0;

  void onRatingChanged(newRating) {
    setState(() {
      rating = newRating;
    });
  }

  Future<void> addRating() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? userId = prefs.getString('ec_user_token');
        Rating newRating = Rating(
          id: "",
          userId: userId!,
          productId: widget.productId,
          review: _reviewCtrl.text,
          rating: rating,
        );

        if (mounted) {
          await context.read<RatingViewModel>().createRating(newRating);
        }

        if (mounted) {
          showResultDialog(context, true,
              message: "Rating successfully updated.");
        }
      } catch (e) {
        if (mounted) showResultDialog(context, false, message: e.toString());
      }
    }
  }

  @override
  void dispose() {
    _formKey.currentState!.dispose();
    _reviewCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: const Nav(title: "Rate Product", isAuth: true),
      bottomNavigationBar: const BottomNavbar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _reviewCtrl,
                validator: (value) => requiredValidator(value),
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product Quality",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeData.colorScheme.onPrimary,
                  ),
                ),
                StarRating(rating: rating, onRatingChanged: onRatingChanged),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                addRating();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: themeData.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Add review",
                  style: TextStyle(
                    color: themeData.colorScheme.surface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
