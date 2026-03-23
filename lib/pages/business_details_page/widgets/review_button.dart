import 'package:flutter/material.dart';
import 'package:scheduly/models/review_model.dart';
import 'package:uuid/uuid.dart';

class ReviewButton extends StatelessWidget {
  final Function(ReviewModel) onReviewSubmitted;

  const ReviewButton({super.key, required this.onReviewSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showReviewDialog(context);
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      ),
      child: const Text('Write a Review'),
    );
  }

  void showReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => ReviewFormDialog(onReviewSubmitted: onReviewSubmitted),
    );
  }
}

class ReviewFormDialog extends StatefulWidget {
  final Function(ReviewModel) onReviewSubmitted;

  const ReviewFormDialog({super.key, required this.onReviewSubmitted});

  @override
  State<ReviewFormDialog> createState() => _ReviewFormDialogState();
}

class _ReviewFormDialogState extends State<ReviewFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  double _rating = 3.0;

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void submitReview() {
    if (_formKey.currentState!.validate()) {
      final newReview = ReviewModel(
        id: const Uuid().v4(), 
        reviewerName: _nameController.text.trim(),
        rating: _rating,
        comment: _commentController.text.trim(),
        date: DateTime.now(),
      );
      widget.onReviewSubmitted(newReview);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Write a Review'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rating:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _rating,
                      min: 1.0,
                      max: 5.0,
                      divisions: 8,
                      label: _rating.toString(),
                      onChanged: (value) {
                        setState(() {
                          _rating = value;
                        });
                      },
                    ),
                  ),
                  Text(
                    _rating.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Icon(
                    index < _rating.floor()
                        ? Icons.star
                        : (index < _rating
                            ? Icons.star_half
                            : Icons.star_border),
                    color: Colors.amber,
                    size: 24,
                  );
                }),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(
                  labelText: 'Your Review',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                minLines: 3,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please write your review';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: submitReview,
          child: const Text('Submit Review'),
        ),
      ],
    );
  }
}
