import 'package:flutter/cupertino.dart';

import '../theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) => const Center(
    child: CupertinoActivityIndicator(color: AppColors.authBlue, radius: 12),
  );
}
