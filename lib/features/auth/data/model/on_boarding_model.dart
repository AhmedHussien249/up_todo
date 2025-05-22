
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_texts.dart';

class OnBoardingModel {

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
  final String image;
  final String title;
  final String subTitle;

  static List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      image: AppAssets.on1,
      title: AppTexts.onBoardingTitle1,
      subTitle: AppTexts.onBoardingSubTitle1,
    ),
    OnBoardingModel(
      image: AppAssets.on2,
      title: AppTexts.onBoardingTitle2,
      subTitle: AppTexts.onBoardingSubTitle2,
    ),
    OnBoardingModel(
      image: AppAssets.on3,
      title: AppTexts.onBoardingTitle3,
      subTitle: AppTexts.onBoardingSubTitle3,
    ),
  ];
}
